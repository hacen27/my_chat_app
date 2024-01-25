import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/models/conversations.dart';
import 'package:my_chat_app/models/message.dart';
import 'package:my_chat_app/services/services.dart';

import '../models/profile.dart';
import '../utils/constants.dart';

class ChatProvider with ChangeNotifier {
  late final Stream<List<Message>> _messagesStream;

  Stream<List<Message>> get messagesStream => _messagesStream;

  Profile? _profileCache;
  Profile? get myprofile => _profileCache;

  WebServices webservices = WebServices();

  ChatProvider.initialize(String conversationId) {
    final myUserId = supabase.auth.currentUser!.id;

    _messagesStream = supabase
        .from('message')
        .stream(primaryKey: ['id'])
        .eq('conversation_id', conversationId)
        .order('created_at')
        .map((maps) => maps
            .map((map) => Message.fromMap(map: map, myUserId: myUserId))
            .toList());

    notifyListeners();
  }

  Future<void> loadProfileCache(String profileId) async {
    if (_profileCache!.id == profileId) {
      return;
    }

    final data =
        await supabase.from('profiles').select().eq('id', profileId).single();
    final profile = Profile.fromMap(data);

    _profileCache = profile;

    notifyListeners();
  }
}
