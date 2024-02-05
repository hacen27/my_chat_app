import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:my_chat_app/utils/localizations_helper.dart';

class MyForm with FormzMixin {
  MyForm({
    Email? email,
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
  }) : email = email ?? Email.pure();

  final Email email;
  final Password password;
  final FormzSubmissionStatus status;

  MyForm copyWith({
    Email? email,
    Password? password,
    FormzSubmissionStatus? status,
  }) {
    return MyForm(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [email, password];
}

enum EmailValidationError {
  invalid,
  empty;
}

class Email extends FormzInput<String, EmailValidationError>
    with FormzInputErrorCacheMixin {
  Email.pure([super.value = '']) : super.pure();

  Email.dirty([super.value = '']) : super.dirty();

  static final _emailRegExp = RegExp(
    r'^[a-zA-Z\d.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z\d-]+(?:\.[a-zA-Z\d-]+)*$',
  );

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) {
      return EmailValidationError.empty;
    } else if (!_emailRegExp.hasMatch(value)) {
      return EmailValidationError.invalid;
    }

    return null;
  }
}

enum PasswordValidationError { invalid, empty }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure([super.value = '']) : super.pure();

  const Password.dirty([super.value = '']) : super.dirty();

  static final _passwordRegex =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    } else if (!_passwordRegex.hasMatch(value)) {
      return PasswordValidationError.invalid;
    }

    return null;
  }
}

extension EmailValidationErrorExtension on EmailValidationError {
  String text(BuildContext context) {
    switch (this) {
      case EmailValidationError.invalid:
        return LocalizationsHelper.msgs(context).emailValidation;
      case EmailValidationError.empty:
        return LocalizationsHelper.msgs(context).emptyEmailField;
    }
  }
}

extension PasswordValidationErrorExtension on PasswordValidationError {
  String text(BuildContext context) {
    switch (this) {
      case PasswordValidationError.invalid:
        return LocalizationsHelper.msgs(context).passwordValidation;

      case PasswordValidationError.empty:
        return LocalizationsHelper.msgs(context).emptyPasswordField;
    }
  }
}
