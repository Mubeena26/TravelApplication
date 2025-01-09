import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:travelapp_project/Features/chat/services/chat_services.dart';

import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatServices chatService;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late String adminId;

  ChatBloc(this.chatService) : super(ChatInitial()) {
    on<LoadMessages>((event, emit) async {
      emit(ChatLoading());
      try {
        DocumentSnapshot adminDoc = await FirebaseFirestore.instance
            .collection('admindetails')
            .doc('admin')
            .get();
        adminId = adminDoc.id;

        await emit.forEach(
          chatService.getMessages(adminId, firebaseAuth.currentUser!.uid),
          onData: (snapshot) => ChatLoaded(snapshot.docs),
          onError: (error, stackTrace) => ChatError(error.toString()),
        );
      } catch (e) {
        emit(ChatError(e.toString()));
      }
    });

    on<SendMessage>((event, emit) async {
      try {
        await chatService.sendMessage(adminId, event.message);
      } catch (e) {
        emit(ChatError(e.toString()));
      }
    });
    on<DeleteMessage>((event, emit) async {
      try {
        String messageId = event.message.id;
        await chatService.deleteMessage(adminId, messageId);
        List<DocumentSnapshot> updatedMessages =
            List.from((state as ChatLoaded).messages)..remove(event.message);
        emit(ChatLoaded(updatedMessages));
      } catch (e) {
        emit(ChatError(e.toString()));
      }
    });
  }
}
