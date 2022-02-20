import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String? title;
  final String? body;
  final bool? isProfessional;
  final bool? seen;
  final String? photoUrl;
  final DateTime? date;
  final String? senderId;
  final String? receiverId;
  final String? type;

  MessageModel({
    this.title,
    this.body,
    this.isProfessional,
    this.seen,
    this.photoUrl,
    this.date,
    this.senderId,
    this.receiverId,
    this.type,
  });

  MessageModel.fromJson(Map<String, Object?> json)
      : this(
          title: (json['title'] != null) ? json['title']! as String : '',
          body: (json['body'] != null) ? json['body']! as String : '',
          isProfessional: json['isProfessional']! as bool,
          seen: json['seen'] == '0' ? false : true,
          photoUrl:
              (json['photoUrl'] != null) ? json['photoUrl']! as String : '',
          date: (json['date']! as Timestamp).toDate(),
          senderId:
              (json['senderId'] != null) ? json['senderId']! as String : '',
          receiverId:
              (json['receiverId'] != null) ? json['receiverId']! as String : '',
          type: (json['type'] != null) ? json['type']! as String : '',
        );
  Map<String, Object?> toJson() {
    return {
      'title': title,
      'body': body,
      'isProfessional': isProfessional,
      'seen': seen,
      'photoUrl': photoUrl,
      'date': date,
      'senderId': senderId,
      'receiverId': receiverId,
      'type': type,
    };
  }
}
