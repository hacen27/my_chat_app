import 'package:my_chat_app/models/conversations.dart';
import 'package:my_chat_app/providers/accounts/auth_provider.dart';

import '../models/conversationParticipant.dart';
import '../utils/supabase_constants.dart';

class CoversationServices {
  final AuthProvider authProvider = AuthProvider();
  Newconversation? newconversation;

  Future<dynamic> newConversation(List<String> profileIds, String title) async {
    final myId = authProvider.getUser()!.id;
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

    final conversationdata = await supabase
        .from('conversation_participant')
        .insert(participants)
        .select();

    return conversationdata;
  }

  Future<List<ConversationParticpant>> conversationParticipant() async {
    final myId = authProvider.getUser()!.id;

    final data = await supabase
        .from('conversation_participant')
        .select('id, created_at, conversation_id, conversation!inner(title)')
        .eq('profile_id', myId)
        .order('created_at', ascending: false);
    return data.map((e) => ConversationParticpant.fromJson(e)).toList();
  }
}
