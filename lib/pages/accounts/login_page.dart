import 'package:flutter/material.dart';
import 'package:my_chat_app/providers/accounts/login_provider.dart';
import 'package:my_chat_app/utils/constants.dart';
import 'package:my_chat_app/utils/localizations_helper.dart';
import 'package:provider/provider.dart';

import '../widgets/formz.dart';

class LoginPage extends StatefulWidget {
  static const path = "/login";
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LoginProvider.initialize(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              LocalizationsHelper.msgs(context).loginButton,
            ),
          ),
          body: Consumer<LoginProvider?>(builder: (context, loginPro, child) {
            if (loginPro == null) {
              return const CircularProgressIndicator();
            }
            return Form(
              key: loginPro.formKey,
              child: Localizations.override(
                context: context,
                child: ListView(
                  padding: formPadding,
                  children: [
                    TextFormField(
                      controller: loginPro.emailController,
                      decoration: InputDecoration(
                          labelText:
                              LocalizationsHelper.msgs(context).emailLabel),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => loginPro.state.email
                          .validator(value ?? '')
                          ?.text(context),
                    ),
                    formSpacer,
                    TextFormField(
                      controller: loginPro.passwordController,
                      decoration: InputDecoration(
                          labelText:
                              LocalizationsHelper.msgs(context).passwordLabel),
                      obscureText: true,
                      validator: (value) => loginPro.state.password
                          .validator(value ?? '')
                          ?.text(context),
                    ),
                    formSpacer,
                    ElevatedButton(
                      onPressed: loginPro.isLoading
                          ? null
                          : () async {
                              loginPro.signIn(
                                context,
                              );
                            },
                      child: Text(
                        LocalizationsHelper.msgs(context).loginButton,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ));
  }
}
