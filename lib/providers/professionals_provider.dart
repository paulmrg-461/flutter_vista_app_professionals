import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:professional_grupo_vista_app/models/professional_model.dart';

class ProfessionalsProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference professionals =
      FirebaseFirestore.instance.collection('professionals');

  static Stream<QuerySnapshot<ProfessionalModel>> getAllProfessionals() =>
      professionals
          .orderBy('registerDate', descending: true)
          .withConverter<ProfessionalModel>(
              fromFirestore: (snapshot, _) =>
                  ProfessionalModel.fromJson(snapshot.data()!),
              toFirestore: (messages, _) => messages.toJson())
          .snapshots();

  static void changeProfessionalStatus(String action, String email) =>
      professionals
          .doc(email)
          .update({'isEnable': action == 'isEnabled' ? false : true})
          .then((value) => print("Professional updated"))
          .catchError((error) => print("Failed to update user: $error"));

  static Future<bool> editProfessional(String name, String id, String address,
          String profession, String specialty, String email) =>
      professionals
          .doc(email)
          .update({
            'name': name,
            'id': id,
            'address': address,
            'profession': profession,
            'specialty': specialty,
          })
          .then((value) => true)
          .catchError((error) => false);
}
