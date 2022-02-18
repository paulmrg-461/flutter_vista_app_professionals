import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:professional_grupo_vista_app/models/professional_model.dart';

class UserProvider with ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential? _userCredentials;
  UserCredential get userCredentials => _userCredentials!;
  bool _isLogging = false;
  bool get isLogging => _isLogging;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference professionals =
      FirebaseFirestore.instance.collection('professionals');
  late FirebaseMessaging messaging;

  Future<String> login(String email, String password) async {
    _isLogging = true;
    try {
      _userCredentials = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      String _token = await auth.currentUser!.getIdToken();

      //Save token in KeyChain - KeyStore
      await _saveToken(_token);
      await _saveUID(_userCredentials!.user!.uid);
      messaging = FirebaseMessaging.instance;
      messaging.getToken().then((value) {
        _setFCMToken(value);
        print('FCMToken: $value');
        professionals
            .doc(_userCredentials!.user!.email)
            .update({
              'deviceTokens': FieldValue.arrayUnion([value])
            })
            // .update({'deviceTokens': value})
            .then((value) => print("Professional updated"))
            .catchError((error) => print("Failed to update user: $error"));
      });
      _isLogging = false;
      return "Login success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _isLogging = false;
        return 'Usuario no encontrado, inicia el proceso de registro e intenta nuevamente.';
      } else if (e.code == 'wrong-password') {
        _isLogging = false;
        return 'Usuario o Contraseña incorrectos.';
      }
      return 'Credenciales incorrectas, por favor intenta nuevamente.';
    }
  }

  Future<String> register(String name, String id, String address, String email,
      String password, String profession, String specialty) async {
    FirebaseApp app = await Firebase.initializeApp(
        name: 'Secondary', options: Firebase.app().options);
    try {
      FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        messaging = FirebaseMessaging.instance;
        messaging.getToken().then((value) {
          _setFCMToken(value);
          print('FCMToken: $value');
          professionals
              .doc(email)
              .set({
                'name': name,
                'id': id,
                'address': address,
                'email': email,
                'photoUrl':
                    'https://forofarp.org/wp-content/uploads/2017/06/silueta-1.jpg',
                'isEnable': true,
                'isAdmin': false,
                'registerDate': DateTime.now(),
                'profession': profession,
                'specialty': specialty,
                'deviceTokens': [value]
              })
              .then((value) async => await app.delete())
              .catchError(
                  (error) => print("Failed to add professional: $error"));
        });
      });

      return "Registration success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Contraseña demasiado débil, por favor intenta nuevamente.';
      } else if (e.code == 'email-already-in-use') {
        return 'Ya existe una cuenta asociada a ese correo, por favor ingresa uno diferente.';
      }
      return 'Error en el proceso de registro, por favor intenta nuevamente.';
    }
  }

  Future<bool> logout() async {
    try {
      await _storage.delete(key: 'token');
      await _storage.delete(key: 'uid');
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<ProfessionalModel> getUserInformation() async {
    try {
      final userInformationRef = firestore
          .collection('professionals')
          .where("email", isEqualTo: auth.currentUser!.email)
          .withConverter<ProfessionalModel>(
            fromFirestore: (snapshot, _) =>
                ProfessionalModel.fromJson(snapshot.data()!),
            toFirestore: (programming, _) => programming.toJson(),
          );
      QuerySnapshot querySnapshot = await userInformationRef.get();
      final List<ProfessionalModel> userInformation = querySnapshot.docs
          .map((doc) => doc.data() as ProfessionalModel)
          .toList();

      return userInformation[0];
    } catch (e) {
      print(e);
      return ProfessionalModel();
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future _saveUID(String token) async {
    return await _storage.write(key: 'uid', value: token);
  }

  Future<void> _setFCMToken(String? token) async {
    const FlutterSecureStorage _storage = FlutterSecureStorage();
    await _storage.write(key: 'fcmToken', value: token);
  }
}
