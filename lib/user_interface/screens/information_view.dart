import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:system_mapper/user_interface/widgets/debug/feelings_debug_list.dart';
import 'package:system_mapper/user_interface/widgets/debug/single_fronting_status_debug.dart';
import 'package:system_mapper/user_interface/widgets/debug/standard_fronting_status_debug.dart';
import 'package:system_mapper/user_interface/widgets/fronting_status.dart';
import 'package:system_mapper/user_interface/widgets/inputs/feelings_wheel.dart';
import 'package:system_mapper/user_interface/widgets/system_info.dart';
import 'package:system_mapper/user_interface/widgets/system_members.dart';
import 'package:system_mapper/utils/current.dart';

class InformationView extends StatelessWidget {
  const InformationView({super.key});

  @override
  Widget build(BuildContext context) {
    Current.system?.membersList?.map((member) async {
      await member.removeFromSingleFront();
      return member;
    });
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 1)),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState.name == 'done') {
          return LayoutBuilder(
            builder: ((context, constraints) {
              return Wrap(
                spacing: 20,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: (constraints.maxWidth / 10) * 6,
                      maxHeight: (constraints.maxHeight),
                    ),
                    child: SingleChildScrollView(
                      controller: ScrollController(),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            SystemMembers(),
                            FeelingsSelector(),
                            // Placeholder(),
                            // Placeholder(),
                            // Placeholder(),
                          ],
                        ),
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
                          SizedBox(height: 40),
                          SystemInformation(),
                          SizedBox(height: 40),
                          FrontingStatus(),
                          if (kDebugMode) StandardFrontingStatusDebug(),
                          if (kDebugMode) SingleFrontingStatusDebug(),
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
                      padding: const EdgeInsets.all(24.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SystemMembers(isBlank: true),
                            // Placeholder(),
                            // Placeholder(),
                            // Placeholder(),
                          ],
                        ),
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
                          SizedBox(height: 40),
                          SystemInformation(isBlank: true),
                          SizedBox(height: 40),
                          FrontingStatus(isBlank: true),
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
  }
}
