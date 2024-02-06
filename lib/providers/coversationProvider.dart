import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/widgets/customsnackbar.dart';
import 'package:my_chat_app/services/coversation_services.dart';

import '../models/conversationParticipant.dart';

class CoversationProvider with ChangeNotifier {
  bool loading = false;
  List<ConversationParticpant> conversationsParticipant = [];
  final CoversationServices _webservices = CoversationServices();

  CoversationProvider() {
    getAllconversationParticipant();
  }

  Future<void> getAllconversationParticipant() async {
    try {
      conversationsParticipant = await _webservices.conversationParticipant();
      loading = true;
      notifyListeners();
    } catch (err) {
      ErrorSnackBar(message: err.toString());
    }
  }
}
