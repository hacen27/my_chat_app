import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/models/conversations.dart';
import 'package:my_chat_app/services/services.dart';

import '../models/profile.dart';

class CoversationProvider with ChangeNotifier {
  List<Profile> profiles = [];

  List<Conversation> conversations = [];
  WebServices webservices = WebServices();

  CoversationProvider() {
    initializeData();
  }

  Future<void> initializeData() async {
    await getAllconversation();
    await getAllprofile();

    notifyListeners();
  }

  Future<void> getAllconversation() async {
    final conversationMaps = await webservices.conversationService();

    conversations = conversationMaps
        .map((conversation) => Conversation.fromJson(conversation))
        .toList();
  }

  Future<void> getAllprofile() async {
    final profileMaps = await webservices.profilesService();

    profiles = profileMaps.map((profile) => Profile.fromJson(profile)).toList();
  }
}
