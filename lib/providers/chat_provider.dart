import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/models/message.dart';
import 'package:my_chat_app/pages/widgets/customsnackbar.dart';
import 'package:my_chat_app/providers/accounts/auth_provider.dart';

import 'package:my_chat_app/services/chat_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatProvider with ChangeNotifier {
  List<Message> _messages = [];

  List<Message> get messages => _messages;

  User? get currentUser => AuthProvider().getUser();

  final ChatServices _chatServices = ChatServices();
  late final StreamSubscription<List<Message>> _messagesSubscription;

  ChatProvider.initialize(String conversationId) {
    _messagesSubscription =
        _chatServices.getAllMessages(conversationId, currentUser!.id).listen(
      (newMessages) {
        _messages = newMessages;
        notifyListeners();
      },
      onError: (err) {
        ErrorSnackBar(message: err.toString());
      },
    );
  }

  @override
  void dispose() {
    _messagesSubscription.cancel();
    super.dispose();
  }
}
