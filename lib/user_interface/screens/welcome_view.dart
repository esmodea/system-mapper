import 'package:flutter/material.dart';
import 'package:system_mapper/user_interface/widgets/forms/system_form.dart';
import 'package:system_mapper/user_interface/widgets/splash_screens/welcome_splash.dart';
import 'package:system_mapper/utils/current.dart';
import 'package:system_mapper/utils/safe_update_state.dart';

const totalStages = 2;

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  int stage = 0;

  void updateStage() {
    safeSetState(() {
      stage = stage + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Current.systemListenable,
      builder: (context, _, _) {
        if (Current.system != null) {
          WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
          });
        }
        switch (stage % (totalStages + 1)) {
          case (1):
            return SystemForm(callback: updateStage);
          default:
            return WelcomeSplash(callback: updateStage);
        }
      },
    );
  }
}
