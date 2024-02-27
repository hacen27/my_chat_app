import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/accounts/login_page.dart';
import 'package:my_chat_app/pages/accounts/register_page.dart';
import 'package:my_chat_app/pages/add_profiles.dart';
import 'package:my_chat_app/pages/chat_page.dart';
import 'package:my_chat_app/pages/conversations_page.dart';
import 'package:my_chat_app/pages/conversation_details.dart';
import 'package:my_chat_app/pages/home_page.dart';
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
            final argsChat = settings.arguments as ArgumentsChat;
            return ChatPage(
              args: argsChat,
            );
          case ConversationsPage.path:
            return const ConversationsPage();
          case ProfilesPage.path:
            return const ProfilesPage();
          case ConversationDetails.path:
            return const ConversationDetails();
          case AddProfiles.path:
            return const AddProfiles();
          case HomePage.path:
            return const HomePage();

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
