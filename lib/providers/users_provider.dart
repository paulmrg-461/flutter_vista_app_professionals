import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:professional_grupo_vista_app/models/user_model.dart';

class UsersProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static Stream<QuerySnapshot<UserModel>> getAllUsers() => users
      .orderBy('clientRegisterDate', descending: true)
      .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (messages, _) => messages.toJson())
      .snapshots();

  static void changeUserStatus(String action, String email) => users
      .doc(email)
      .update({'clientEnable': action == 'isEnabled' ? false : true})
      .then((value) => print("User updated"))
      .catchError((error) => print("Failed to update user: $error"));
}
