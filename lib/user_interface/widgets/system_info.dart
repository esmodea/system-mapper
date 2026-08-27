import 'package:flutter/material.dart';
import 'package:system_mapper/user_interface/screens/welcome_view.dart';
import 'package:system_mapper/user_interface/widgets/cards/member_count.dart';
import 'package:system_mapper/utils/current.dart';

class SystemInformation extends StatefulWidget {
  const SystemInformation({super.key});

  @override
  State<SystemInformation> createState() => _SystemInformationState();
}

class _SystemInformationState extends State<SystemInformation> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder(
        valueListenable: Current.systemListenable,
        builder: (context, value, child) {
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
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: 500),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: ColorScheme.of(context).tertiary,
                      spreadRadius: 40,
                      blurRadius: 50,
                      offset: Offset(0, -65),
                    ),
                    BoxShadow(
                      color: ColorScheme.of(context).surface,
                      spreadRadius: 100,
                      blurRadius: 50,
                      offset: Offset(0, -205),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          Current.system?.systemName ?? '',
                          style: TextTheme.of(context).displayLarge,
                        ),
                        MemberCount(type: MemberCountType.totalCount),
                      ],
                    ),
                    Divider(
                      thickness: 2,
                      color: ColorScheme.of(context).tertiary,
                    ),
                    Row(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 500),
                          child: Text(
                            Current.system?.systemBio ?? '',
                            style: TextTheme.of(context).bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // SystemMembers(),

            ],
          );
        },
      ),
    );
  }
}
