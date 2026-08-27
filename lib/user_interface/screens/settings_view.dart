import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:system_mapper/data/model_classes/app_box.dart';
import 'package:system_mapper/user_interface/widgets/system_text_button.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width - 60,
        height: MediaQuery.sizeOf(context).height - 50,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Expanded(
                  child: Container(
                    color: ColorScheme.of(context).inversePrimary,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'More coming soon...',
                                style: TextTheme.of(context).bodyLarge,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: SizedBox(
        width: 200,
        height: 50,
        child: SystemTextButton(
          text: 'Delete all data',
          onPressed: () {
            AppBox.clearAllBoxes();
          },
        ),
      ),
    );
  }
}
