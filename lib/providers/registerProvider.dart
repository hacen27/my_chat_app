import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../pages/chat_page.dart';
import '../utils/constants.dart';

class RegisterProvider with ChangeNotifier {
  bool _isLoading = false;

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  bool get isLoading => _isLoading;

  RegisterProvider() {
    if (kDebugMode) {
      print('=====///=============///=====');
      print('Register provider Started');
      print('///==========///==========///');
    }
  }
  Future<void> signUp(BuildContext context, emailController, passwordController,
      usernameController, formKey) async {
    if (kDebugMode) {
      print('=====///=============///=====');
      print('signUp started');
      print('///==========///==========///');
    }
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
      Navigator.of(context)
          .pushAndRemoveUntil(ChatPage.route(), (route) => false);
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: unexpectedErrorMessage);
    }
  }

  String? emailValidator(String? val) {
    if (val == null || val.isEmpty) {
      return 'Required';
    }
    // Add more email validation if needed
    return null;
  }

  String? passwordValidator(String? val) {
    if (val == null || val.isEmpty) {
      return 'Required';
    }
    if (val.length < 6) {
      return '6 characters minimum';
    }
    // Add more password validation if needed
    return null;
  }

  String? usernameValidator(String? val) {
    if (val == null || val.isEmpty) {
      return 'Required';
    }
    final isValid = RegExp(r'^[A-Za-z0-9_]{3,24}$').hasMatch(val);
    if (!isValid) {
      return '3-24 long with alphanumeric or underscore';
    }
    return null;
  }
}
