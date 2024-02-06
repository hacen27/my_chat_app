import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/models/message.dart';

import 'package:my_chat_app/services/chat_services.dart';

class ChatProvider with ChangeNotifier {
  List<Message> _messages = [];

  List<Message> get messages => _messages;

  final ChatServices _chatServices = ChatServices();
  late final StreamSubscription<List<Message>> _messagesSubscription;

  ChatProvider.initialize(String conversationId) {
    _messagesSubscription = _chatServices.getAllMessages(conversationId).listen(
      (newMessages) {
        _messages = newMessages;
        notifyListeners();
      },
      onError: (err) {
        print("Erreur lors de la réception des messages: $err");
      },
    );
  }

  @override
  void dispose() {
    _messagesSubscription.cancel();
    super.dispose();
  }
}
