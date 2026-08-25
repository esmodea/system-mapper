import 'package:flutter/material.dart';
import 'package:system_mapper/data/model_classes/app_box.dart';
import 'package:system_mapper/user_interface/screens/welcome.dart';
import 'package:system_mapper/user_interface/widgets/system_members.dart';
import 'package:system_mapper/user_interface/widgets/system_text_button.dart';
import 'package:system_mapper/utils/app_routes.dart';
import 'package:system_mapper/utils/current.dart';

class SystemInformationView extends StatefulWidget {
  const SystemInformationView({super.key});

  @override
  State<SystemInformationView> createState() => _SystemInformationViewState();
}

class _SystemInformationViewState extends State<SystemInformationView> {
  @override
  void initState() {
    if (Current.system == null) {
      WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) {
            return WelcomeView();
          },
        );
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder(
        valueListenable: Current.systemListenable,
        builder: (context, value, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                Current.system?.systemName ?? 'ERROR',
                style: TextTheme.of(context).displayMedium,
              ),
              Text(
                Current.system?.systemBio ?? 'ERROR',
                style: TextTheme.of(context).bodyMedium,
              ),
              Text(
                Current.system?.membersList?.length.toString() ?? 'ERROR',
                style: TextTheme.of(context).displayMedium,
              ),
              Text(
                Current.system?.systemUUID ?? 'ERROR',
                style: TextTheme.of(context).bodyMedium,
              ),
              SystemMembers(),
              SystemTextButton(
                text: 'Delete all data',
                onPressed: () {
                  AppBox.clearAllBoxes();
                  Navigator.of(context).pushNamed(AppRoutes.home);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
