import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:professional_grupo_vista_app/models/message_model.dart';
import 'package:professional_grupo_vista_app/models/professional_model.dart';

class MessagesProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  static Stream<QuerySnapshot<MessageModel>> getLastMessages(
      ProfessionalModel professionalModel) {
    CollectionReference messagesByProfession = FirebaseFirestore.instance
        .collection(
            'messages/${professionalModel.profession}/${professionalModel.email}');
    return messagesByProfession
        // .doc(professionalModel.email)
        // .collection(professionalModel.email)
        .orderBy('date', descending: true)
        .orderBy('senderId', descending: true)
        .withConverter<MessageModel>(
            fromFirestore: (snapshot, _) =>
                MessageModel.fromJson(snapshot.data()!),
            toFirestore: (messages, _) => messages.toJson())
        .snapshots();
  }
}
