import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
            Text(
              'Current Fronters:',
              style: TextTheme.of(context).headlineLarge,
            ),
            ...Current.front?.membersInFront
                    ?.map((member) => Text(member.memberName ?? ''))
                    .toList() ??
                [],
          ],
        );
      },
    );
  }
}
