import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/hive_objects/feelings/feelings.dart';
import 'package:system_mapper/data/hive_objects/settings/cursor.dart';
import 'package:system_mapper/data/hive_objects/settings/settings.dart';
import 'package:system_mapper/data/model_classes/app_box.dart';
import 'package:system_mapper/hive_registrar.g.dart';
import 'package:system_mapper/utils/app_routes.dart' as desktop;
import 'package:system_mapper/utils/mobile_app_routes.dart' as mobile;
import 'package:system_mapper/utils/current.dart';

Future<void> main() async {
  // Sets up hive for applications
  if (!kIsWeb) await Hive.initFlutter();

  // Registers hive objects for use
  Hive.registerAdapters();

  // Opens every Hive box.
  await AppBox.openAllBoxes();

  // Sets theme to light mode.
  if (Current.settings?.themeMode == null) {
    Settings().setThemeMode();
  }

  // Initialize Cursor details.
  if (Current.cursor == null) {
    Cursor(cursorX: 0, cursorY: 0).updateCurrent();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.light,
  );

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugPrint(Platform.operatingSystem);
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      if (Current.cursor?.refreshRate == null) {
        Cursor(
          refreshRate: View.of(context).display.refreshRate.toInt(),
          windowWidth: View.of(context).physicalSize.width.toInt(),
          windowHeight: View.of(context).physicalSize.height.toInt(),
        ).updateCurrent();
      }
    });
    // debugPrint('${ThemeMode.system.tryParse(Current.settings?.themeMode)}');
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerMove: (details) {
        // debugPrint(details.position.dx.toString());
        // debugPrint(details.position.dy.toString());
        Current.cursor?.updateCurrentMouseLocation(details);
      },
      onPointerHover: (details) {
        // debugPrint(details.position.dx.toString());
        // debugPrint(details.position.dy.toString());
        Current.cursor?.updateCurrentMouseLocation(details);
      },
      child: ValueListenableBuilder(
        valueListenable: Current.settingsListenable,
        builder: (context, value, child) {
          // Initialize feeling propagator
          FeelingsList().updateCurrent();
          Current.feelingsPropagator.hasPropagated;
          Current.feelings?.updateCurrent();
          return MaterialApp(
            title: 'System Mapper',
            routes: kIsMobile
                ? mobile.Routes.routes(context)
                : desktop.Routes.routes(context),
            theme: ThemeData(
              brightness: Brightness.light,
              colorScheme: .fromSeed(seedColor: Colors.deepPurple),
              textTheme: Typography.blackRedwoodCity,
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              colorScheme: .fromSeed(
                brightness: Brightness.dark,
                seedColor: Colors.deepPurple,
              ),
              textTheme: Typography.whiteRedwoodCity,
              useMaterial3: true,
            ),
            themeMode: ThemeMode.system.tryParse(Current.settings?.themeMode),
            initialRoute: kIsMobile ? mobile.Routes.home : desktop.Routes.home,
          );
        },
      ),
    );
  }
}

final bool kIsMobile = switch (OS.tryParse(Platform.operatingSystem)) {
  OS.android => true,
  OS.ios => true,
  _ => false,
};

enum OS {
  android,
  ios,
  macos,
  linux,
  windows,
  fuchsia;

  const OS();

  String getInitialRoute() {
    switch (this) {
      case (android):
        return mobile.Routes.home;
      case (ios):
        return mobile.Routes.home;
      case (macos):
        return desktop.Routes.home;
      case (linux):
        return desktop.Routes.home;
      case (windows):
        return desktop.Routes.home;
      case (fuchsia):
        return desktop.Routes.home;
    }
  }

  static OS parse(String string) {
    switch (string) {
      case ('android'):
        return android;
      case ('ios'):
        return ios;
      case ('macos'):
        return macos;
      case ('linux'):
        return linux;
      case ('windows'):
        return windows;
      case ('fuchsia'):
        return fuchsia;
      default:
        throw ArgumentError.value(string);
    }
  }

  static OS? tryParse(String string) {
    switch (string) {
      case ('android'):
        return android;
      case ('ios'):
        return ios;
      case ('macos'):
        return macos;
      case ('linux'):
        return linux;
      case ('windows'):
        return windows;
      case ('fuchsia'):
        return fuchsia;
      default:
        return null;
    }
  }
}
