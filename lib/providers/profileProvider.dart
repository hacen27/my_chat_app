import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/widgets/customsnackbar.dart';
import 'package:my_chat_app/providers/account/auth_provider.dart';
import 'package:my_chat_app/services/coversation_services.dart';
import 'package:my_chat_app/services/profile_services.dart';
import 'package:my_chat_app/utils/error_handling.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/profile.dart';

class ProfileProvider with ChangeNotifier {
  List<Profile> allProfiles = [];
  List<Profile> searchFonProfiles = [];
  late BuildContext context;
  String conversationId = '';

  List<String> profilIds = [];

  bool isSearching = false;
  final searchTextCotrollor = TextEditingController();
  final textTitleController = TextEditingController();
  bool isComplet = false;
  final ProfileServices _profileServices = ProfileServices();
  final CoversationServices _coversationServices = CoversationServices();
  User? get currentUser => AuthProvider().getUser();

  ProfileProvider() {
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

  Future<void> addtoConversation() async {
    try {
      await _coversationServices.newConversation(
          profilIds, textTitleController.text, currentUser!.id);
    } on PostgrestException catch (error) {
      log(error.toString());
      ErrorHandling.handlePostgresError(error, context);
    } catch (err) {
      log(err.toString());
      ErrorHandling.handlePostgresError(err, context);
    }
  }
}
