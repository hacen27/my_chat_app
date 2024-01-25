import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/models/conversations.dart';
import 'package:my_chat_app/services/services.dart';

import '../models/profile.dart';

class ProfileProvider with ChangeNotifier {
  List<Profile>? allProfiles = [];
  List<Profile>? searchFonProfiles = [];
  Conversation? conversation;
  String conversationId = '';

  bool isSearching = false;
  final searchTextCotrollor = TextEditingController();
  WebServices webservices = WebServices();

  void addSearChedForitemsToserchedList(String searchProfile) {
    searchFonProfiles = allProfiles!
        .where((Profile) =>
            Profile.username.toLowerCase().startsWith(searchProfile))
        .toList();
    notifyListeners();
  }

  void starSearch(BuildContext? context) {
    ModalRoute.of(context!)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));

    isSearching = true;
    notifyListeners();
  }

  void stopSearching() {
    clearSearch();
  }

  void clearSearch() {
    searchTextCotrollor.clear();
    notifyListeners();
  }

  ProfileProvider() {
    initializeData();
  }

  Future<void> initializeData() async {
    await getAllprofile();

    notifyListeners();
  }

  Future<void> getAllprofile() async {
    final profileMaps = await webservices.profilesService();
    print("//////profiles///////");
    print(profileMaps);

    searchFonProfiles = allProfiles =
        profileMaps.map((profile) => Profile.fromJson(profile)).toList();
  }

  void addtoConversation(String profilId) async {
    final newconversation = await webservices.newConversationService(profilId);
    print("//////Data///////");
    print(newconversation);
  }
}
