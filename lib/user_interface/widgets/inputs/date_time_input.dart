import 'package:flutter/material.dart';
import 'package:system_mapper/main.dart';
import 'package:system_mapper/user_interface/widgets/cards/date_time_card.dart';
import 'package:system_mapper/user_interface/widgets/system_text_button.dart';

class DateTimeInput extends StatelessWidget {
  final VoidCallback selector;
  final DateTime? displayTime;
  final String label;
  const DateTimeInput({
    super.key,
    required this.selector,
    required this.label,
    this.displayTime,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      if (!kIsMobile) SizedBox(),
      DateTimeCard(dateTime: displayTime),
      SizedBox(width: 10),
      SystemTextButton(text: 'Select', onPressed: selector),
      if (!kIsMobile) SizedBox(),
    ];
    return SizedBox(
      child: Column(
        children: [
          Text(label, style: TextTheme.of(context).labelLarge),
          Divider(thickness: 2, indent: 24, endIndent: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: children,
          ),
        ],
      ),
    );
  }
}
