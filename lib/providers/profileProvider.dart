import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_chat_app/models/conversations.dart';
import 'package:my_chat_app/services/services.dart';

import '../models/profile.dart';

class ProfileProvider with ChangeNotifier {
  List<Profile>? allProfiles = [];
  List<Profile>? searchFonProfiles = [];
  Conversation? conversation;
  String conversationId = '';

  bool isSelectItem = false;
  Map<int, bool> selectedItem = {};
  List<String> profilIds = [];

  bool isSearching = false;
  final searchTextCotrollor = TextEditingController();
  final textTitleController = TextEditingController();
  bool isComplet = false;
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

  void setCimplet() {
    isComplet = true;
    notifyListeners();
  }

  ProfileProvider() {
    initializeData();
  }

  Future<void> initializeData() async {
    await getAllprofile();

    notifyListeners();
  }

  void itemSelection(int index, bool? isSelectedData) {
    selectedItem[index] = !isSelectedData!;
    isSelectItem = selectedItem.containsValue(true);
    final Id =
        isSearching ? searchFonProfiles![index].id : allProfiles![index].id;

    if (!isSelectedData) {
      profilIds.add(Id);
    } else {
      profilIds.remove(Id);
      if (profilIds.isEmpty) {
        isSelectItem = selectedItem.containsValue(false);
      }
    }

    notifyListeners();
  }

  void resetSelection() {
    selectedItem.clear();
    profilIds.clear();
    isSelectItem = false;
    notifyListeners();
  }

  Future<void> getAllprofile() async {
    final profileMaps = await webservices.profilesService();
    print("//////profiles///////");
    print(profileMaps);

    searchFonProfiles = allProfiles =
        profileMaps.map((profile) => Profile.fromJson(profile)).toList();
  }

  Future<void> addtoConversation() async {
    final newconversation = await webservices.newConversationService(
        profilIds, textTitleController.text);
    print("//////Data///////");
    print(newconversation);
  }
}
