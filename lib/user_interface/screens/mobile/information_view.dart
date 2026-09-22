import 'package:flutter/material.dart';
import 'package:system_mapper/user_interface/widgets/fronting_status.dart';
import 'package:system_mapper/user_interface/widgets/system_info.dart';
import 'package:system_mapper/user_interface/widgets/system_members.dart';
import 'package:system_mapper/utils/current.dart';

class InformationView extends StatelessWidget {
  const InformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Current.systemListenable,
      builder: (context, systemBox, child) {
        return FutureBuilder(
          future: Future.delayed(Duration(seconds: 1)),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState.name == 'done') {
              return LayoutBuilder(
                builder: ((context, constraints) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth,
                      maxHeight: constraints.maxHeight,
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 24,
                          left: 16,
                          right: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SystemInformation(box: systemBox),
                            SizedBox(height: 24),
                            SystemMembers(box: systemBox),
                            SizedBox(height: 16),
                            FrontingStatus(systemBox: systemBox),
                            // if (kDebugMode) FeelingsSelector(),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              );
            } else {
              return LayoutBuilder(
                builder: ((context, constraints) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth,
                      maxHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24, left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SystemInformation(
                                    isBlank: true,
                                    box: systemBox,
                                  ),
                                  SizedBox(height: 24),
                                  SystemMembers(isBlank: true, box: systemBox),
                                  SizedBox(height: 16),
                                  FrontingStatus(
                                    isBlank: true,
                                    systemBox: systemBox,
                                  ),
                                  // if (kDebugMode) FeelingsDebugList(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            }
          },
        );
      },
    );
  }
}
