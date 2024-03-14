import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessenger =
    GlobalKey<ScaffoldMessengerState>();

class CustomSnackBar {
  final String message;
  final Color backgroundColor;
  final Duration duration;

  CustomSnackBar({
    required this.message,
    this.backgroundColor = Colors.white,
    this.duration = const Duration(seconds: 4),
  });

  void show() {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      duration: duration,
    );

    scaffoldMessenger.currentState?.showSnackBar(snackBar);
  }
}

class ErrorSnackBar {
  final String message;

  ErrorSnackBar({required this.message});

  void show() {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 4),
    );

    scaffoldMessenger.currentState?.showSnackBar(snackBar);
  }
}
