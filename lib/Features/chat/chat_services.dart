import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travelapp_project/Features/chat/chat_model.dart';

class ChatServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, String message) async {
    final String CurrentUsrId = _firebaseAuth.currentUser!.uid;
    final String currentUsermail = _firebaseAuth.currentUser!.uid;

    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderId: CurrentUsrId,
        senderemail: currentUsermail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp,
        isDeleted: false);

    List<String> ids = [CurrentUsrId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');
    await _firestore
        .collection("chatRoom")
        .doc(chatRoomId)
        .set({"key": "value"});
    await _firestore
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return _firestore
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Future<void> deleteMessage(String receiverId, String messageId) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    DocumentReference messageDocRef = _firestore
        .collection("chatroom")
        .doc(chatRoomId)
        .collection("messages")
        .doc(messageId);

    await messageDocRef.update({'isdeleted': true});
    await messageDocRef.delete();
  }

  Stream<QuerySnapshot> getUserChats(String adminId) {
    return _firestore
        .collection('chatroom')
        .where('participants', arrayContains: adminId)
        .snapshots();
  }
}
