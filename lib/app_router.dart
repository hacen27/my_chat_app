import 'package:flutter/material.dart';

import 'package:my_chat_app/pages/account/login_page.dart';
import 'package:my_chat_app/pages/account/register_page.dart';
import 'package:my_chat_app/pages/profile/add_profiles.dart';
import 'package:my_chat_app/pages/chat/chat_page.dart';
import 'package:my_chat_app/pages/conversation/conversations_page.dart';
import 'package:my_chat_app/pages/conversation/conversation_details.dart';
import 'package:my_chat_app/pages/home/home_page.dart';
import 'package:my_chat_app/pages/profile/profiles_page.dart';
import 'package:my_chat_app/pages/splash_page.dart';

class AppRouter {
  AppRouter();

  Route generateRoute(RouteSettings? settings) {
    final route = Uri.parse(settings!.name!);

    WidgetBuilder builder;

    switch (route.path) {
      case LoginPage.path:
        builder = (_) => const LoginPage();
        break;

      case RegisterPage.path:
        builder = (_) => const RegisterPage();
        break;
      case ChatPage.path:
        builder = (_) => ChatPage(
              conversationId: route.queryParameters["id"]!,
              title: route.queryParameters["title"]!,
            );
        break;
      case ConversationsPage.path:
        builder = (_) => const ConversationsPage();
        break;
      case ProfilesPage.path:
        builder = (_) => const ProfilesPage();
        break;

      case ConversationDetails.path:
        builder = (_) => ConversationDetails(
              id: route.queryParameters["id"]!,
              title: route.queryParameters["title"]!,
            );
        break;
      case AddProfiles.path:
        builder = (_) => AddProfiles(
              conversationId: route.queryParameters["id"]!,
            );
        break;
      case HomePage.path:
        builder = (_) => const HomePage();
        break;
      case SplashPage.path:
        builder = (_) => const SplashPage();
        break;

      default:
        builder = (_) => const Scaffold(
              body: Center(child: Text("Route n'est pas definie")),
            );
        break;
    }

    return MaterialPageRoute(builder: builder, settings: settings);
  }
}
