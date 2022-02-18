import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:professional_grupo_vista_app/models/service_request_model.dart';

class ServiceRequestProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference serviceRequests =
      FirebaseFirestore.instance.collection('serviceRequests');

  static Stream<QuerySnapshot<ServiceRequestModel>> getAllServiceRequests() =>
      serviceRequests
          .where(
            'type',
            isEqualTo: 'Administradores',
          )
          .orderBy('dateTime', descending: true)
          .withConverter<ServiceRequestModel>(
              fromFirestore: (snapshot, _) =>
                  ServiceRequestModel.fromJson(snapshot.data()!),
              toFirestore: (messages, _) => messages.toJson())
          .snapshots();
}
