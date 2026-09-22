import 'package:flutter/material.dart';
import 'package:system_mapper/data/hive_objects/feelings/feeling.dart';
import 'package:system_mapper/data/hive_objects/system/member.dart';
import 'package:system_mapper/main.dart';
import 'package:system_mapper/user_interface/widgets/cards/date_time_card.dart';
import 'package:system_mapper/user_interface/widgets/cards/selected_feeling_card.dart';
import 'package:system_mapper/user_interface/widgets/cards/standard/member_card.dart';
import 'package:system_mapper/user_interface/widgets/inputs/sub_inputs/mobile_feelings_selector.dart'
    as mobile;
import 'package:system_mapper/user_interface/widgets/inputs/sub_inputs/feelings_selector.dart';
import 'package:system_mapper/user_interface/widgets/modals/default_modal.dart';
import 'package:system_mapper/user_interface/widgets/system_text_button.dart';
import 'package:system_mapper/utils/misc_classes/feelings_info.dart';

class MemberInput extends StatelessWidget {
  final VoidCallback selector;
  final String label;
  final Member? displayMember;
  const MemberInput({
    super.key,
    required this.selector,
    required this.label,
    this.displayMember,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      if (!kIsMobile) SizedBox(),
      SizedBox(
        width: kIsMobile ? 190 : 400,
        child: MemberCard(
          member: displayMember,
          hideBio: true,
          showEditButton: false,
        ),
      ),
      SizedBox(width: 10),
      SystemTextButton(text: 'Select', onPressed: selector),
      if (!kIsMobile) SizedBox(),
    ];
    return Container(
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
