import 'package:flutter/material.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:system_mapper/data/hive_objects/feelings/feeling.dart';
import 'package:system_mapper/user_interface/widgets/cards/selected_feeling_card.dart';
import 'package:system_mapper/utils/current.dart';
import 'package:system_mapper/utils/misc_classes/feelings_info.dart';
import 'package:system_mapper/utils/safe_set_state.dart';
import 'package:system_mapper/user_interface/widgets/inputs/sub_inputs/feelings_selector_button.dart';

void defaultCallback(FeelingsInfo info) {}

class FeelingsSelector extends StatefulWidget {
  final String feelingString;
  final Widget child;
  final void Function(FeelingsInfo info) callback;
  const FeelingsSelector({
    super.key,
    this.feelingString = 'How do you feel?',
    this.child = const Icon(Icons.emoji_emotions_sharp),
    this.callback = defaultCallback,
  });

  @override
  State<FeelingsSelector> createState() => _FeelingsSelectorState();
}

class _FeelingsSelectorState extends SafeState<FeelingsSelector> {
  final PieMenuController firstOrderController = PieMenuController();
  final PieMenuController secondOrderController = PieMenuController();
  final PieMenuController thirdOrderController = PieMenuController();
  final EdgeInsets padding = EdgeInsets.only(
    top: 112.5,
    bottom: 112.5,
    left: 100,
    right: 100,
  );

  double get textOffset => 120;

  bool get shouldShowFirst => firstOrderSelection.isNotEmpty;
  bool get shouldShowSecond => secondOrderSelection.isNotEmpty;
  bool get shouldShowThird => thirdOrderSelection.isNotEmpty;

  String firstOrderSelection = '';
  String secondOrderSelection = '';
  String thirdOrderSelection = '';
  String firstOrderEmoji = '';
  String secondOrderEmoji = '';
  String thirdOrderEmoji = '';

  void resetState() {
    safeSetState(() {
      firstOrderSelection = '';
      secondOrderSelection = '';
      thirdOrderSelection = '';
      firstOrderEmoji = '';
      secondOrderEmoji = '';
      thirdOrderEmoji = '';
    });
    widget.callback(
      FeelingsInfo(
        firstOrderSelection: firstOrderSelection,
        secondOrderSelection: secondOrderSelection,
        thirdOrderSelection: thirdOrderSelection,
      ),
    );
    Future.delayed(Duration(milliseconds: 500), () {
      firstOrderController.openMenu();
    });
  }

  void setThirdOrder(Feeling feeling) async {
    debugPrint(feeling.feelingName ?? '');
    safeSetState(() {
      thirdOrderSelection = feeling.feelingName ?? '';
      thirdOrderEmoji = feeling.emojiCode ?? '';
    });
    widget.callback(
      FeelingsInfo(
        firstOrderSelection: firstOrderSelection,
        secondOrderSelection: secondOrderSelection,
        thirdOrderSelection: thirdOrderSelection,
      ),
    );
  }

  void setSecondOrder(Feeling feeling) async {
    debugPrint(feeling.feelingName ?? '');
    safeSetState(() {
      secondOrderSelection = feeling.feelingName ?? '';
      secondOrderEmoji = feeling.emojiCode ?? '';
    });
    widget.callback(
      FeelingsInfo(
        firstOrderSelection: firstOrderSelection,
        secondOrderSelection: secondOrderSelection,
        thirdOrderSelection: thirdOrderSelection,
      ),
    );
    Future.delayed(Duration(milliseconds: 500), () {
      thirdOrderController.openMenu();
    });
  }

  void setFirstOrder(Feeling feeling) async {
    debugPrint(feeling.feelingName ?? '');
    safeSetState(() {
      firstOrderSelection = feeling.feelingName ?? '';
      firstOrderEmoji = feeling.emojiCode ?? '';
    });
    widget.callback(
      FeelingsInfo(
        firstOrderSelection: firstOrderSelection,
        secondOrderSelection: secondOrderSelection,
        thirdOrderSelection: thirdOrderSelection,
      ),
    );
    Future.delayed(Duration(milliseconds: 500), () {
      secondOrderController.openMenu();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 600,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 600,
            height: 75,
            alignment: Alignment.center,
            child: Text(
              widget.feelingString,
              style: TextTheme.of(context).displaySmall,
            ),
          ),
          Container(
            width: 600,
            height: 325,
            decoration: BoxDecoration(
              color: ColorScheme.of(context).primary,
              // borderRadius: BorderRadius.all(Radius.circular(200)),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 10,
                  child: SelectedFeelingCard(
                    shouldShowFirst: shouldShowFirst,
                    shouldShowSecond: shouldShowSecond,
                    shouldShowThird: shouldShowThird,
                    firstOrderEmoji: firstOrderEmoji,
                    firstOrderSelection: firstOrderSelection,
                    secondOrderEmoji: secondOrderEmoji,
                    secondOrderSelection: secondOrderSelection,
                    thirdOrderEmoji: thirdOrderEmoji,
                    thirdOrderSelection: thirdOrderSelection,
                  ),
                ),
                Container(
                  width: 600,
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: PieCanvas(
                      theme: PieTheme(
                        tooltipPadding: EdgeInsets.only(top: 24),
                        tooltipCanvasAlignment: Alignment.topCenter,
                        overlayColor: Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            transform: Matrix4.translationValues(0, 10, 0),
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                Padding(
                                  padding: padding,
                                  child: PieMenu(
                                    controller: firstOrderController,
                                    actions: [
                                      ...Current.feelings?.firstOrderFeelings?.map((
                                            feeling,
                                          ) {
                                            return FeelingsSelectorButton.feelingsSelectorButtonMobile(
                                              feeling,
                                              textOffset,
                                              setFirstOrder,
                                            );
                                          }) ??
                                          [],
                                    ],
                                    onPressed: () =>
                                        firstOrderController.openMenu(),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                        color: ColorScheme.of(
                                          context,
                                        ).onPrimary,
                                      ),
                                      height: 100,
                                      width: 100,
                                      child: widget.child,
                                    ),
                                  ),
                                ),
                                if (firstOrderSelection != '')
                                  Padding(
                                    padding: padding,
                                    child: PieMenu(
                                      controller: secondOrderController,
                                      actions: [
                                        ...Current.feelings?.secondOrderFeelings
                                                ?.where(
                                                  (feeling) =>
                                                      feeling
                                                          .feelingParentName ==
                                                      firstOrderSelection,
                                                )
                                                .map((feeling) {
                                                  return FeelingsSelectorButton.feelingsSelectorButtonMobile(
                                                    feeling,
                                                    textOffset,
                                                    setSecondOrder,
                                                  );
                                                }) ??
                                            [],
                                      ],
                                      onPressed: () =>
                                          secondOrderController.openMenu(),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(50),
                                          ),
                                          color: ColorScheme.of(
                                            context,
                                          ).onPrimary,
                                        ),
                                        height: 100,
                                        width: 100,
                                        child: widget.child,
                                      ),
                                    ),
                                  ),
                                if (secondOrderSelection != '')
                                  Padding(
                                    padding: padding,
                                    child: PieMenu(
                                      controller: thirdOrderController,
                                      actions: [
                                        ...Current.feelings?.thirdOrderFeelings
                                                ?.where(
                                                  (feeling) =>
                                                      feeling
                                                          .feelingParentName ==
                                                      secondOrderSelection,
                                                )
                                                .map((feeling) {
                                                  return FeelingsSelectorButton.feelingsSelectorButtonMobile(
                                                    feeling,
                                                    textOffset,
                                                    setThirdOrder,
                                                  );
                                                }) ??
                                            [],
                                      ],
                                      onPressed: () =>
                                          thirdOrderController.openMenu(),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(50),
                                          ),
                                          color: ColorScheme.of(
                                            context,
                                          ).onPrimary,
                                        ),
                                        height: 100,
                                        width: 100,
                                        child: widget.child,
                                      ),
                                    ),
                                  ),
                                Positioned(
                                  top: 142.5,
                                  left: 50,
                                  bottom: 142.5,
                                  child: IconButton(
                                    onPressed: resetState,
                                    icon: Icon(
                                      Icons.restart_alt_rounded,
                                      color: ColorScheme.of(
                                        context,
                                      ).primaryContainer,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
