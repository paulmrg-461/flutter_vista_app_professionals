import 'package:cloud_firestore/cloud_firestore.dart';

class ProfessionalModel {
  final String? uid;
  final String? email;
  final String? name;
  final String? address;
  final bool? isEnable;
  final bool? isAdmin;
  final String? photoUrl;
  final String? profession;
  final String? specialty;
  final DateTime? registerDate;
  final String? id;
  final List<dynamic>? deviceTokens;

  ProfessionalModel({
    this.uid,
    this.email,
    this.name,
    this.address,
    this.isEnable,
    this.isAdmin,
    this.photoUrl,
    this.profession,
    this.specialty,
    this.registerDate,
    this.id,
    this.deviceTokens,
  });

  ProfessionalModel.fromJson(Map<String, Object?> json)
      : this(
          uid: (json['uid'] != null) ? json['uid']! as String : '',
          email: (json['email'] != null) ? json['email']! as String : '',
          name: (json['name'] != null) ? json['name']! as String : '',
          address: (json['address'] != null) ? json['address']! as String : '',
          isEnable: json['isEnable']! as bool,
          isAdmin: json['isAdmin']! as bool,
          photoUrl:
              (json['photoUrl'] != null) ? json['photoUrl']! as String : '',
          profession:
              (json['profession'] != null) ? json['profession']! as String : '',
          specialty:
              (json['specialty'] != null) ? json['specialty']! as String : '',
          registerDate: (json['registerDate']! as Timestamp).toDate(),
          id: (json['id'] != null) ? json['id']! as String : '',
          deviceTokens: (json['deviceTokens'] != null)
              ? json['deviceTokens']! as List<dynamic>
              : [],
        );
  Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'address': address,
      'isEnable': isEnable,
      'isAdmin': isAdmin,
      'photoUrl': photoUrl,
      'profession': profession,
      'specialty': specialty,
      'registerDate': registerDate,
      'id': id,
      'deviceTokens': deviceTokens,
    };
  }
}
