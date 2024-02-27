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

class ErrorSnackBar extends StatelessWidget {
  final String message;

  const ErrorSnackBar({Key? key, required this.message}) : super(key: key);

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
