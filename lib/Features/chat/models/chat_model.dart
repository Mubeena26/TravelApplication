import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderemail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;
  final bool isDeleted;

  Message(
      {required this.senderId,
      required this.senderemail,
      required this.receiverId,
      required this.message,
      required this.timestamp,
      required this.isDeleted,
      required String senderName,
      required String senderEmail});

  Map<String, dynamic> toMap() {
    return {
      'senderid': senderId,
      'senderemail': senderemail,
      'recieverid': receiverId,
      'message': message,
      'timestamp': timestamp,
      'isdeleted': isDeleted
    };
  }
}
