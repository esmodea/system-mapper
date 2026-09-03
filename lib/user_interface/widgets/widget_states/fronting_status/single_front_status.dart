import 'package:flutter/material.dart';
import 'package:system_mapper/user_interface/widgets/cards/single_front/member_card.dart';
import 'package:system_mapper/user_interface/widgets/cards/member_count.dart';
import 'package:system_mapper/user_interface/widgets/text_with_blank.dart';
import 'package:system_mapper/utils/current.dart';

class SingleFrontStatus extends StatefulWidget {
  final bool isBlank;
  const SingleFrontStatus({super.key, this.isBlank = false});

  @override
  State<SingleFrontStatus> createState() => _SingleFrontStatusState();
}

class _SingleFrontStatusState extends State<SingleFrontStatus> {
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
                        isBlank: widget.isBlank,
                      ),
                      TextWithBlank(
                        text: Current.system?.frontType.toString() ?? '',
                        style: TextTheme.of(context).headlineLarge,
                        isBlank: widget.isBlank,
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
                        isBlank: widget.isBlank,
                      ),
                    ],
                  ),
                  if (!widget.isBlank)
                    ...Current.singleFront?.membersInFront
                            ?.map(
                              (member) => MemberCard(
                                member: member,
                                hideBio: true,
                                showFrontTime: true,
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
                        isBlank: widget.isBlank,
                      ),
                      MemberCount(
                        type: MemberCountType.consciousSingleFrontCount,
                        backgroundColor: ColorScheme.of(
                          context,
                        ).primaryContainer,
                        isBlank: widget.isBlank,
                      ),
                    ],
                  ),
                  if (!widget.isBlank)
                    ...Current.singleFront?.membersConscious
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
