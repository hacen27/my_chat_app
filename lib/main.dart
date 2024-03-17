import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_chat_app/app_router.dart';

import 'package:my_chat_app/pages/widgets/app_theme.dart';
import 'package:my_chat_app/pages/widgets/custom_snack_bar.dart';
import 'package:my_chat_app/providers/locale_provider.dart';
import 'package:my_chat_app/services/last_route.dart';
import 'package:my_chat_app/utils/supabase_constants.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await Supabase.initialize(
    url: SupabaseConstants.baseUrl,
    anonKey: SupabaseConstants.baseKey,
  );

  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  MyApp({
    Key? key,
    required this.appRouter,
  }) : super(key: key);
  final RouteObserver<PageRoute> routeObserver = LastRoute();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: Consumer<LocaleProvider>(builder: (context, locale, child) {
        return MaterialApp(
          scaffoldMessengerKey: scaffoldMessenger,
          debugShowCheckedModeBanner: false,
          title: 'My Chat App',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: locale.locale,
          theme: MyAppThemes.lightTheme,
          darkTheme: MyAppThemes.darkTheme,
          themeMode: ThemeMode.system,
          onGenerateRoute: AppRouter().generateRoute,
          navigatorObservers: [routeObserver],
        );
      }),
    );
  }
}

























// MaterialApp.router(
            //   routerConfig: AppRouter().router,
            //   scaffoldMessengerKey: globalKey,
            //   debugShowCheckedModeBanner: false,
            //   title: 'My Chat App',
            //   localizationsDelegates: AppLocalizations.localizationsDelegates,
            //   supportedLocales: AppLocalizations.supportedLocales,
            //   locale: locale.locale,
            //   theme: appTheme,
            //   // onGenerateRoute: AppRouter.generateRoute,
            //   // onGenerateInitialRoutes: ,
            // );