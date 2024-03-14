import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_chat_app/providers/account/auth_provider.dart';
import 'package:my_chat_app/services/conversation_services.dart';
import 'package:my_chat_app/utils/exception_catch.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/conversation_participant.dart';

class ConversationProvider with ChangeNotifier {
  List<ConversationParticipant> conversationsParticipant = [];
  final ConversationsServices _webServices = ConversationsServices();

  User? get currentUser => AuthProvider().getUser();

  ConversationProvider() {
    getAllConversationParticipant();
  }

  Future<void> getAllConversationParticipant() async {
    final response = await ExceptionCatch.catchErrors(
        () => _webServices.conversationParticipant(currentUser!.id));

    if (response.isError) return;

    conversationsParticipant = response.result!;
    notifyListeners();
  }
}
