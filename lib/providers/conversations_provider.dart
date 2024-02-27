import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_chat_app/providers/account/auth_provider.dart';
import 'package:my_chat_app/services/conversation_services.dart';
import 'package:my_chat_app/utils/exception_catch.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/conversation_participant.dart';

class ConversationProvider with ChangeNotifier {
  bool hasConnection = false;
  List<ConversationParticipant> conversationsParticipant = [];
  final ConversationsServices _webServices = ConversationsServices();

  User? get currentUser => AuthProvider().getUser();
  final BuildContext context;
  ConversationProvider({required this.context}) {
    getAllConversationParticipant();
  }

  Future<void> getAllConversationParticipant() async {
    final response = await ExceptionCatch.catchErrors(
        () => _webServices.conversationParticipant(currentUser!.id), context);

    if (response.isError) return;

    conversationsParticipant = response.result!;
    notifyListeners();
  }
}
