import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceRequestModel {
  final String? email;
  final String? name;
  final String? photoUrl;
  final DateTime? dateTime;
  final String? type;

  ServiceRequestModel({
    this.email,
    this.name,
    this.photoUrl,
    this.dateTime,
    this.type,
  });

  ServiceRequestModel.fromJson(Map<String, Object?> json)
      : this(
            email: (json['email'] != null) ? json['email']! as String : '',
            name: (json['name'] != null) ? json['name']! as String : '',
            photoUrl:
                (json['photoUrl'] != null) ? json['photoUrl']! as String : '',
            dateTime: (json['dateTime']! as Timestamp).toDate(),
            type: (json['type'] != null) ? json['type']! as String : '');
  Map<String, Object?> toJson() {
    return {
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'dateTime': dateTime,
      'type': type,
    };
  }
}
