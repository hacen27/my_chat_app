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
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(selectedLang, languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString(selectedLang) ?? 'en';
  return Locale(languageCode);
}
