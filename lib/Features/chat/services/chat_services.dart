import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travelapp_project/Features/chat/models/chat_model.dart';

class ChatServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch the current user's display name from Firestore
  Future<String> getUserName() async {
    try {
      String currentUserId = _firebaseAuth.currentUser!.uid;

      // Fetch user document from Firestore
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(currentUserId).get();
      if (userDoc.exists) {
        return userDoc['displayname'] ??
            'Unknown User'; // Use 'displayname' field
      }
      return 'Unknown User'; // Fallback in case of missing display name
    } catch (e) {
      return 'Unknown User'; // Fallback in case of an error
    }
  }

  // Send a message
  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail =
        _firebaseAuth.currentUser!.displayName ?? '';

    final Timestamp timestamp = Timestamp.now();

    // Fetch sender's name from Firestore
    String senderName = await getUserName();

    Message newMessage = Message(
      senderId: currentUserId,
      senderName: senderName, // Include the display name here
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
      isDeleted: false,
      senderemail: currentUserEmail, // Make sure to send the sender's email too
    );

    // Create a chat room ID
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    // Store message in Firestore
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

  // Other methods remain unchanged...

  // Get messages from a chat room
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

  // Delete a message
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

  // Get user chats
  Stream<QuerySnapshot> getUserChats(String adminId) {
    return _firestore
        .collection('chatroom')
        .where('participants', arrayContains: adminId)
        .snapshots();
  }
}
