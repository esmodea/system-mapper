import 'package:flutter/material.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/user_interface/widgets/member_card.dart';
import 'package:system_mapper/user_interface/widgets/member_count.dart';
import 'package:system_mapper/utils/current.dart';

class FrontingStatus extends StatefulWidget {
  const FrontingStatus({super.key});

  @override
  State<FrontingStatus> createState() => _FrontingStatusState();
}

class _FrontingStatusState extends State<FrontingStatus> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Current.frontListenable,
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
                      Text(
                        'Current Fronters',
                        style: TextTheme.of(context).headlineLarge,
                      ),
                      MemberCount(
                        type: MemberCountType.frontCount,
                        backgroundColor: ColorScheme.of(
                          context,
                        ).primaryContainer,
                      ),
                    ],
                  ),
                  ...Current.front?.membersInFront
                          ?.map(
                            (member) =>
                                MemberCard(member: member, hideBio: true),
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
