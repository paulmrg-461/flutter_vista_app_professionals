import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:professional_grupo_vista_app/models/message_model.dart';
import 'package:professional_grupo_vista_app/models/professional_model.dart';
import 'package:professional_grupo_vista_app/models/user_model.dart';

class MessagesProvider {
  static firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static Future<Iterable<Stream<QuerySnapshot<MessageModel>>>>
      getAllLastMessages() => users
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
                    .orderBy('date', descending: true)
                    .limit(1)
                    .withConverter<MessageModel>(
                        fromFirestore: (snapshot, _) =>
                            MessageModel.fromJson(snapshot.data()!),
                        toFirestore: (messages, _) => messages.toJson())
                    .snapshots();
              }));

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
                    .where('professionalEmail',
                        isEqualTo: professionalModel.email)
                    .orderBy('date', descending: true)
                    .limit(1)
                    .withConverter<MessageModel>(
                        fromFirestore: (snapshot, _) =>
                            MessageModel.fromJson(snapshot.data()!),
                        toFirestore: (messages, _) => messages.toJson())
                    .snapshots();
              }));

  static Stream<QuerySnapshot<MessageModel>> getChatroomMessages(
          MessageModel messageModel) =>
      FirebaseFirestore.instance
          .doc('messages/${messageModel.userEmail}')
          .collection('userMessages')
          .where('professionalEmail', isEqualTo: messageModel.professionalEmail)
          .where('userEmail', isEqualTo: messageModel.userEmail)
          .orderBy('date', descending: true)
          .withConverter<MessageModel>(
              fromFirestore: (snapshot, _) =>
                  MessageModel.fromJson(snapshot.data()!),
              toFirestore: (messages, _) => messages.toJson())
          .snapshots();

  static Future<void> updateSeenMessage(
          String userEmail, String professionalEmail) =>
      FirebaseFirestore.instance
          .doc('messages/$userEmail')
          .collection('userMessages')
          .where('professionalEmail', isEqualTo: professionalEmail)
          .where('senderId', isEqualTo: userEmail)
          .get()
          .then((msg) => msg.docs.map((doc) => FirebaseFirestore.instance
              .doc('messages/$userEmail')
              .collection('userMessages')
              .doc(doc.id)
              .set({'seen': true})));

  static void sendNewMessage(MessageModel messageModel) => messages
      .doc(messageModel.userEmail)
      .collection('userMessages')
      .add(messageModel.toJson());

  static Future<String> uploadFile(File file, String path) async {
    try {
      final firebase_storage.TaskSnapshot taskSnapshot =
          await storage.ref(path).putFile(file);

      return await (await taskSnapshot).ref.getDownloadURL();
    } on FirebaseException catch (e) {
      print(e);
      return 'Error';
    }
  }
}
