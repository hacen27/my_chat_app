import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/conversation/conversations_page.dart';
import 'package:my_chat_app/providers/account/auth_provider.dart';
import 'package:my_chat_app/utils/error_handling.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
//formz
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  AuthProvider? get authProvider => AuthProvider();

  Future<void> signUp(BuildContext context) async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }
    final email = emailController.text;
    final password = passwordController.text;
    final username = usernameController.text;
    try {
      await authProvider!.signUp(email, password, username);

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, ConversationsPage.path, (route) => false);
      }
    } on AuthException catch (error) {
      log(error.toString());
      ErrorHandling.signUpException(error);
    } catch (_) {
      ErrorHandling.signUpException(
        _,
      );
    }
    notifyListeners();
  }
}
