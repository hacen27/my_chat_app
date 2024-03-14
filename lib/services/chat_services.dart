import 'package:my_chat_app/models/message.dart';

import '../utils/supabase_constants.dart';

class ChatServices {
  Future<String> getTitleByConversationId(String conversationId) async {
    final title = await supabase
        .from('conversation')
        .select('title')
        .eq('id', conversationId)
        .single();

    return title['title'];
  }

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

  Future<void> deleteMessage(String content) async {
    await supabase.from('message').delete().eq('content', content);
  }

  Future<void> submitMessage(String conversationId, String myId, String text,
      Message? replyMessage) async {
    final data = await supabase
        .from('profile')
        .select('username')
        .eq('id', myId)
        .single();

    final senderName = data['username'];

    await supabase.from('message').insert({
      'conversation_id': conversationId,
      'content': text,
      'send_id': myId,
      'send_name': senderName,
      'replyMessage': "$replyMessage".toString()
    }).select();
  }
}
