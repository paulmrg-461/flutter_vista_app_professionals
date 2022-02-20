import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:professional_grupo_vista_app/models/message_model.dart';
import 'package:professional_grupo_vista_app/models/professional_model.dart';
import 'package:professional_grupo_vista_app/models/user_model.dart';

class MessagesProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static Future<Iterable<Stream<QuerySnapshot<MessageModel>>>> getLastMessages(
          ProfessionalModel professionalModel) =>
      users
          .withConverter<UserModel>(
              fromFirestore: (snapshot, _) =>
                  UserModel.fromJson(snapshot.data()!),
              toFirestore: (messages, _) => messages.toJson())
          .get()
          .then((usr) => usr.docs.map((doc) {
                final UserModel userModel = doc.data();
                return FirebaseFirestore.instance
                    .doc('messages/${userModel.email}')
                    .collection('userMessages')
                    .where('senderId', isEqualTo: professionalModel.email)
                    .orderBy('date', descending: true)
                    .limit(1)
                    .withConverter<MessageModel>(
                        fromFirestore: (snapshot, _) =>
                            MessageModel.fromJson(snapshot.data()!),
                        toFirestore: (messages, _) => messages.toJson())
                    .snapshots();
              }));
  static void sendNewMessage(MessageModel messageModel) => messages
      .doc(messageModel.userEmail)
      .collection('userMessages')
      .add(messageModel.toJson());
}
