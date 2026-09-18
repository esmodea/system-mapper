import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/hive_objects/system/member.dart';
import 'package:system_mapper/data/hive_objects/system/system.dart';
import 'package:system_mapper/user_interface/widgets/cards/fronting_card.dart';
// import 'package:system_mapper/user_interface/widgets/cards/member_card.dart';
import 'package:system_mapper/user_interface/widgets/cards/member_count.dart';
import 'package:system_mapper/user_interface/widgets/debug/single_fronting_status_debug.dart';
import 'package:system_mapper/user_interface/widgets/forms/fronting_form.dart';
import 'package:system_mapper/user_interface/widgets/text_with_blank.dart';
import 'package:system_mapper/utils/current.dart';

class SingleFrontStatus extends StatelessWidget {
  final bool isBlank;
  final Box<System> systemBox;
  const SingleFrontStatus({
    super.key,
    this.isBlank = false,
    required this.systemBox,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Current.singleFrontListenable,
      builder: (context, value, child) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(48),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWithBlank(
                        text: 'Front type',
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
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWithBlank(
                        text: 'Current Fronter',
                        style: TextTheme.of(context).headlineLarge,
                        isBlank: isBlank,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FloatingActionButton(
                            key: Key('standard-front-widget'),
                            onPressed: () {
                              WidgetsFlutterBinding.ensureInitialized()
                                  .addPostFrameCallback((_) {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      constraints: BoxConstraints(
                                        maxHeight:
                                            (MediaQuery.heightOf(context) / 6) *
                                            5,
                                      ),
                                      builder: (context) {
                                        return Column(
                                          children: [
                                            FrontingForm(
                                              system:
                                                  Current.system ?? System(),
                                              type: FrontingFormType.addToFront,
                                              initialFormData: FrontingFormData(
                                                startTime: DateTime.now(),
                                                member: Member(
                                                  memberName: 'None',
                                                ),
                                                isOnlyConscious:
                                                    Current
                                                        .singleFront
                                                        ?.activeFrontEntries
                                                        ?.isNotEmpty ??
                                                    false,
                                              ),
                                            ),
                                          ],
                                        );
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
                  SizedBox(height: 20),
                  if (!isBlank)
                    ...Current.singleFront?.activeFrontEntries
                            ?.map(
                              (entry) => FrontingCard(
                                entry: entry,
                                system: Current.system ?? System(),
                              ),
                            )
                            .toList() ??
                        [],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWithBlank(
                        text: 'Currently Conscious',
                        style: TextTheme.of(context).headlineLarge,
                        isBlank: isBlank,
                      ),
                      MemberCount(
                        type: MemberCountType.consciousSingleFrontCount,
                        backgroundColor: ColorScheme.of(
                          context,
                        ).primaryContainer,
                        isBlank: isBlank,
                      ),
                    ],
                  ),
                  if (!isBlank)
                    ...Current.singleFront?.activeConsciousnessEntries
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
            if (kDebugMode) SingleFrontingStatusDebug(),
          ],
        );
      },
    );
  }
}
