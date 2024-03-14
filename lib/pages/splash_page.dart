import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:my_chat_app/pages/account/register_page.dart';
import 'package:my_chat_app/pages/home/home_page.dart';

import 'package:my_chat_app/services/last_route.dart';
import 'package:my_chat_app/utils/constants.dart';

import 'package:my_chat_app/utils/supabase_constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  static const path = '/';
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  final lastRoute = LastRoute();

  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(const Duration(seconds: 0));
    if (!mounted) return;

    final lastUri = Uri.parse(LastRoute().lastPath);

    try {
      final session = supabase.auth.currentSession;
      if (session == null && mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, RegisterPage.path, (route) => false);
      } else {
        if (lastUri.path == '/') {
          Navigator.pushNamedAndRemoveUntil(
              context, HomePage.path, (route) => false);
        } else {}
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //       context.go(
  //         session == null ? RegisterPage.path : HomePage.path,
  //       );
  //     }
  //   } catch (e) {
  //     // Handle errors appropriately
  //     log(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: preloader);
  }
}
