import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/model_classes/app_box.dart';
import 'package:system_mapper/hive_registrar.g.dart';
import 'package:system_mapper/utils/app_routes.dart';

Future<void> main() async {
  // Sets up hive for applications
  if (!kIsWeb) await Hive.initFlutter();

  // Registers hive objects for use
  Hive.registerAdapters();

  // Opens every Hive box.
  await AppBox.openAllBoxes();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'System Mapper',
      routes: AppRoutes.routes(context),
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.redAccent)),
      initialRoute: AppRoutes.home,
    );
  }
}
