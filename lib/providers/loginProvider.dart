import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:my_chat_app/pages/conversations_page.dart';
import 'package:my_chat_app/utils/localizations_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../pages/widgets/formz.dart';
import '../utils/constants.dart';

class LoginProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
//formz
  bool isLoading = false;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late MyForm state;

  LoginProvider.initialize() {
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
      await supabase.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      isLoading = true;
      state = state.copyWith(status: FormzSubmissionStatus.success);

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, ConversationsPage.path, (route) => false);
      }
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
      isLoading = false;
    } catch (_) {
      log(_.toString());
      context.showErrorSnackBar(message: unexpectedErrorMessage);
      isLoading = false;
    }

    final successSnackBar = SnackBar(
      content: Text(LocalizationsHelper.msgs(context).submittedSuccessfully),
    );
    final failureSnackBar = SnackBar(
      content: Text(LocalizationsHelper.msgs(context).somethingWentWrong),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        state.status.isSuccess ? successSnackBar : failureSnackBar,
      );

    notifyListeners();
  }
}
