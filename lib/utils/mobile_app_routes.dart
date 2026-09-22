import 'package:flutter/material.dart';
import 'package:system_mapper/user_interface/mobile_app.dart';

class Routes {
  static String home = '/';

  static Map<String, WidgetBuilder> routes(BuildContext context) {
    return {Routes.home: (context) => const MobileAppHome()};
  }

  /// This function protects a route by redirecting to the /login screen if the
  /// user is not logged in.
  // static Widget protected(BuildContext context, Widget screen) {
  //   debugPrint('Current username: ${Current.user?.codename}');
  //   return (Current.user == null) ? const AuthGate() : screen;
  // }
}
