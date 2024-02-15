import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_chat_app/models/message.dart';

import 'package:my_chat_app/providers/account/auth_provider.dart';

import 'package:my_chat_app/services/chat_services.dart';
import 'package:my_chat_app/utils/error_handling.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatProvider with ChangeNotifier {
  final String conversationId;
  List<Message> _messages = [];

  List<Message> get messages => _messages;

  User? get currentUser => AuthProvider().getUser();

  final ChatServices _chatServices = ChatServices();
  late final StreamSubscription<List<Message>> _messagesSubscription;
  final BuildContext context;
  final textController = TextEditingController();

  ChatProvider({required this.conversationId, required this.context}) {
    myMessages();
  }

  Future<void> myMessages() async {
    _messagesSubscription =
        _chatServices.getAllMessages(conversationId, currentUser!.id).listen(
      (newMessages) {
        _messages = newMessages;
        notifyListeners();
      },
      onError: (err) {
        ErrorHandling.handlePostgresError(err, context);
      },
    );
  }

  Future<void> submitMessage() async {
    final text = textController.text;

    if (text.isEmpty) {
      return;
    }

    textController.clear();

    try {
      await _chatServices.submitMessg(conversationId, currentUser!.id, text);
    } on PostgrestException catch (error) {
      log(error.toString());
      ErrorHandling.handlePostgresError(error, context);
    } catch (err) {
      log(err.toString());
      ErrorHandling.handlePostgresError(err, context);
    }
  }

  @override
  void dispose() {
    _messagesSubscription.cancel();
    textController.dispose();
    super.dispose();
  }
}
