import 'package:my_chat_app/models/message.dart';

import '../utils/supabase_constants.dart';

class ChatServices {
  Stream<List<Message>> getAllMessages(String conversationId, String myUserId) {
    final messagesStream = supabase
        .from('message')
        .stream(primaryKey: ['id'])
        .eq('conversation_id', conversationId)
        .order('created_at')
        .map((maps) => maps
            .map((map) => Message.fromMap(map: map, myUserId: myUserId))
            .toList());

    return messagesStream;
  }
}
