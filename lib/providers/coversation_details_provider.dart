import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_chat_app/models/profile.dart';
import 'package:my_chat_app/providers/account/auth_provider.dart';

import 'package:my_chat_app/services/profile_services.dart';
import 'package:my_chat_app/utils/error_handling.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CoversationDetailsProvider with ChangeNotifier {
  List<Profile> profiles = [];
  List<ProfileParticipant> profileParticipant = [];
  final BuildContext context;
  final ProfileServices _webservices = ProfileServices();
  final String conversationId;
  User? get currentUser => AuthProvider().getUser();

  CoversationDetailsProvider(
      {required this.conversationId, required this.context}) {
    getProfilData();
  }

  Future<void> getProfilData() async {
    try {
      final myprofiles = await _webservices.getprofilesPByconId(conversationId);
      profileParticipant = myprofiles;
      notifyListeners();
    } on PostgrestException catch (error) {
      log(error.toString());
      ErrorHandling.handlePostgresError(error, context);
    } catch (err) {
      log(err.toString());
      ErrorHandling.handlePostgresError(err, context);
    }
  }

  deletProfile() async {
    try {
      await _webservices.quitConversation(conversationId, currentUser!.id);
    } on PostgrestException catch (error) {
      log(error.toString());
      ErrorHandling.handlePostgresError(error, context);
    } catch (err) {
      log(err.toString());
      ErrorHandling.handlePostgresError(err, context);
    }
  }
}
