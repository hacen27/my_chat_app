import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/message.dart';
import '../models/profile.dart';
import '../utils/constants.dart';

class ChatProvider with ChangeNotifier {
  late final Stream<List<Message>> _messagesStream;
  final Map<String, Profile> _profileCache = {};

  Stream<List<Message>> get messagesStream => _messagesStream;

  Map<String, Profile> get profileCache => Map.from(_profileCache);

  ChatProvider.initialize() {
    final myUserId = supabase.auth.currentUser!.id;
    _messagesStream = supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('created_at')
        .map((maps) => maps
            .map((map) => Message.fromMap(map: map, myUserId: myUserId))
            .toList());

    if (kDebugMode) {
      print('=====///=============///=====');
      print('Chat provider Started');
      print('///==========///==========///');
    }
    notifyListeners();
  }

  Future<void> loadProfileCache(String profileId) async {
    if (_profileCache[profileId] != null) {
      return;
    }
    final data =
        await supabase.from('profiles').select().eq('id', profileId).single();
    final profile = Profile.fromMap(data);

    _profileCache[profileId] = profile;

    if (kDebugMode) {
      print('=====///=============///=====');
      print('Chat provider loaded');
      print('///==========///==========///');
    }
    notifyListeners();
  }

  //  Future<void> loadProfileCacheForMessages() async {
  //   final profileIds = _messagesStream
  //       .expand((messages) => messages.map((message) => message.profileId))
  //       .toSet();

  //   for (final profileId in profileIds) {
  //     await loadProfileCache(profileId);
  //   }
  // }
}
