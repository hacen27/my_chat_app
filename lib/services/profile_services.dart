import 'package:my_chat_app/models/profile.dart';
import 'package:my_chat_app/providers/account/auth_provider.dart';
import 'package:my_chat_app/utils/supabase_constants.dart';

class ProfileServices {
  final AuthProvider authProvider = AuthProvider();

  Future<List<Profile>> allProfiles(String myId) async {
    final data = await supabase
        .from('profile')
        .select('id, username,created_at')
        .neq('id', myId);
    return data.map((profile) => Profile.fromJson(profile)).toList();
  }

  Future<List<ProfileParticipant>> getProfilesParticipantByConversationId(
      String conversationId) async {
    final data = await supabase
        .from('conversation_participant')
        .select('profile:profile!inner(*)')
        .eq('conversation_id,', conversationId)
        .order('created_at', ascending: false);

    return data.map((pp) => ProfileParticipant.fromJson(pp)).toList();
  }

  Future<List<Profile>> getProfilesNotInConversation(
      String conversationId) async {
    final profileIds = await supabase
        .from('conversation_participant')
        .select('profile_id')
        .eq('conversation_id,', conversationId);

    List ids = [];
    for (var profile in profileIds) {
      ids.add(profile['profile_id']);
    }

    final data = await supabase
        .from('profile')
        .select('id, username,created_at')
        .not('id', 'in', ids)
        .order('created_at', ascending: false);

    return data.map((p) => Profile.fromJson(p)).toList();
  }

  Future<void> addToConversation(
      List<String> profileIds, String conversationsId) async {
    List<Map<String, dynamic>> participants = [
      for (final profileId in profileIds)
        {
          'conversation_id': conversationsId,
          'profile_id': profileId,
        }
    ];

    await supabase
        .from('conversation_participant')
        .insert(participants)
        .select();
  }

  Future<void> quitConversation(String conversationsId, String myId) async {
    await supabase
        .from('conversation_participant')
        .delete()
        .filter('conversation_id', 'eq', conversationsId)
        .eq('profile_id', myId);
  }
}
