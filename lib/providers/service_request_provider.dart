import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:professional_grupo_vista_app/models/professional_model.dart';
import 'package:professional_grupo_vista_app/models/service_request_model.dart';

class ServiceRequestProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference serviceRequests =
      FirebaseFirestore.instance.collection('serviceRequests');

  static CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  static Stream<QuerySnapshot<ServiceRequestModel>> getAllServiceRequests(
          String profession) =>
      serviceRequests
          .where(
            'type',
            isEqualTo: profession,
          )
          .orderBy('dateTime', descending: true)
          .withConverter<ServiceRequestModel>(
              fromFirestore: (snapshot, _) =>
                  ServiceRequestModel.fromJson(snapshot.data()!),
              toFirestore: (messages, _) => messages.toJson())
          .snapshots();

  static Stream<QuerySnapshot<ServiceRequestModel>>
      getAllAdminServiceRequests() => serviceRequests
          .orderBy('dateTime', descending: true)
          .withConverter<ServiceRequestModel>(
              fromFirestore: (snapshot, _) =>
                  ServiceRequestModel.fromJson(snapshot.data()!),
              toFirestore: (messages, _) => messages.toJson())
          .snapshots();

  static Future<bool> acceptService(ProfessionalModel professionalModel,
          ServiceRequestModel serviceRequestModel) =>
      messages
          .doc(serviceRequestModel.email)
          .collection('userMessages')
          .add({
            'message':
                'Hola ${serviceRequestModel.name}, mucho gusto. Mi nombre es ${professionalModel.name} y estoy dispuesto a atender tu solicitud de ${serviceRequestModel.type}... ¿cuéntame en qué puedo colaborarte?',
            'isProfessional': true,
            'senderId': professionalModel.email,
            'professionalName': professionalModel.name,
            'professionalEmail': professionalModel.email,
            'professionalPhotoUrl': professionalModel.photoUrl,
            'userName': serviceRequestModel.name,
            'userEmail': serviceRequestModel.email,
            'userPhotoUrl': serviceRequestModel.photoUrl,
            'receiverId': serviceRequestModel.email,
            'seen': false,
            'date': DateTime.now(),
            'type': serviceRequestModel.type,
          })
          .then((value) => serviceRequests
              .doc('${serviceRequestModel.type}|${serviceRequestModel.email}')
              .delete()
              .then((value) => true)
              .catchError((onError) => false))
          .catchError((error) => false);
}
