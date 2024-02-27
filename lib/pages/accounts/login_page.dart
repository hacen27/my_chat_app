import 'package:flutter/material.dart';
import 'package:my_chat_app/providers/account/login_provider.dart';

import 'package:my_chat_app/utils/localizations_helper.dart';
import 'package:provider/provider.dart';

import '../widgets/form_widget.dart';

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
        create: (_) => LoginProvider(),
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
                child: Center(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Column(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.amber,
                                  child: Icon(
                                    Icons.person,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'ChatApp',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 35),
                            TextFormField(
                              controller: loginPro.emailController,
                              decoration: InputDecoration(
                                labelText: LocalizationsHelper.msgs(context)
                                    .emailLabel,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) => loginPro.state.email
                                  .validator(value ?? '')
                                  ?.text(context),
                            ),
                            const SizedBox(height: 25),
                            TextFormField(
                              controller: loginPro.passwordController,
                              decoration: InputDecoration(
                                labelText: LocalizationsHelper.msgs(context)
                                    .passwordLabel,
                              ),
                              obscureText: true,
                              validator: (value) => loginPro.state.password
                                  .validator(value ?? '')
                                  ?.text(context),
                            ),
                            const SizedBox(height: 25),
                            ElevatedButton(
                              onPressed: loginPro.isLoading
                                  ? null
                                  : () async {
                                      loginPro.signIn(context);
                                    },
                              child: Text(
                                LocalizationsHelper.msgs(context).loginButton,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ));
  }
}
