import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider {
  final _client = Supabase.instance.client;
  static final AuthProvider _instance = AuthProvider._singleton();

  AuthProvider._singleton();

  factory AuthProvider() {
    return _instance;
  }

  User? getUser() {
    return _client.auth.currentUser;
  }

  Future<AuthResponse> login(String email, String password) async {
    final response =
        await _client.auth.signInWithPassword(email: email, password: password);

    return response;
  }

  Future<AuthResponse> signUp(
      String email, String password, String username) async {
    final response = await _client.auth
        .signUp(email: email, password: password, data: {'username': username});

    return response;
  }

  Future<void> logout() async {
    await _client.auth.signOut();
  }
}
