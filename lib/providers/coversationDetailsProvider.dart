import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/models/profile.dart';
import 'package:my_chat_app/services/profileServices.dart';

class CoversationDetailsProvider with ChangeNotifier {
  List<Profile> profiles = [];
  List<ProfileParticipant> profileParticipant = [];

  final ProfileServices _webservices = ProfileServices();
  final String conversationId;
  CoversationDetailsProvider({required this.conversationId}) {
    getProfilData();
  }

  Future<void> getProfilData() async {
    final myprofiles = await _webservices.getprofilesPByconId(conversationId);
    profileParticipant = myprofiles;
    notifyListeners();
  }

  deletProfile() async {
    await _webservices.quitConversation(conversationId);
  }
}
