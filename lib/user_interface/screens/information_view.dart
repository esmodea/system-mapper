import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:system_mapper/user_interface/widgets/debug/feelings_debug_list.dart';
import 'package:system_mapper/user_interface/widgets/fronting_status.dart';
import 'package:system_mapper/user_interface/widgets/inputs/feelings_wheel.dart';
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
                  return Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: (constraints.maxWidth / 10) * 6,
                          maxHeight: (constraints.maxHeight),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 24, left: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SystemInformation(box: systemBox),
                              SizedBox(height: 24),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: (constraints.maxWidth / 10) * 6,
                                  maxHeight: (constraints.maxHeight - 228),
                                ),
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SystemMembers(box: systemBox),
                                        SizedBox(height: 16),
                                        // if (kDebugMode)
                                        //   FeelingsSelector(
                                        //     feelingString:
                                        //         'How did the alter feel at the end?',
                                        //   ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Placeholder(),
                              // Placeholder(),
                              // Placeholder(),
                            ],
                          ),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: ((constraints.maxWidth / 10) * 4) - 20,
                          maxHeight: (constraints.maxHeight),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Opacity(
                                opacity: 0,
                                child: SystemInformation(
                                  isBlank: true,
                                  box: systemBox,
                                ),
                              ),
                              // SizedBox(height: 24),
                              FrontingStatus(systemBox: systemBox),
                              if (kDebugMode) FeelingsDebugList(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              );
            } else {
              return LayoutBuilder(
                builder: ((context, constraints) {
                  return Wrap(
                    spacing: 20,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: (constraints.maxWidth / 10) * 6,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 24,
                            left: 24,
                            right: 24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SystemInformation(isBlank: true, box: systemBox),
                              SizedBox(height: 40),
                              SingleChildScrollView(
                                child: SystemMembers(
                                  isBlank: true,
                                  box: systemBox,
                                ),
                              ),
                              // Placeholder(),
                              // Placeholder(),
                              // Placeholder(),
                            ],
                          ),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: ((constraints.maxWidth / 10) * 4) - 20,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Opacity(
                                opacity: 0,
                                child: SystemInformation(
                                  isBlank: true,
                                  box: systemBox,
                                ),
                              ),
                              SizedBox(height: 40),
                              FrontingStatus(
                                isBlank: true,
                                systemBox: systemBox,
                              ),
                              // FrontingStatusDebug(),
                            ],
                          ),
                        ),
                      ),
                    ],
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
