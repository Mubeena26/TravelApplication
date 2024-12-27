import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final Timestamp timestamp;
  final bool isSentByMe;

  const ChatBubble({
    super.key,
    required this.message,
    required this.timestamp,
    required this.isSentByMe,
  });

  @override
  Widget build(BuildContext context) {
    DateTime date = timestamp.toDate();
    // String formattedDate = datefo('dd MMM yyyy, hh:mm a').format(date);
    return Container(
      margin: isSentByMe
          ? const EdgeInsets.only(left: 50, top: 10, bottom: 10, right: 10)
          : const EdgeInsets.only(right: 50, top: 10, bottom: 10, left: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: isSentByMe
            ? LinearGradient(
                colors: [
                  Color.fromARGB(255, 66, 88, 132),
                  Color.fromARGB(255, 84, 149, 255),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : LinearGradient(
                colors: [
                  // Colors.teal.shade700,
                  // Colors.teal.shade300,
                  Color.fromARGB(255, 66, 88, 132),
                  Color.fromARGB(255, 84, 149, 255),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        borderRadius: isSentByMe
            ? const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              )
            : const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              color: isSentByMe ? Colors.white : Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          // Text(
          //   formattedDate,
          //   style: TextStyle(
          //     fontSize: 12,
          //     color: isSentByMe ? Colors.white70 : Colors.white70,
          //   ),
          // ),
        ],
      ),
    );
  }
}
