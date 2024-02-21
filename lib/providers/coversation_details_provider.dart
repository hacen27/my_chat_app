import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_chat_app/models/profile.dart';
import 'package:my_chat_app/providers/account/auth_provider.dart';

import 'package:my_chat_app/services/profile_services.dart';
import 'package:my_chat_app/utils/exception_catch.dart';
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
    final response = await ExceptionCatch.catchErrors(
        () => _webservices.getprofilesPByconId(conversationId), context);
    if (response.isError) return;
    profileParticipant = response.result!;
    notifyListeners();
  }

  deletProfile() async {
    await ExceptionCatch.catchErrors(
        () => _webservices.quitConversation(conversationId, currentUser!.id),
        context);
  }
}
