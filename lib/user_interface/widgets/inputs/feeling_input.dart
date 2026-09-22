import 'package:flutter/material.dart';
import 'package:system_mapper/data/hive_objects/feelings/feeling.dart';
import 'package:system_mapper/main.dart';
import 'package:system_mapper/user_interface/widgets/cards/selected_feeling_card.dart';
import 'package:system_mapper/user_interface/widgets/inputs/sub_inputs/mobile_feelings_selector.dart'
    as mobile;
import 'package:system_mapper/user_interface/widgets/inputs/sub_inputs/feelings_selector.dart';
import 'package:system_mapper/user_interface/widgets/modals/default_modal.dart';
import 'package:system_mapper/user_interface/widgets/system_text_button.dart';
import 'package:system_mapper/utils/misc_classes/feelings_info.dart';

class FeelingInput extends StatelessWidget {
  final void Function(Feeling? feeling) selector;
  final Feeling? displayFeeling;
  final String label;
  const FeelingInput({
    super.key,
    required this.selector,
    required this.label,
    this.displayFeeling,
  });

  void selectorCallback(FeelingsInfo info) {
    Feeling? feeling =
        Feeling.getFeeling(info.thirdOrderSelection) ??
        Feeling.getFeeling(info.secondOrderSelection) ??
        Feeling.getFeeling(info.firstOrderSelection);

    debugPrint(feeling?.toString());

    selector(feeling);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      if (!kIsMobile) SizedBox(),
      SelectedFeelingCard(
        shouldShowFirst: displayFeeling != null,
        shouldShowSecond: false,
        shouldShowThird: false,
        firstOrderEmoji: displayFeeling?.emojiCode ?? '',
        firstOrderSelection: displayFeeling?.feelingName ?? '',
        secondOrderEmoji: displayFeeling?.emojiCode ?? '',
        secondOrderSelection: displayFeeling?.feelingName ?? '',
        thirdOrderEmoji: displayFeeling?.emojiCode ?? '',
        thirdOrderSelection: displayFeeling?.feelingName ?? '',
      ),
      SizedBox(width: 10),
      SystemTextButton(
        text: 'Select',
        onPressed: () {
          DefaultModal(
            buttonText: 'Select',
            preferredSize: Size(648, 552),
            child: kIsMobile
                ? mobile.FeelingsSelector(callback: selectorCallback)
                : FeelingsSelector(callback: selectorCallback),
          ).build(context);
        },
      ),
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
