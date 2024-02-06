import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider {
  final _client = Supabase.instance.client;

  User? getUser() {
    return _client.auth.currentUser;
  }
}
