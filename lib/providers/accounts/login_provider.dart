import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:my_chat_app/pages/conversations_page.dart';
import 'package:my_chat_app/pages/widgets/customsnackbar.dart';
import 'package:my_chat_app/providers/accounts/auth_provider.dart';
import 'package:my_chat_app/utils/localizations_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../pages/widgets/formz.dart';
import '../../utils/constants.dart';

class LoginProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late MyForm state;

  AuthProvider? get authProvider => AuthProvider();

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
      await authProvider!.login(
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
      ErrorSnackBar(message: error.message).show(context);

      isLoading = false;
    } catch (_) {
      log(_.toString());
      const ErrorSnackBar(message: unexpectedErrorMessage).show(context);

      isLoading = false;
    }

    // final successSnackBar = SnackBar(
    //   // ignore: use_build_context_synchronously
    //   content: Text(LocalizationsHelper.msgs(context).submittedSuccessfully),
    // );
    // final failureSnackBar = SnackBar(
    //   // ignore: use_build_context_synchronously
    //   content: Text(LocalizationsHelper.msgs(context).somethingWentWrong),
    // );

    // // ignore: use_build_context_synchronously
    // ScaffoldMessenger.of(context)
    //   ..hideCurrentSnackBar()
    //   ..showSnackBar(
    //     state.status.isSuccess ? successSnackBar : failureSnackBar,
    //   );

    notifyListeners();
  }
}
