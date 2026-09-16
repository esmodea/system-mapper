import 'package:flutter/material.dart';
import 'package:system_mapper/utils/current.dart';

class FeelingsDebugList extends StatefulWidget {
  const FeelingsDebugList({super.key});

  @override
  State<FeelingsDebugList> createState() => _FeelingsDebugListState();
}

class _FeelingsDebugListState extends State<FeelingsDebugList> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Current.feelingsListenable,
      builder: (context, value, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Text('Feelings:'),
              ...Current.feelings?.firstOrderFeelings!.map((feeling) {
                    return Text(feeling.feelingName ?? '');
                  }) ??
                  [],
              Text('Second Order Feelings:'),
              ...Current.feelings?.secondOrderFeelings!.map((feeling) {
                    return Text(feeling.feelingName ?? '');
                  }) ??
                  [],
              Text('Third Order Feelings:'),
              ...Current.feelings?.thirdOrderFeelings!.map((feeling) {
                    return Text(feeling.feelingName ?? '');
                  }) ??
                  [],
            ],
          ),
        );
      },
    );
  }
}
