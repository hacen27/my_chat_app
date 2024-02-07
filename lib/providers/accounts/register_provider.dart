import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/conversations_page.dart';
import 'package:my_chat_app/pages/widgets/customsnackbar.dart';
import 'package:my_chat_app/providers/accounts/auth_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../utils/constants.dart';

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

      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
          context, ConversationsPage.path, (route) => false);
    } on AuthException catch (error) {
      ErrorSnackBar(message: error.message);
    } catch (error) {
      const ErrorSnackBar(message: unexpectedErrorMessage);
    }
    notifyListeners();
  }
}
