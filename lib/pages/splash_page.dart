import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/accounts/register_page.dart';
import 'package:my_chat_app/pages/home_page.dart';
import 'package:my_chat_app/utils/constants.dart';

import 'package:my_chat_app/utils/supabase_constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  static const path = '/';
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    try {
      final session = supabase.auth.currentSession;
      if (session == null && mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, RegisterPage.path, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, HomePage.path, (route) => false);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: preloader);
  }
}
