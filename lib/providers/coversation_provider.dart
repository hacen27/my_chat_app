import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_chat_app/providers/account/auth_provider.dart';
import 'package:my_chat_app/services/coversation_services.dart';
import 'package:my_chat_app/utils/exception_catch.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/conversation_participant.dart';

class CoversationProvider with ChangeNotifier {
  bool hasConnection = false;
  List<ConversationParticpant> conversationsParticipant = [];
  final CoversationServices _webservices = CoversationServices();

  User? get currentUser => AuthProvider().getUser();
  final BuildContext context;
  CoversationProvider({required this.context}) {
    getAllconversationParticipant();
  }

  Future<void> getAllconversationParticipant() async {
    final response = await ExceptionCatch.catchErrors(
        () => _webservices.conversationParticipant(currentUser!.id), context);

    if (response.isError) return;

    conversationsParticipant = response.result!;
    notifyListeners();
  }
}
