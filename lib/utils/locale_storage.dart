import 'package:shared_preferences/shared_preferences.dart';

class LocaleStorage {
  static Future<void> saveLastVisitedRoute(String routeName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_route', routeName);
  }

  static Future<String> getInitialRoute() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('last_route') ?? '/';
  }
}
