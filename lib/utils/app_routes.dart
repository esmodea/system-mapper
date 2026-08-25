import 'package:flutter/material.dart';
import 'package:system_mapper/user_interface/app.dart';

class AppRoutes {
  static String home = '/';
  static String createSystem = '/create-system';

  static Map<String, WidgetBuilder> routes(BuildContext context) {
    return {AppRoutes.home: (context) => const AppHome()};
  }

  /// This function protects a route by redirecting to the /login screen if the
  /// user is not logged in.
  // static Widget protected(BuildContext context, Widget screen) {
  //   debugPrint('Current Parent username: ${Current.user?.codename}');
  //   return (Current.user == null) ? const AuthGate() : screen;
  // }
}
