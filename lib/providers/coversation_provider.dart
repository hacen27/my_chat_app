import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/widgets/customsnackbar.dart';
import 'package:my_chat_app/providers/account/auth_provider.dart';
import 'package:my_chat_app/services/coversation_services.dart';
import 'package:my_chat_app/utils/error_handling.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/conversation_participant.dart';
import '../services/connectivity_service.dart';

class CoversationProvider with ChangeNotifier {
  bool hasConnection = false;
  List<ConversationParticpant> conversationsParticipant = [];
  final CoversationServices _webservices = CoversationServices();
  final ConnectivityService _checkinternet = ConnectivityService();
  User? get currentUser => AuthProvider().getUser();
  late BuildContext context;
  CoversationProvider() {
    getAllconversationParticipant();
  }

  Future<void> getAllconversationParticipant() async {
    try {
      _checkinternet.connectionChange.listen((connectionState) {
        hasConnection = connectionState;
        notifyListeners();
      });
      conversationsParticipant =
          await _webservices.conversationParticipant(currentUser!.id);

      notifyListeners();
    } on PostgrestException catch (error) {
      log(error.toString());
      ErrorHandling.handlePostgresError(error, context);
    } catch (err) {
      log(err.toString());
      ErrorHandling.handlePostgresError(err, context);
    }
  }
}
