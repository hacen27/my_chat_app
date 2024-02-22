import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/accounts/login_page.dart';
import 'package:my_chat_app/providers/locale_provider.dart';
import 'package:my_chat_app/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../models/app_language.dart';

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
  late LocaleProvider _appLocale;
  final AppValidator validator = AppValidator();
  late AppLanguage dropdownValue;
  late String currentDefaultSystemLocale;

  int selectedLangIndex = 0;
  @override
  void initState() {
    super.initState();
    dropdownValue = AppLanguage.languages().first;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocale = Provider.of<LocaleProvider>(context);
    getLocale().then((locale) {
      _appLocale.changeLocale(Locale(locale.languageCode));
      dropdownValue = AppLanguage.languages()
          .firstWhere((element) => element.languageCode == locale.languageCode);
      _setFlag();
    });
  }

  void _setFlag() {
    currentDefaultSystemLocale = _appLocale.locale.languageCode.split('_')[0];
    setState(() {
      selectedLangIndex = _getLangIndex(currentDefaultSystemLocale);
    });
  }

  int _getLangIndex(String currentDefaultSystemLocale) {
    int langIndex = 0;
    switch (currentDefaultSystemLocale) {
      case 'en':
        langIndex = 0;
        break;
      case 'fr':
        langIndex = 1;
        break;
      case 'ar':
        langIndex = 2;
        break;
    }
    return langIndex;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocalizationsHelper.msgs(context).registerButton),
          actions: [
            buildLanguageDropdown(),
          ],
        ),
        body: Consumer<RegisterProvider?>(builder: (context, regisPro, child) {
          if (regisPro == null) {
            return const CircularProgressIndicator();
          }
          return Form(
            key: regisPro.formKey,
            child: ListView(
              padding: formPadding,
              children: [
                TextFormField(
                  controller: regisPro.emailController,
                  decoration: InputDecoration(
                    label: Text(LocalizationsHelper.msgs(context).emailLabel),
                  ),
                  validator: (val) => validator.email(val, context),
                  keyboardType: TextInputType.emailAddress,
                ),
                formSpacer,
                TextFormField(
                    controller: regisPro.passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      label:
                          Text(LocalizationsHelper.msgs(context).passwordLabel),
                    ),
                    validator: (val) => validator.password(val, context)),
                formSpacer,
                TextFormField(
                    controller: regisPro.usernameController,
                    decoration: InputDecoration(
                      label:
                          Text(LocalizationsHelper.msgs(context).usernameLabel),
                    ),
                    validator: (val) => validator.username(val, context)),
                formSpacer,
                ElevatedButton(
                  onPressed: () async {
                    regisPro.signUp(
                      context,
                    );
                  },
                  child: Text(LocalizationsHelper.msgs(context).registerButton),
                ),
                formSpacer,
                TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginPage.path, (route) => false);
                  },
                  child: Text(
                      LocalizationsHelper.msgs(context).alreadyHaveAccount),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget buildLanguageDropdown() {
    return Center(
      child: DropdownButton<AppLanguage>(
        value: dropdownValue,
        iconSize: 40,
        style: const TextStyle(fontSize: 20),
        onChanged: (AppLanguage? language) {
          dropdownValue = language!;
          _appLocale.changeLocale(Locale(language.languageCode));
          _setFlag();
          setLocale(language.languageCode);
        },
        items: AppLanguage.languages()
            .map<DropdownMenuItem<AppLanguage>>(
              (e) => DropdownMenuItem<AppLanguage>(
                value: e,
                child: Text(
                  e.name,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
