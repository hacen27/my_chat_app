import 'package:flutter/material.dart';
import 'package:my_chat_app/models/profile.dart';
import 'package:my_chat_app/services/profile_services.dart';

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
    try {
      final myprofiles = await _webservices.getprofilesByconId(conversationId);
      profiles = myprofiles;
      notifyListeners();
    } catch (e) {}
  }

  addProfile(profilIds, conversationId) {
    _webservices.addToConversation(profilIds, conversationId);
  }
}
