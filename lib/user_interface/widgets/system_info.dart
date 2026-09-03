import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:system_mapper/user_interface/screens/welcome_view.dart';
import 'package:system_mapper/user_interface/widgets/cards/member_count.dart';
import 'package:system_mapper/user_interface/widgets/text_with_blank.dart';
import 'package:system_mapper/utils/current.dart';

class SystemInformation extends StatefulWidget {
  final bool isBlank;
  const SystemInformation({super.key, this.isBlank = false});

  @override
  State<SystemInformation> createState() => _SystemInformationState();
}

class _SystemInformationState extends State<SystemInformation> {
  TiltController controller = TiltController();

  @override
  void initState() {
    Timer.periodic(
      Duration(
        milliseconds: (1000 / (Current.cursor?.refreshRate ?? 1000)).toInt(),
      ),
      (timer) {
        if (mounted) {
          // debugPrint(
          //   (((Current.cursor?.cursorX ?? 0) -
          //               ((View.of(context).physicalSize.width / 3) * 3)) *
          //           -1)
          //       .toString(),
          // );
          // debugPrint(
          //   (((Current.cursor?.cursorY ?? 0) -
          //               ((View.of(context).physicalSize.height / 2) * 1)) *
          //           -1)
          //       .toString(),
          // );
          // controller.move(
          //   position: Offset(
          //     ((Current.cursor?.cursorX ?? 0) -
          //             ((View.of(context).physicalSize.width / 4) * 3)) *
          //         1,
          //     ((Current.cursor?.cursorY ?? 0) -
          //             ((View.of(context).physicalSize.height / 4) * 1)) *
          //         1,
          //   ),
          // );
        } else {
          timer.cancel();
        }
      },
    );
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      if (!widget.isBlank) {
        // controller.move(position: _stylizedOffset);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Tilt(
      tiltController: controller,
      tiltConfig: TiltConfig(angle: 5, perspectiveIntensity: 0.001),
      child: Center(
        child: ValueListenableBuilder(
          valueListenable: Current.settingsListenable,
          builder: (context, value, child) {
            return ValueListenableBuilder(
              valueListenable: Current.systemListenable,
              builder: (context, value, child) {
                if (Current.system == null) {
                  WidgetsFlutterBinding.ensureInitialized()
                      .addPostFrameCallback((_) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return WelcomeView();
                          },
                        );
                      });
                }
                return TiltBaseContainer(
                  lightConfig: LightConfig(
                    spreadFactor: 3,
                    direction: LightDirection.topRight,
                    maxIntensity: 0.1,
                  ),
                  shadowConfig: ShadowBaseConfig(
                    spreadFactor: 0.0,
                    offsetFactor: 0.01,
                    offsetInitial: Offset(10, -10),
                    minIntensity: 0.25,
                    direction: ShadowDirection.topRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  child: ValueListenableBuilder(
                    valueListenable: Current.cursorListenable,
                    builder: (context, value, child) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            constraints: BoxConstraints(maxWidth: 500),
                            decoration: BoxDecoration(
                              boxShadow: [],
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                              color: ColorScheme.of(context).primary,
                              // ThemeMode.system.parse(Current.settings!.themeMode!).isDark
                              // ? ColorScheme.of(context).primary
                              // : ColorScheme.of(context).primaryContainer,
                            ),
                            padding: EdgeInsets.all(32),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TextWithBlank(
                                      text: Current.system?.systemName ?? '',
                                      style: TextTheme.of(context).displayLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight(200),
                                          ),
                                      isBlank: widget.isBlank,
                                      blankColor: ColorScheme.of(
                                        context,
                                      ).primaryFixed,
                                      shimmerColorOpacity: 0.6,
                                    ),
                                    MemberCount(
                                      type: MemberCountType.totalCount,
                                      isBlank: widget.isBlank,
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 2,
                                  color: ColorScheme.of(context).tertiary,
                                ),
                                Row(
                                  children: [
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: 500,
                                      ),
                                      child: TextWithBlank(
                                        text: Current.system?.systemBio ?? '',
                                        style: TextTheme.of(context).bodyMedium,
                                        isBlank: widget.isBlank,
                                        blankColor: ColorScheme.of(
                                          context,
                                        ).primaryFixed,
                                        shimmerColorOpacity: 0.6,
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
              },
            );
          },
        ),
      ),
    );
  }
}
