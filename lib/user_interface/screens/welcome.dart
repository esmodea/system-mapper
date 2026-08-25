import 'package:flutter/material.dart';
import 'package:system_mapper/user_interface/widgets/system_form.dart';
import 'package:system_mapper/user_interface/widgets/system_members.dart';
import 'package:system_mapper/user_interface/widgets/system_text_button.dart';
import 'package:system_mapper/user_interface/widgets/welcome_splash.dart';
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
    switch (stage % (totalStages + 1)) {
      case (1):
        return SystemForm(callback: updateStage);
      case (2):
        return Scaffold(
          body: Center(child: SystemMembers()),
          floatingActionButton: SystemTextButton(
            text: 'Done',
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        );
      default:
        return WelcomeSplash(callback: updateStage);
    }
  }
}
