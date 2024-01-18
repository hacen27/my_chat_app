import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/message.dart';
import '../models/profile.dart';
import '../utils/constants.dart';

class ChatProvider with ChangeNotifier {
  late final Stream<List<Message>> _messagesStream;

  Stream<List<Message>> get messagesStream => _messagesStream;

  Profile? myprofile;

  ChatProvider.initialize() {
    final myUserId = supabase.auth.currentUser!.id;

    _messagesStream = supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('created_at')
        .map((maps) => maps
            .map((map) => Message.fromMap(map: map, myUserId: myUserId))
            .toList());

    notifyListeners();
  }

  Future<void> loadProfileCache(String profileId) async {
    if (myprofile!.id == profileId) {
      return;
    }

    final data =
        await supabase.from('profiles').select().eq('id', profileId).single();
    final profile = Profile.fromMap(data);
    myprofile = profile;

    notifyListeners();
  }
}
