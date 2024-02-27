import 'package:flutter/material.dart';
import 'package:my_chat_app/models/app_language.dart';
import 'package:my_chat_app/pages/accounts/register_page.dart';
import 'package:my_chat_app/providers/locale_provider.dart';
import 'package:my_chat_app/utils/localizations_helper.dart';
import 'package:my_chat_app/utils/supabase_constants.dart';
import 'package:provider/provider.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  late AppLanguage dropdownValue;
  late String currentDefaultSystemLocale;
  late LocaleProvider _appLocale;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          TextButton(
            onPressed: () async {
              await supabase.auth.signOut();
              if (mounted) {
                Navigator.pushNamedAndRemoveUntil(
                    context, RegisterPage.path, (route) => false);
              }
            },
            child: const Text('Logout'),
          ),
        ],
      ),
      body: buildLanguageDropdown(),
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
