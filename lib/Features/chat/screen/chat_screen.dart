import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp_project/Features/chat/bloc/chat_event.dart';
import 'package:travelapp_project/Features/chat/bloc/chat_state.dart';

import 'package:travelapp_project/Features/chat/bloc/chat_bloc.dart'; // Adjust according to your folder structure
import 'package:travelapp_project/Features/chat/components/chat_bubble.dart';
import 'package:travelapp_project/Features/core/theme/text_style.dart';
import 'package:travelapp_project/Features/core/theme/utils_colors.dart';
import 'package:travelapp_project/Features/core/widgets/custom_app_bar.dart';
import 'package:travelapp_project/Features/core/widgets/custom_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String adminId;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitecolor,
      appBar: CustomAppBar(
        title: "Le'xplore",
        style: AppTextStyles.headline1,
        backgroundColor: App2,
        toolbarHeight: 60,
        titleSpacing: 20,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: Colors.red, // Change this to the desired color
        ),
        actions: [
          CustomIconButton(
            icon: Icons.phone_in_talk,
            size: 30.0,
            color: whitecolor,
            padding: const EdgeInsets.all(16.0),
            onPressed: () async {
              final Uri url = Uri(scheme: 'tel', path: '7025963877');

              if (await canLaunchUrl(url)) {
                launchUrl(url);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content:
                      Text("can't do the call", style: AppTextStyles.chatCall),
                  backgroundColor: whitecolor,
                ));
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ChatLoaded) {
            return Column(
              children: [
                Expanded(
                  child: _buildMessagelist(state.messages),
                ),
                _buildMessageinput(context),
              ],
            );
          } else if (state is ChatError) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildMessageinput(BuildContext context) {
    final TextEditingController messagecontroller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messagecontroller,
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.message,
                    color: App2,
                    size: 30,
                  ),
                  hintText: 'Type a message.....',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: App2,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: blackcolor,
                      width: 2.0,
                    ),
                  ),
                  suffixIcon: CustomIconButton(
                    icon: Icons.send,
                    size: 35.0,
                    color: blackcolor,
                    padding: const EdgeInsets.all(16.0),
                    onPressed: () {
                      context
                          .read<ChatBloc>()
                          .add(SendMessage(messagecontroller.text));
                      messagecontroller.clear();
                    },
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    bool isSentByMe = data['senderid'] == currentUserId;

    bool isDeletded = data['isdeleted'] ?? false;
    if (isDeletded) {
      return Container(
        alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child:
            Text('This message was deleted', style: AppTextStyles.chatMessage),
      );
    }
    return Dismissible(
      key: Key(document.id),
      direction:
          isSentByMe ? DismissDirection.endToStart : DismissDirection.none,
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: App2,
              title:
                  const Text('Delete Message', style: AppTextStyles.chatCall),
              content: const Text(
                  'Are you sure you want to delete this message?',
                  style: AppTextStyles.chatCall),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel', style: AppTextStyles.chatCall),
                ),
                TextButton(
                  onPressed: () {
                    context.read<ChatBloc>().add(DeleteMessage(document));
                    Navigator.of(context).pop(true);
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: redcolor),
                  ),
                ),
              ],
            );
          },
        ).then((value) {
          if (value) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  backgroundColor: App2,
                  content: Center(
                      child: Text('Message deleted',
                          style: AppTextStyles.chatMssag2))),
            );
          }
          return value;
        });
      },
      background: Container(
        color: redcolor,
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          color: whitecolor,
        ),
      ),
      child: GestureDetector(
        onTap: () async {},
        child: Align(
          alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
          child: ChatBubble(
            message: data['message'],
            timestamp: data['timestamp'],
            isSentByMe: isSentByMe,
          ),
        ),
      ),
    );
  }

  Widget _buildMessagelist(List<DocumentSnapshot> documents) {
    if (documents.isEmpty) {
      return const Center(
        child: Text(
          'No messages yet',
          style: TextStyle(fontSize: 18, color: grey),
        ),
      );
    } else {
      return ListView(
        children:
            documents.map((document) => _buildMessageItem(document)).toList(),
      );
    }
  }
}
