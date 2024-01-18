import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String selectedLang = "selectedLang";

class LocalizationsHelper {
  static AppLocalizations msgs(BuildContext context) =>
      AppLocalizations.of(context)!;

  static List<Locale> languages() => AppLocalizations.supportedLocales.toList();
}

Future setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(selectedLang, languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(selectedLang) ?? 'en';
  return Locale(languageCode);
}
