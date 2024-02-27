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

  Future<void> submitMessage(
      String conversationId, String myId, String text) async {
    final data = await supabase
        .from('profile')
        .select('username')
        .eq('id', myId)
        .single();

    final senderName = data['username'];

    supabase.from('message').insert({
      'content': text,
      'conversation_id': conversationId,
      'send_id': myId,
      'send_name': senderName,
    });
  }
}
