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

  static Future<bool> acceptService(ProfessionalModel professionalModel,
          ServiceRequestModel serviceRequestModel) =>
      messages
          .doc(serviceRequestModel.type)
          .collection('${professionalModel.email}|${serviceRequestModel.email}')
          .doc()
          .set({
            'title': 'Tienes un mensaje de ${professionalModel.name}',
            'body':
                'Hola ${serviceRequestModel.name}, mucho gusto. Mi nombre es ${professionalModel.name} y estoy dispuesto a atender tu solicitud de ${serviceRequestModel.type}... Cuéntame en qué puedo colaborarte!',
            'isProfessional': true,
            'senderId': professionalModel.email,
            'photoUrl': professionalModel.photoUrl,
            'receiverId': serviceRequestModel.email,
            'seen': '0',
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
