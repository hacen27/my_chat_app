import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/accounts/login_page.dart';
import 'package:my_chat_app/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../models/appLonguages.dart';
import '../../providers/appLocal.dart';
import '../../providers/accounts/registerProvider.dart';
import '../../utils/localizations_helper.dart';
import '../../utils/validator.dart';

class RegisterPage extends StatefulWidget {
  static const path = "/register";
  const RegisterPage({Key? key, required this.isRegistering}) : super(key: key);

  final bool isRegistering;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final bool _isLoading = false;
  final AppValidator vald = AppValidator();
  late String currentDefaultSystemLocale;
  int selectedLangIndex = 0;
  var _appLocale;

  late AppLanguage dropdownValue;
  @override
  void initState() {
    super.initState();
    dropdownValue = AppLanguage.languages().first;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocale = Provider.of<AppLocale>(context);
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
    int _langIndex = 0;
    switch (currentDefaultSystemLocale) {
      case 'en':
        _langIndex = 0;
        break;
      case 'fr':
        _langIndex = 1;
        break;
      case 'ar':
        _langIndex = 2;
        break;
    }
    return _langIndex;
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
                  validator: (val) => vald.email(val, context),
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
                    validator: (val) => vald.password(val, context)),
                formSpacer,
                TextFormField(
                    controller: regisPro.usernameController,
                    decoration: InputDecoration(
                      label:
                          Text(LocalizationsHelper.msgs(context).usernameLabel),
                    ),
                    validator: (val) => vald.username(val, context)),
                formSpacer,
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
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
                child: Text(e.name),
              ),
            )
            .toList(),
      ),
    );
  }
}
