import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/widgets/customsnackbar.dart';
import 'package:my_chat_app/providers/accounts/auth_provider.dart';
import 'package:my_chat_app/services/coversation_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/conversation_participant.dart';

class CoversationProvider with ChangeNotifier {
  bool loading = false;
  List<ConversationParticpant> conversationsParticipant = [];
  final CoversationServices _webservices = CoversationServices();
  User? get currentUser => AuthProvider().getUser();
  CoversationProvider() {
    getAllconversationParticipant();
  }

  Future<void> getAllconversationParticipant() async {
    try {
      conversationsParticipant =
          await _webservices.conversationParticipant(currentUser!.id);
      loading = true;
      notifyListeners();
    } catch (err) {
      ErrorSnackBar(message: err.toString());
    }
  }
}
