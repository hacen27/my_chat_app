import 'package:my_chat_app/models/message.dart';
import 'package:my_chat_app/utils/constants.dart';

class ChatServices {
  late Stream<List<Message>> _messagesStream;

  Stream<List<Message>> getAllMessages(String conversationId) {
    final myUserId = supabase.auth.currentUser!.id;

    _messagesStream = supabase
        .from('message')
        .stream(primaryKey: ['id'])
        .eq('conversation_id', conversationId)
        .order('created_at')
        .map((maps) => maps
            .map((map) => Message.fromMap(map: map, myUserId: myUserId))
            .toList());

    return _messagesStream;
  }
}
