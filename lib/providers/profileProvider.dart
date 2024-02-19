import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_chat_app/providers/account/auth_provider.dart';
import 'package:my_chat_app/services/coversation_services.dart';
import 'package:my_chat_app/services/profile_services.dart';
import 'package:my_chat_app/utils/exception_catch.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  User? get currentUser => AuthProvider().getUser();

  final BuildContext context;
  ProfileProvider({required this.context}) {
    initializeData();
  }

  void addSearChedForitemsToserchedList(String searchProfile) {
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
    final profileMaps = await _profileServices.allprofiles(currentUser!.id);

    searchFonProfiles = allProfiles = profileMaps;
    notifyListeners();
  }

  Future<bool> addtoConversation() async {
    final response = await ExceptionCatch.catchErrors(
        () => _coversationServices.newConversation(
            profilIds, textTitleController.text, currentUser!.id),
        context);

    return !response.isError;
  }
}
