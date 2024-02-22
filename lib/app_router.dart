import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/accounts/login_page.dart';
import 'package:my_chat_app/pages/accounts/register_page.dart';
import 'package:my_chat_app/pages/add_profils.dart';
import 'package:my_chat_app/pages/chat_page.dart';
import 'package:my_chat_app/pages/conversations_page.dart';
import 'package:my_chat_app/pages/coversationdetails.dart';
import 'package:my_chat_app/pages/profiles_page.dart';
import 'package:my_chat_app/pages/splash_page.dart';

class AppRouter {
  AppRouter();
  Route? generateRoute(RouteSettings settings) {
    return CupertinoPageRoute(
      settings: settings,
      builder: (context) {
        switch (settings.name) {
          case SplashPage.path:
            return const SplashPage();

          case LoginPage.path:
            return const LoginPage();
          case RegisterPage.path:
            return const RegisterPage();
          case ChatPage.path:
            final argscht = settings.arguments as ArgumentsChat;
            return ChatPage(
              args: argscht,
            );
          case ConversationsPage.path:
            return const ConversationsPage();
          case ProfilesPage.path:
            return const ProfilesPage();
          case ConversationDetails.path:
            return const ConversationDetails();
          case AddProfiles.path:
            return const AddProfiles();

          default:
            return Scaffold(
              body:
                  Center(child: Text('No route defined for ${settings.name}')),
            );
        }
      },
    );
  }
}
