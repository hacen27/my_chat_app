import 'package:my_chat_app/models/profile.dart';
import 'package:my_chat_app/providers/accounts/auth_provider.dart';
import 'package:my_chat_app/utils/supabase_constants.dart';

class ProfileServices {
  final AuthProvider authProvider = AuthProvider();

  Future<List<Profile>> allprofiles() async {
    final myId = authProvider.getUser()!.id;

    final data = await supabase
        .from('profile')
        .select('id, username,created_at')
        .neq('id', myId);
    return data.map((profile) => Profile.fromJson(profile)).toList();
  }

  Future<List<ProfileParticipant>> getprofilesPByconId(
      String conversationId) async {
    // final myId = supabase.auth.currentUser!.id;

    final data = await supabase
        .from('conversation_participant')
        .select('profile:profile!inner(*)')
        .eq('conversation_id,', conversationId)
        .order('created_at', ascending: false);
    print(data);

    return data.map((pp) => ProfileParticipant.fromJson(pp)).toList();
  }

  Future<List<Profile>> getprofilesByconId(String conversationId) async {
    final profileIds = await supabase
        .from('conversation_participant')
        .select('profile_id')
        .eq('conversation_id,', conversationId);

    List iDs = [];
    profileIds.forEach((profile) {
      iDs.add(profile['profile_id']);
    });

    final data = await supabase
        .from('profile')
        .select('id, username,created_at')
        .not('id', 'in', iDs)
        .order('created_at', ascending: false);

    return data.map((p) => Profile.fromJson(p)).toList();
  }

  Future<dynamic> addToConversation(
      List<String> profileIds, String coversationId) async {
    List<Map<String, dynamic>> participants = [
      for (final profileId in profileIds)
        {
          'conversation_id': coversationId,
          'profile_id': profileId,
        }
    ];

    final conversationdata = await supabase
        .from('conversation_participant')
        .insert(participants)
        .select();

    return conversationdata;
  }

  Future<void> quitConversation(String coversationId) async {
    final myId = authProvider.getUser()!.id;
    await supabase
        .from('conversation_participant')
        .delete()
        .filter('conversation_id', 'eq', coversationId)
        .eq('profile_id', myId);
  }
}
