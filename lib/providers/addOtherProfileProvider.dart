import 'package:flutter/material.dart';
import 'package:my_chat_app/models/profile.dart';

import '../services/profileServices.dart';

class AddlistprofilesProvider with ChangeNotifier {
  List<Profile> profiles = [];
  final ProfileServices _webservices = ProfileServices();

  Map<String, bool> selectedItem = {};
  List<String> profilIds = [];

  bool isSearching = false;
  final String conversationId;

  AddlistprofilesProvider({required this.conversationId}) {
    getProfilData(conversationId);
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
    selectedItem.clear();
    profilIds.clear();
    notifyListeners();
  }

  Future<void> getProfilData(conversationId) async {
    final myprofiles = await _webservices.getprofilesByconId(conversationId);
    profiles = myprofiles;
    notifyListeners();
  }

  addProfile(profilIds, conversationId) {
    _webservices.addToConversation(profilIds, conversationId);
  }
}
