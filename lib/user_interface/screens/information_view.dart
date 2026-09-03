import 'package:flutter/material.dart';
import 'package:system_mapper/user_interface/widgets/debug/single_fronting_status_debug.dart';
import 'package:system_mapper/user_interface/widgets/debug/standard_fronting_status_debug.dart';
import 'package:system_mapper/user_interface/widgets/fronting_status.dart';
import 'package:system_mapper/user_interface/widgets/system_info.dart';
import 'package:system_mapper/user_interface/widgets/system_members.dart';

class InformationView extends StatelessWidget {
  const InformationView({super.key});

  @override
  Widget build(BuildContext context) {
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
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SystemMembers(),
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
                          // StandardFrontingStatusDebug(),
                          // SingleFrontingStatusDebug(),
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
