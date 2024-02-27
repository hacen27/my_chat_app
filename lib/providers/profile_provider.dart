import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_chat_app/providers/account/auth_provider.dart';
import 'package:my_chat_app/services/conversation_services.dart';
import 'package:my_chat_app/services/profile_services.dart';
import 'package:my_chat_app/utils/exception_catch.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/profile.dart';

class ProfileProvider with ChangeNotifier {
  List<Profile> allProfiles = [];
  List<Profile> searchFonProfiles = [];

  String conversationId = '';

  List<String> profileIds = [];

  bool isSearching = false;
  final searchTextController = TextEditingController();
  final textTitleController = TextEditingController();
  bool isComplete = false;
  final ProfileServices _profileServices = ProfileServices();
  final ConversationsServices _conversationsServices = ConversationsServices();
  User? get currentUser => AuthProvider().getUser();

  final BuildContext context;
  ProfileProvider({required this.context}) {
    initializeData();
  }

  void addSearChedForItemsToSearchedList(String searchProfile) {
    searchFonProfiles = allProfiles
        .where((profile) =>
            profile.username.toLowerCase().startsWith(searchProfile))
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
    searchTextController.clear();
    notifyListeners();
  }

  void setComplete() {
    isComplete = true;
    notifyListeners();
  }

  void toggleProfileSelection(String profileId) {
    if (profileIds.contains(profileId)) {
      profileIds.remove(profileId);
    } else {
      profileIds.add(profileId);
    }

    notifyListeners();
  }

  bool isProfileSelected(String profileId) {
    return profileIds.contains(profileId);
  }

  void resetSelection() {
    profileIds.clear();

    notifyListeners();
  }

  Future<void> initializeData() async {
    await getAllProfile();

    notifyListeners();
  }

  Future<void> getAllProfile() async {
    final response = await ExceptionCatch.catchErrors(
        () => _profileServices.allProfiles(currentUser!.id), context);
    searchFonProfiles = allProfiles = response.result!;
    notifyListeners();
  }

  Future<bool> addToConversation() async {
    final response = await ExceptionCatch.catchErrors(
        () => _conversationsServices.newConversation(
            profileIds, textTitleController.text, currentUser!.id),
        context);

    return !response.isError;
  }
}
