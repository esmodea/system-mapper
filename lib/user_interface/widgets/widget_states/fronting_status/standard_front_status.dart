import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/hive_objects/system/member.dart';
import 'package:system_mapper/data/hive_objects/system/system.dart';
import 'package:system_mapper/main.dart';
import 'package:system_mapper/user_interface/widgets/cards/fronting_card.dart';
import 'package:system_mapper/user_interface/widgets/cards/member_count.dart';
import 'package:system_mapper/user_interface/widgets/debug/standard_fronting_status_debug.dart';
import 'package:system_mapper/user_interface/widgets/forms/begin_front_form.dart';
import 'package:system_mapper/user_interface/widgets/forms/fronting_form.dart';
import 'package:system_mapper/user_interface/widgets/text_with_blank.dart';
import 'package:system_mapper/utils/current.dart';

class StandardFrontStatus extends StatelessWidget {
  final bool isBlank;
  final Box<System> systemBox;
  const StandardFrontStatus({
    super.key,
    this.isBlank = false,
    required this.systemBox,
  });
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Current.standardFrontListenable,
      builder: (context, value, child) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: 24,
                top: kIsMobile ? 24 : 48,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWithBlank(
                        text: 'Type',
                        style: TextTheme.of(context).headlineLarge,
                        isBlank: isBlank,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!isBlank) Icon(Current.system?.frontType.icon),
                          SizedBox(width: 8),
                          TextWithBlank(
                            text:
                                Current.system?.frontType.label.toString() ??
                                '',
                            style: TextTheme.of(context).bodyMedium,
                            isBlank: isBlank,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWithBlank(
                        text: 'Fronters',
                        style: TextTheme.of(context).headlineLarge,
                        isBlank: isBlank,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MemberCount(
                            type: MemberCountType.frontCount,
                            backgroundColor: ColorScheme.of(
                              context,
                            ).primaryContainer,
                            isBlank: isBlank,
                          ),
                          SizedBox(width: 10),
                          FloatingActionButton(
                            key: Key('standard-front-widget'),
                            onPressed: () {
                              WidgetsFlutterBinding.ensureInitialized()
                                  .addPostFrameCallback((_) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(child: BeginFrontForm());
                                      },
                                    );
                                  });
                            },
                            child: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (!isBlank)
                    ...Current.standardFront?.activeFrontEntries
                            ?.map(
                              (entry) => FrontingCard(
                                entry: entry,
                                system: Current.system ?? System(),
                              ),
                            )
                            .toList() ??
                        [],
                ],
              ),
            ),
            if (kDebugMode) StandardFrontingStatusDebug(),
          ],
        );
      },
    );
  }
}
