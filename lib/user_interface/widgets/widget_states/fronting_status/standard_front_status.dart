import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/hive_objects/system/member.dart';
import 'package:system_mapper/data/hive_objects/system/system.dart';
import 'package:system_mapper/user_interface/widgets/cards/fronting_card.dart';
import 'package:system_mapper/user_interface/widgets/cards/member_count.dart';
import 'package:system_mapper/user_interface/widgets/debug/standard_fronting_status_debug.dart';
import 'package:system_mapper/user_interface/widgets/forms/fronting_form.dart';
import 'package:system_mapper/user_interface/widgets/text_with_blank.dart';
import 'package:system_mapper/utils/current.dart';

class StandardFrontStatus extends StatefulWidget {
  final bool isBlank;
  final Box<System> systemBox;
  const StandardFrontStatus({
    super.key,
    this.isBlank = false,
    required this.systemBox,
  });

  @override
  State<StandardFrontStatus> createState() => _StandardFrontStatusState();
}

class _StandardFrontStatusState extends State<StandardFrontStatus> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Current.standardFrontListenable,
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
                        isBlank: widget.isBlank,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!widget.isBlank)
                            Icon(Current.system?.frontType.icon),
                          SizedBox(width: 8),
                          TextWithBlank(
                            text:
                                Current.system?.frontType.label.toString() ??
                                '',
                            style: TextTheme.of(context).bodyMedium,
                            isBlank: widget.isBlank,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWithBlank(
                        text: 'Current Fronters',
                        style: TextTheme.of(context).headlineLarge,
                        isBlank: widget.isBlank,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MemberCount(
                            type: MemberCountType.frontCount,
                            backgroundColor: ColorScheme.of(
                              context,
                            ).primaryContainer,
                            isBlank: widget.isBlank,
                          ),
                          SizedBox(width: 10),
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
                                                  widget
                                                      .systemBox
                                                      .values
                                                      .isNotEmpty
                                                  ? widget
                                                        .systemBox
                                                        .values
                                                        .first
                                                  : Current.system ?? System(),
                                              type: FrontingFormType.addToFront,
                                              initialFormData: FrontingFormData(
                                                startTime: DateTime.now(),
                                                member: Member(
                                                  memberName: 'None',
                                                ),
                                                isOnlyConscious: false,
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
                  if (!widget.isBlank)
                    ...Current.standardFront?.activeFrontEntries
                            ?.map((entry) => FrontingCard(entry: entry))
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
