import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_chat_app/models/profile.dart';
import 'package:my_chat_app/providers/account/auth_provider.dart';

import 'package:my_chat_app/services/profile_services.dart';
import 'package:my_chat_app/utils/exception_catch.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ConversationDetailsProvider with ChangeNotifier {
  List<Profile> profiles = [];
  List<ProfileParticipant> profileParticipant = [];
  final BuildContext context;
  final ProfileServices _webServices = ProfileServices();
  final String conversationId;
  User? get currentUser => AuthProvider().getUser();

  ConversationDetailsProvider(
      {required this.conversationId, required this.context}) {
    getProfileData();
  }

  Future<void> getProfileData() async {
    final response = await ExceptionCatch.catchErrors(
        () =>
            _webServices.getProfilesParticipantByConversationId(conversationId),
        context);
    if (response.isError) return;
    profileParticipant = response.result!;
    notifyListeners();
  }

  deleteProfile() async {
    await ExceptionCatch.catchErrors(
        () => _webServices.quitConversation(conversationId, currentUser!.id),
        context);
  }
}
