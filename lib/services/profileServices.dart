import 'package:my_chat_app/models/profile.dart';
import 'package:my_chat_app/utils/constants.dart';

class ProfileServices {
  List<Profile> profiles = [];
  List<ProfileParticipant> profileParticipant = [];

  Future<List<Profile>> allprofiles() async {
    final myId = supabase.auth.currentUser!.id;
    try {
      final data = await supabase
          .from('profile')
          .select('id, username,created_at')
          .neq('id', myId);
      profiles = data.map((profile) => Profile.fromJson(profile)).toList();
      return profiles;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<ProfileParticipant>> getprofilesPByconId(
      String conversationId) async {
    // final myId = supabase.auth.currentUser!.id;
    try {
      final data = await supabase
          .from('conversation_participant')
          .select('profile:profile!inner(*)')
          .eq('conversation_id,', conversationId)
          .order('created_at', ascending: false);
      print(data);

      profileParticipant =
          data.map((pp) => ProfileParticipant.fromJson(pp)).toList();

      return profileParticipant;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<Profile>> getprofilesByconId(String conversationId) async {
    try {
      final profileIds = await supabase
          .from('conversation_participant')
          .select('profile_id')
          .eq('conversation_id,', conversationId);

      List Ids = [];
      profileIds.forEach((profile) {
        Ids.add(profile['profile_id']);
      });
      print(Ids);

      final data = await supabase
          .from('profile')
          .select('id, username,created_at')
          .not('id', 'in', Ids)
          .order('created_at', ascending: false);
      print(profileIds);
      print(conversationId);

      profiles = data.map((p) => Profile.fromJson(p)).toList();

      return profiles;
    } catch (e) {
      print(e.toString());
      return [];
    }
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
    final myId = supabase.auth.currentUser!.id;

    await supabase
        .from('conversation_participant')
        .delete()
        .filter('conversation_id', 'eq', coversationId)
        .eq('profile_id', myId);
  }
}
