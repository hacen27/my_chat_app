import 'package:my_chat_app/models/conversations.dart';
import 'package:my_chat_app/utils/constants.dart';

Newconversation? newconversation;

class WebServices {
  Future<dynamic> newConversationService(
      List<String> profileIds, String title) async {
    final sendId = await supabase.auth.currentUser!.id;
    final conversation =
        await supabase.from('conversation').insert({'title': title}).select();

    newconversation = Newconversation.fromJson(conversation.first);

    List<Map<String, dynamic>> participants = [
      {
        'conversation_id': newconversation!.id,
        'profile_id': sendId
      }, 
    ];

    participants.addAll(
      profileIds.map((profileId) => {
            'conversation_id': newconversation!.id,
            'profile_id': profileId,
          }),
    );
    if (participants.isNotEmpty) {
      final conversationdata = await supabase
          .from('conversation_participant')
          .insert(participants)
          .select();

      return conversationdata;
    }
  }

  Future<List<dynamic>> conversationParticipantService() async {
    final myId = await supabase.auth.currentUser!.id;
    try {
      final data = await supabase
          .from('conversation_participant')
          .select('id, created_at, conversation_id, conversation!inner(title)')
          .eq('profile_id', myId)
          .order('created_at', ascending: false);

      return data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> conversationService() async {
    final myId = await supabase.auth.currentUser!.id;
    try {
      final data = await supabase
          .from('conversation')
          .select(
              'id, created_at,  message!inner(*),profile(id, username,created_at)')
          .eq('message.send_id', myId)
          .order('created_at', ascending: false)
          .limit(10);
      return data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> profilesService() async {
    final myId = await supabase.auth.currentUser!.id;
    try {
      final data = await supabase
          .from('profile')
          .select(
              'id, username,created_at,conversation_participant(conversation_id)')
          .neq('id', myId);
      return data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
