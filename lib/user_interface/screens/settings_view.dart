import 'package:flutter/material.dart';
import 'package:system_mapper/data/hive_objects/system/system_front_type.dart';
import 'package:system_mapper/data/model_classes/app_box.dart';
import 'package:system_mapper/user_interface/widgets/system_front_selector.dart';
import 'package:system_mapper/user_interface/widgets/system_text_button.dart';
import 'package:system_mapper/utils/app_routes.dart';
import 'package:system_mapper/utils/current.dart';

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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Change front type',
                              style: TextTheme.of(context).bodyLarge,
                            ),
                            SizedBox(width: 30),
                            SystemFrontSelector(
                              initialType: SystemFrontType.parse(
                                Current.system?.frontTypeString ?? '',
                              ),
                              stateCallback: (SystemFrontType frontType) async {
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Center(
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: ColorScheme.of(
                                                context,
                                              ).shadow,
                                              spreadRadius: 0,
                                              blurRadius: 10,
                                              offset: Offset(15, 15),
                                            ),
                                          ],
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(38),
                                          ),
                                          color: ColorScheme.of(
                                            context,
                                          ).primaryContainer,
                                        ),
                                        width: 600,
                                        height: 400,
                                        padding: EdgeInsets.all(24),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              'Your current entries will be terminated and archived!',
                                              style: TextTheme.of(
                                                context,
                                              ).displayLarge,
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(
                                              width: 300,
                                              child: SystemTextButton(
                                                text: 'Okay...',
                                                onPressed: () async {
                                                  Current
                                                          .system
                                                          ?.frontTypeString =
                                                      frontType.toString();
                                                  await Current.system?.save();
                                                  Current.system?.membersList?.forEach((
                                                    member,
                                                  ) async {
                                                    await member
                                                        .removeFromSingleFront();
                                                    await member
                                                        .removeFromStandardFront();
                                                  });
                                                  if (context.mounted &&
                                                      Navigator.canPop(
                                                        context,
                                                      )) {
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                fontSize: ButtonFontSize.large,
                                                isExpanded: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),

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
            WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
              Navigator.of(context).pushReplacementNamed(AppRoutes.home);
            });
          },
        ),
      ),
    );
  }
}
