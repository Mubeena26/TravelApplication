// chat_event.dart
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatEvent {}

class LoadMessages extends ChatEvent {}

class SendMessage extends ChatEvent {
  final String message;
  SendMessage(this.message);
}

class DeleteMessage extends ChatEvent {
  final DocumentSnapshot message;
  DeleteMessage(this.message);
}
