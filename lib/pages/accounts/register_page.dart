import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/accounts/login_page.dart';
import 'package:provider/provider.dart';

import '../../providers/account/register_provider.dart';

import '../../utils/localizations_helper.dart';
import '../../utils/validator.dart';

class RegisterPage extends StatefulWidget {
  static const path = "/register";
  const RegisterPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AppValidator validator = AppValidator();

  late String currentDefaultSystemLocale;

  int selectedLangIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocalizationsHelper.msgs(context).registerButton),
        ),
        body: Consumer<RegisterProvider?>(builder: (context, regisPro, child) {
          if (regisPro == null) {
            return const CircularProgressIndicator();
          }
          return Form(
            key: regisPro.formKey,
            child: Localizations.override(
              context: context,
              child: Center(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
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
                            controller: regisPro.emailController,
                            decoration: InputDecoration(
                              label: Text(
                                  LocalizationsHelper.msgs(context).emailLabel),
                            ),
                            validator: (val) => validator.email(val, context),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: regisPro.passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              label: Text(LocalizationsHelper.msgs(context)
                                  .passwordLabel),
                            ),
                            validator: (val) =>
                                validator.password(val, context),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: regisPro.usernameController,
                            decoration: InputDecoration(
                              label: Text(LocalizationsHelper.msgs(context)
                                  .usernameLabel),
                            ),
                            validator: (val) =>
                                validator.username(val, context),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              regisPro.signUp(context);
                            },
                            child: Text(LocalizationsHelper.msgs(context)
                                .registerButton),
                          ),
                          const SizedBox(height: 20),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, LoginPage.path, (route) => false);
                            },
                            child: Text(LocalizationsHelper.msgs(context)
                                .alreadyHaveAccount),
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
      ),
    );
  }
}
