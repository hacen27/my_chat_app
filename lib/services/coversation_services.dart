import 'package:my_chat_app/models/conversations.dart';

import '../models/conversationParticipant.dart';
import '../utils/supabase_constants.dart';

class CoversationServices {
  Newconversation? newconversation;

  Future<dynamic> newConversation(List<String> profileIds, String title) async {
    final sendId = supabase.auth.currentUser!.id;
    final conversation =
        await supabase.from('conversation').insert({'title': title}).select();

    newconversation = Newconversation.fromJson(conversation.first);

    List<Map<String, dynamic>> participants = [
      {'conversation_id': newconversation!.id, 'profile_id': sendId},
      for (final profileId in profileIds)
        {
          'conversation_id': newconversation!.id,
          'profile_id': profileId,
        }
    ];

    final conversationdata = await supabase
        .from('conversation_participant')
        .insert(participants)
        .select();

    return conversationdata;
  }

  Future<List<ConversationParticpant>> conversationParticipant() async {
    final myId = supabase.auth.currentUser!.id;

    final data = await supabase
        .from('conversation_participant')
        .select('id, created_at, conversation_id, conversation!inner(title)')
        .eq('profile_id', myId)
        .order('created_at', ascending: false);
    return data.map((e) => ConversationParticpant.fromJson(e)).toList();
  }
}
