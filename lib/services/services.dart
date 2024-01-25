import 'package:my_chat_app/models/conversations.dart';
import 'package:my_chat_app/utils/constants.dart';

Newconversation? newconversation;

class WebServices {
  Future<dynamic> newConversationService(String profileId) async {
    final conversation =
        await supabase.from('conversation').insert({}).select();

    newconversation = Newconversation.fromJson(conversation.first);

    final conversationdata =
        await supabase.from('conversation_participant').insert([
      {'conversation_id': newconversation!.id, 'profile_id': profileId},
    ]).select();

    return conversationdata;
  }

  Future<dynamic> conversationByIdService(String conversationId) async {
    try {
      final profile_id = await supabase.auth.currentUser!.id;

      final data = await supabase
          .from('conversation')
          .select(
              'id, created_at, messages(id, content,created_at),profiles(id, username,created_at)')
          .eq('profile_id', conversationId)
          .order('created_at', ascending: false)
          .single();
      return data;
    } catch (e) {
      print(e.toString());
      return {};
    }
  }

  Future<List<dynamic>> conversationService() async {
    final profile_id = await supabase.auth.currentUser!.id;
    try {
      final data = await supabase
          .from('conversation')
          .select(
              'id, created_at,  message!inner(*),profile(id, username,created_at)')
          .eq('message.send_id', profile_id)
          .order('created_at', ascending: false)
          .limit(10);
      return data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> profilesService() async {
    try {
      final data = await supabase
          .from('profile')
          .select('id, username,created_at,conversation(id)')
          .isFilter('conversation(id)', null);
      return data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
