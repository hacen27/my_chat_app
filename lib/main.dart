import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_chat_app/pages/addlistprofils.dart';
import 'package:my_chat_app/pages/coversationdetails.dart';
import 'package:my_chat_app/pages/screenprofiles.dart';
import 'package:my_chat_app/pages/chat_page.dart';
import 'package:my_chat_app/pages/conversations_page.dart';
import 'package:my_chat_app/pages/accounts/login_page.dart';
import 'package:my_chat_app/pages/accounts/register_page.dart';
import 'package:my_chat_app/pages/widgets/apptheme.dart';
import 'package:my_chat_app/providers/localeprovider.dart';
import 'package:my_chat_app/utils/supabase_constants.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_chat_app/pages/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConstants.baseUrl,
    anonKey: SupabaseConstants.baseKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: Consumer<LocaleProvider>(builder: (context, locale, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My Chat App',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: locale.locale,
          theme: appTheme,
          initialRoute: SplashPage.path,
          routes: {
            SplashPage.path: (context) => const SplashPage(),
            ChatPage.path: (context) => const ChatPage(),
            LoginPage.path: (context) => const LoginPage(),
            RegisterPage.path: (context) => const RegisterPage(),
            ConversationsPage.path: (context) => const ConversationsPage(),
            ProfilesScreen.path: (context) => const ProfilesScreen(),
            ConversationDetails.path: (context) => const ConversationDetails(),
            Addprofiles.path: (context) => const Addprofiles()
          },
        );
      }),
    );
  }
}
