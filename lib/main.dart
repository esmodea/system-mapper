import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/hive_objects/settings/cursor.dart';
import 'package:system_mapper/data/hive_objects/settings/settings.dart';
import 'package:system_mapper/data/model_classes/app_box.dart';
import 'package:system_mapper/hive_registrar.g.dart';
import 'package:system_mapper/utils/app_routes.dart';
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
          return MaterialApp(
            title: 'System Mapper',
            routes: AppRoutes.routes(context),
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
            initialRoute: AppRoutes.home,
          );
        },
      ),
    );
  }
}
