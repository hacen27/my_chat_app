import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/chat_page.dart';
import 'package:my_chat_app/pages/login_page.dart';
import 'package:my_chat_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../providers/registerProvider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.isRegistering}) : super(key: key);

  static Route<void> route({bool isRegistering = false}) {
    return MaterialPageRoute(
      builder: (context) => RegisterPage(isRegistering: isRegistering),
    );
  }

  final bool isRegistering;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final bool _isLoading = false;

  // final _formKey = GlobalKey<FormState>();

  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();
  // final _usernameController = TextEditingController();

  // Future<void> _signUp() async {
  //   final isValid = _formKey.currentState!.validate();
  //   if (!isValid) {
  //     return;
  //   }
  //   final email = _emailController.text;
  //   final password = _passwordController.text;
  //   final username = _usernameController.text;
  //   try {
  //     await supabase.auth.signUp(
  //         email: email, password: password, data: {'username': username});
  //     Navigator.of(context)
  //         .pushAndRemoveUntil(ChatPage.route(), (route) => false);
  //   } on AuthException catch (error) {
  //     context.showErrorSnackBar(message: error.message);
  //   } catch (error) {
  //     context.showErrorSnackBar(message: unexpectedErrorMessage);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: Consumer<RegisterProvider>(builder: (context, regisPro, child) {
          return Form(
            key: regisPro.formKey,
            child: ListView(
              padding: formPadding,
              children: [
                TextFormField(
                  controller: regisPro.emailController,
                  decoration: const InputDecoration(
                    label: Text('Email'),
                  ),
                  validator: regisPro.emailValidator,
                  keyboardType: TextInputType.emailAddress,
                ),
                formSpacer,
                TextFormField(
                    controller: regisPro.passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      label: Text('Password'),
                    ),
                    validator: regisPro.passwordValidator),
                formSpacer,
                TextFormField(
                    controller: regisPro.usernameController,
                    decoration: const InputDecoration(
                      label: Text('Username'),
                    ),
                    validator: regisPro.usernameValidator),
                formSpacer,
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                          regisPro.signUp(
                              context,
                              regisPro.emailController,
                              regisPro.passwordController,
                              regisPro.usernameController,
                              regisPro.formKey);
                        },
                  child: const Text('Register'),
                ),
                formSpacer,
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(LoginPage.route());
                  },
                  child: const Text('I already have an account'),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
