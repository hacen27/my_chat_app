import 'package:flutter/material.dart';
import 'package:my_chat_app/utils/localizations_helper.dart';

class AppValidator {
  String? email(String? val, BuildContext? context) {
    if (val == null || val.isEmpty) {
      return LocalizationsHelper.msgs(context!).required;
    }

    return null;
  }

  String? password(String? val, BuildContext? context) {
    if (val == null || val.isEmpty) {
      return LocalizationsHelper.msgs(context!).required;
    }
    if (val.length < 6) {
      return LocalizationsHelper.msgs(context!).min6Characters;
    }

    return null;
  }

  String? username(String? val, BuildContext? context) {
    if (val == null || val.isEmpty) {
      return LocalizationsHelper.msgs(context!).required;
    }
    final isValid = RegExp(r'^[A-Za-z0-9_]{3,24}$').hasMatch(val);
    if (!isValid) {
      return LocalizationsHelper.msgs(context!).alphanumericUnderscore;
    }
    return null;
  }
}
