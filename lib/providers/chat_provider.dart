import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_chat_app/models/message.dart';

import 'package:my_chat_app/providers/account/auth_provider.dart';

import 'package:my_chat_app/services/chat_services.dart';
import 'package:my_chat_app/utils/error_handling.dart';
import 'package:my_chat_app/utils/exception_catch.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatProvider with ChangeNotifier {
  final String conversationId;
  List<Message> _messages = [];

  final focusNode = FocusNode();
  List<Message> get messages => _messages;

  User? get currentUser => AuthProvider().getUser();

  final ChatServices _chatServices = ChatServices();
  late final StreamSubscription<List<Message>> _messagesSubscription;

  final textController = TextEditingController();
  Message? replyMessage;

  ChatProvider({required this.conversationId}) {
    myMessages();
  }

  void replyToMessage(Message message) {
    replyMessage = message;

    notifyListeners();
  }

  void cancelReply() {
    replyMessage = null;
    notifyListeners();
  }

  Future<void> myMessages() async {
    _messagesSubscription =
        _chatServices.getAllMessages(conversationId, currentUser!.id).listen(
      (newMessages) {
        _messages = newMessages;

        notifyListeners();
      },
      onError: (err) {
        ErrorHandling.handlePostgresError(err);
      },
    );
  }

  Future<void> submitMessage() async {
    final text = textController.text;

    if (text.isEmpty) {
      return;
    }

    textController.clear();

    await ExceptionCatch.catchErrors(() => _chatServices.submitMessage(
          conversationId,
          currentUser!.id,
          text,
          replyMessage,
        ));
  }

  void deleteMessage(String content) async {
    await ExceptionCatch.catchErrors(
        () => _chatServices.deleteMessage(content));
  }

  @override
  void dispose() {
    _messagesSubscription.cancel();
    textController.dispose();
    super.dispose();
  }
}
