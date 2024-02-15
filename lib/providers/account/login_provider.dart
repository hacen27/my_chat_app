import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:my_chat_app/pages/conversations_page.dart';
import 'package:my_chat_app/providers/account/auth_provider.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import '../../pages/widgets/formz.dart';
import '../../utils/error_handling.dart';

class LoginProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late MyForm state;

  AuthProvider get authProvider => AuthProvider();

  LoginProvider() {
    state = MyForm();
    emailController = TextEditingController(text: state.email.value)
      ..addListener(_onEmailChanged);
    passwordController = TextEditingController(text: state.password.value)
      ..addListener(_onPasswordChanged);
  }

  void _onEmailChanged() {
    state = state.copyWith(email: Email.dirty(emailController.text));
    notifyListeners();
  }

  void _onPasswordChanged() {
    state = state.copyWith(
      password: Password.dirty(passwordController.text),
    );
    notifyListeners();
  }

  Future<void> signIn(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    state = state.copyWith(status: FormzSubmissionStatus.inProgress);

    try {
      await authProvider.login(
        emailController.text,
        passwordController.text,
      );

      isLoading = true;
      state = state.copyWith(status: FormzSubmissionStatus.success);

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, ConversationsPage.path, (route) => false);
      }
    } on AuthException catch (error) {
      log(error.toString());

      ErrorHandling.signInException(error, context);

      isLoading = false;
    } catch (_) {
      log(_.toString());
      ErrorHandling.signInException(_, context);

      isLoading = false;
    }

    notifyListeners();
  }
}
