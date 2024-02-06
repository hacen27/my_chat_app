import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_chat_app/services/coversation_services.dart';
import 'package:my_chat_app/services/profile_services.dart';

import '../models/profile.dart';

class ProfileProvider with ChangeNotifier {
  List<Profile> allProfiles = [];
  List<Profile> searchFonProfiles = [];

  String conversationId = '';

  List<String> profilIds = [];

  bool isSearching = false;
  final searchTextCotrollor = TextEditingController();
  final textTitleController = TextEditingController();
  bool isComplet = false;
  final ProfileServices _profileServices = ProfileServices();
  final CoversationServices _coversationServices = CoversationServices();

  ProfileProvider() {
    initializeData();
  }

  void addSearChedForitemsToserchedList(String searchProfile) {
    searchFonProfiles = allProfiles
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

  void setComplet() {
    isComplet = true;
    notifyListeners();
  }

  void toggleProfileSelection(String profileId) {
    if (profilIds.contains(profileId)) {
      profilIds.remove(profileId);
    } else {
      profilIds.add(profileId);
    }

    notifyListeners();
  }

  bool isProfileSelected(String profileId) {
    return profilIds.contains(profileId);
  }

  void resetSelection() {
    profilIds.clear();

    notifyListeners();
  }

  Future<void> initializeData() async {
    await getAllprofile();

    notifyListeners();
  }

  Future<void> getAllprofile() async {
    final profileMaps = await _profileServices.allprofiles();

    searchFonProfiles = allProfiles = profileMaps;
    notifyListeners();
  }

  Future<void> addtoConversation() async {
    await _coversationServices.newConversation(
        profilIds, textTitleController.text);
  }
}
