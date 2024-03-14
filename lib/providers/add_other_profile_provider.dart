import 'package:flutter/material.dart';
import 'package:my_chat_app/models/profile.dart';
import 'package:my_chat_app/services/profile_services.dart';

import '../pages/widgets/custom_snack_bar.dart';

class AddListProfilesProvider with ChangeNotifier {
  List<Profile> profiles = [];
  final ProfileServices _webServices = ProfileServices();

  Map<String, bool> selectedItem = {};
  List<String> profileIds = [];

  bool isSearching = false;
  final String conversationId;

  AddListProfilesProvider({required this.conversationId}) {
    getProfileData(conversationId);
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
    selectedItem.clear();
    profileIds.clear();
    notifyListeners();
  }

  Future<void> getProfileData(conversationId) async {
    try {
      final myProfiles =
          await _webServices.getProfilesNotInConversation(conversationId);
      profiles = myProfiles;
      notifyListeners();
    } catch (e) {
      ErrorSnackBar(message: e.toString());
    }
  }

  addProfile(profileIds, conversationId) {
    try {
      _webServices.addToConversation(profileIds, conversationId);
    } catch (e) {
      ErrorSnackBar(message: e.toString());
    }
  }
}
