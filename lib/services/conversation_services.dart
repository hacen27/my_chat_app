import 'package:my_chat_app/models/conversations.dart';

import '../models/conversation_participant.dart';
import '../utils/supabase_constants.dart';

class ConversationsServices {
  Newconversation? newconversation;

  Future<void> newConversation(
      List<String> profileIds, String title, String myId) async {
    final conversation =
        await supabase.from('conversation').insert({'title': title}).select();

    newconversation = Newconversation.fromJson(conversation.first);

    List<Map<String, dynamic>> participants = [
      {'conversation_id': newconversation!.id, 'profile_id': myId},
      for (final profileId in profileIds)
        {
          'conversation_id': newconversation!.id,
          'profile_id': profileId,
        }
    ];

    await supabase
        .from('conversation_participant')
        .insert(participants)
        .select();
  }

  Future<List<ConversationParticipant>> conversationParticipant(
      String myId) async {
    final data = await supabase
        .from('conversation_participant')
        .select('id, created_at, conversation_id, conversation!inner(title)')
        .eq('profile_id', myId)
        .order('created_at', ascending: false);
    return data.map((e) => ConversationParticipant.fromJson(e)).toList();
  }
}
