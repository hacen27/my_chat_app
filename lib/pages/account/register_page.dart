import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/account/login_page.dart';
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
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 70,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              child: const Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'ChatApp',
                              style: Theme.of(context).textTheme.displayMedium,
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
                          validator: (val) => validator.password(val, context),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: regisPro.usernameController,
                          decoration: InputDecoration(
                            label: Text(LocalizationsHelper.msgs(context)
                                .usernameLabel),
                          ),
                          validator: (val) => validator.username(val, context),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            regisPro.signUp(context);
                          },
                          child: Text(
                              LocalizationsHelper.msgs(context).registerButton),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, LoginPage.path);
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
          );
        }),
      ),
    );
  }
}
