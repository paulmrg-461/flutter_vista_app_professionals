import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? email;
  final String? name;
  final bool? isEnable;
  final String? photoUrl;
  final DateTime? registerDate;
  final String? deviceId;
  final List<dynamic>? deviceTokens;

  UserModel({
    this.email,
    this.name,
    this.isEnable,
    this.photoUrl,
    this.registerDate,
    this.deviceId,
    this.deviceTokens,
  });

  UserModel.fromJson(Map<String, Object?> json)
      : this(
          email: (json['clientEmail'] != null)
              ? json['clientEmail']! as String
              : '',
          name:
              (json['clientName'] != null) ? json['clientName']! as String : '',
          isEnable: json['clientEnable']! as bool,
          photoUrl: (json['clientPhotoURL'] != null)
              ? json['clientPhotoURL']! as String
              : '',
          registerDate: (json['clientRegisterDate']! as Timestamp).toDate(),
          deviceId:
              (json['deviceId'] != null) ? json['deviceId']! as String : '',
          deviceTokens: (json['deviceTokens'] != null)
              ? json['deviceTokens']! as List<dynamic>
              : [],
        );
  Map<String, Object?> toJson() {
    return {
      'email': email,
      'name': name,
      'isEnable': isEnable,
      'photoUrl': photoUrl,
      'registerDate': registerDate,
      'deviceId': deviceId,
      'deviceTokens': deviceTokens,
    };
  }
}
