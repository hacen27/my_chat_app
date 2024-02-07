import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Duration duration;

  const CustomSnackBar({
    Key? key,
    required this.message,
    this.backgroundColor = Colors.white,
    this.duration = const Duration(seconds: 4),
  }) : super(key: key);

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ErrorSnackBar extends CustomSnackBar {
  const ErrorSnackBar({
    Key? key,
    required String message,
  }) : super(key: key, message: message, backgroundColor: Colors.red);
}
