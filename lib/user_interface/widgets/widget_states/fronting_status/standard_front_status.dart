import 'package:flutter/material.dart';
import 'package:system_mapper/user_interface/widgets/cards/standard/member_card.dart';
import 'package:system_mapper/user_interface/widgets/cards/member_count.dart';
import 'package:system_mapper/user_interface/widgets/text_with_blank.dart';
import 'package:system_mapper/utils/current.dart';

class StandardFrontStatus extends StatefulWidget {
  final bool isBlank;
  const StandardFrontStatus({super.key, this.isBlank = false});

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
                      TextWithBlank(
                        text: Current.system?.frontType.toString() ?? '',
                        style: TextTheme.of(context).headlineLarge,
                        isBlank: widget.isBlank,
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
                      MemberCount(
                        type: MemberCountType.frontCount,
                        backgroundColor: ColorScheme.of(
                          context,
                        ).primaryContainer,
                        isBlank: widget.isBlank,
                      ),
                    ],
                  ),
                  if (!widget.isBlank)
                    ...Current.standardFront?.membersInFront
                            ?.map(
                              (member) => MemberCard(
                                member: member,
                                hideBio: true,
                                showFrontTime: true,
                              ),
                            )
                            .toList() ??
                        [],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
