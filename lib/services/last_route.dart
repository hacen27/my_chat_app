import 'package:flutter/material.dart';

class LastRoute extends RouteObserver<PageRoute<dynamic>> {
  LastRoute._privateConstructor();
  static final LastRoute _instance = LastRoute._privateConstructor();
  factory LastRoute() => _instance;

  String lastPath = '/';

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name != null) {
      updateLastPath(route.settings.name!);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute?.settings.name != null) {
      updateLastPath(newRoute!.settings.name!);
    }
  }

  void updateLastPath(String path) {
    lastPath = path;
  }
}
