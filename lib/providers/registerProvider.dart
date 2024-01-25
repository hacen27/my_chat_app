import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/conversations_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../utils/constants.dart';

class RegisterProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
//formz
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  Future<void> signUp(BuildContext context) async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }
    final email = emailController.text;
    final password = passwordController.text;
    final username = usernameController.text;
    try {
      await supabase.auth.signUp(
          email: email, password: password, data: {'username': username});

      notifyListeners();

      Navigator.pushNamedAndRemoveUntil(
          context, ConversationsPage.path, (route) => false);
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: unexpectedErrorMessage);
    }
  }
}
