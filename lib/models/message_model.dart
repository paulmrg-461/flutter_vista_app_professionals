import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String? userName;
  final String? professionalName;
  final String? userEmail;
  final String? professionalEmail;
  final String? message;
  final bool? isProfessional;
  final bool? seen;
  final String? professionalPhotoUrl;
  final String? userPhotoUrl;
  final DateTime? date;
  final String? senderId;
  final String? receiverId;
  final String? type;
  final String? downloadUrl;

  MessageModel({
    this.userName,
    this.professionalName,
    this.userEmail,
    this.professionalEmail,
    this.message,
    this.isProfessional,
    this.seen,
    this.professionalPhotoUrl,
    this.userPhotoUrl,
    this.date,
    this.senderId,
    this.receiverId,
    this.type,
    this.downloadUrl,
  });

  MessageModel.fromJson(Map<String, Object?> json)
      : this(
          userName:
              (json['userName'] != null) ? json['userName']! as String : '',
          professionalName: (json['professionalName'] != null)
              ? json['professionalName']! as String
              : '',
          userEmail:
              (json['userEmail'] != null) ? json['userEmail']! as String : '',
          professionalEmail: (json['professionalEmail'] != null)
              ? json['professionalEmail']! as String
              : '',
          message: (json['message'] != null) ? json['message']! as String : '',
          isProfessional: json['isProfessional']! as bool,
          seen: json['seen']! as bool,
          professionalPhotoUrl: (json['professionalPhotoUrl'] != null)
              ? json['professionalPhotoUrl']! as String
              : '',
          userPhotoUrl: (json['userPhotoUrl'] != null)
              ? json['userPhotoUrl']! as String
              : '',
          date: (json['date']! as Timestamp).toDate(),
          senderId:
              (json['senderId'] != null) ? json['senderId']! as String : '',
          receiverId:
              (json['receiverId'] != null) ? json['receiverId']! as String : '',
          type: (json['type'] != null) ? json['type']! as String : '',
          downloadUrl: (json['downloadUrl'] != null)
              ? json['downloadUrl']! as String
              : '',
        );
  Map<String, Object?> toJson() {
    return {
      'userName': userName,
      'professionalName': professionalName,
      'userEmail': userEmail,
      'professionalEmail': professionalEmail,
      'message': message,
      'isProfessional': isProfessional,
      'seen': seen,
      'professionalPhotoUrl': professionalPhotoUrl,
      'userPhotoUrl': userPhotoUrl,
      'date': date,
      'senderId': senderId,
      'receiverId': receiverId,
      'type': type,
      'downloadUrl': downloadUrl,
    };
  }
}
