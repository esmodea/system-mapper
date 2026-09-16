import 'package:flutter/material.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:system_mapper/utils/current.dart';
import 'package:system_mapper/utils/safe_set_state.dart';

void defaultCallback(FeelingsInfo info) {}

class FeelingsInfo {
  final String firstOrderSelection;
  final String secondOrderSelection;
  final String thirdOrderSelection;

  const FeelingsInfo({
    required this.firstOrderSelection,
    required this.secondOrderSelection,
    required this.thirdOrderSelection,
  });
}

class FeelingsSelector extends StatefulWidget {
  final Widget child;
  final void Function(FeelingsInfo info) callback;
  const FeelingsSelector({
    super.key,
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
  );
  final double textOffset = 120;

  bool get shouldShowFirst => firstOrderSelection.isNotEmpty;
  bool get shouldShowSecond => secondOrderSelection.isNotEmpty;
  bool get shouldShowThird => thirdOrderSelection.isNotEmpty;

  String firstOrderSelection = '';
  String secondOrderSelection = '';
  String thirdOrderSelection = '';
  String firstOrderEmoji = '';
  String secondOrderEmoji = '';
  String thirdOrderEmoji = '';

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
              'How do you feel?',
              style: TextTheme.of(context).displayMedium,
            ),
          ),
          Container(
            width: 600,
            height: 325,
            decoration: BoxDecoration(
              color: ColorScheme.of(context).secondaryContainer,
              borderRadius: BorderRadius.all(Radius.circular(200)),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 50,
                  bottom: 0,
                  child: Container(
                    alignment: Alignment.center,
                    // transform: Matrix4.translationValues(textOffset / 2, 0, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorScheme.of(context).primary,
                        borderRadius: BorderRadius.all(Radius.circular(48)),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Selected emotion'),
                          Container(
                            height: 2,
                            width: 100,
                            color: ColorScheme.of(context).onPrimary,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (shouldShowFirst &&
                                  !shouldShowSecond &&
                                  !shouldShowThird)
                                RichText(
                                  text: TextSpan(text: firstOrderEmoji),
                                  overflow: TextOverflow.ellipsis,
                                  textScaler: TextScaler.linear(1),
                                ),
                              if (shouldShowFirst &&
                                  !shouldShowSecond &&
                                  !shouldShowThird)
                                RichText(
                                  text: TextSpan(
                                    text: firstOrderSelection,
                                    style: TextTheme.of(context).displayMedium
                                        ?.copyWith(
                                          fontSize: TextTheme.of(
                                            context,
                                          ).headlineSmall?.fontSize,
                                        ),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              if (shouldShowSecond && !shouldShowThird)
                                RichText(
                                  text: TextSpan(text: secondOrderEmoji),
                                  overflow: TextOverflow.ellipsis,
                                  textScaler: TextScaler.linear(2),
                                ),
                              if (shouldShowSecond && !shouldShowThird)
                                RichText(
                                  text: TextSpan(
                                    text: secondOrderSelection,
                                    style: TextTheme.of(context).displayMedium
                                        ?.copyWith(
                                          fontSize: TextTheme.of(
                                            context,
                                          ).headlineLarge?.fontSize,
                                        ),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              if (shouldShowThird)
                                RichText(
                                  text: TextSpan(text: thirdOrderEmoji),
                                  overflow: TextOverflow.ellipsis,
                                  textScaler: TextScaler.linear(3),
                                ),
                              if (shouldShowThird)
                                RichText(
                                  text: TextSpan(
                                    text: thirdOrderSelection,
                                    style: TextTheme.of(context).displayMedium,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(200)),
                  child: PieCanvas(
                    theme: PieTheme(
                      tooltipCanvasAlignment: Alignment.centerRight,
                      // overlayColor: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
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
                                        return PieAction.builder(
                                          buttonTheme: PieButtonTheme(
                                            backgroundColor: Colors.transparent,
                                            iconColor: Colors.transparent,
                                          ),
                                          buttonThemeHovered: PieButtonTheme(
                                            backgroundColor: Colors.transparent,
                                            iconColor: Colors.transparent,
                                          ),
                                          tooltip: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(width: textOffset),
                                              Text(feeling.feelingName ?? ''),
                                            ],
                                          ),
                                          onSelect: () async {
                                            debugPrint(
                                              feeling.feelingName ?? '',
                                            );
                                            safeSetState(() {
                                              firstOrderSelection =
                                                  feeling.feelingName ?? '';
                                              firstOrderEmoji =
                                                  feeling.emojiCode ?? '';
                                            });
                                            widget.callback(
                                              FeelingsInfo(
                                                firstOrderSelection:
                                                    firstOrderSelection,
                                                secondOrderSelection:
                                                    secondOrderSelection,
                                                thirdOrderSelection:
                                                    thirdOrderSelection,
                                              ),
                                            );
                                            Future.delayed(
                                              Duration(milliseconds: 500),
                                              () {
                                                secondOrderController
                                                    .openMenu();
                                              },
                                            );
                                          },
                                          builder: (hovered) {
                                            return SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: Center(
                                                child: RichText(
                                                  text: TextSpan(
                                                    text:
                                                        feeling.emojiCode ??
                                                        feeling.feelingName ??
                                                        '',
                                                  ),
                                                  textScaler: TextScaler.linear(
                                                    3,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            );
                                          },
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
                                    color: ColorScheme.of(context).onPrimary,
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
                                                  feeling.feelingParentName ==
                                                  firstOrderSelection,
                                            )
                                            .map((feeling) {
                                              return PieAction.builder(
                                                buttonTheme: PieButtonTheme(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  iconColor: Colors.transparent,
                                                ),
                                                buttonThemeHovered:
                                                    PieButtonTheme(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      iconColor:
                                                          Colors.transparent,
                                                    ),
                                                tooltip: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: textOffset),
                                                    Text(
                                                      feeling.feelingName ?? '',
                                                    ),
                                                  ],
                                                ),
                                                onSelect: () async {
                                                  debugPrint(
                                                    feeling.feelingName ?? '',
                                                  );
                                                  safeSetState(() {
                                                    secondOrderSelection =
                                                        feeling.feelingName ??
                                                        '';
                                                    secondOrderEmoji =
                                                        feeling.emojiCode ?? '';
                                                  });
                                                  widget.callback(
                                                    FeelingsInfo(
                                                      firstOrderSelection:
                                                          firstOrderSelection,
                                                      secondOrderSelection:
                                                          secondOrderSelection,
                                                      thirdOrderSelection:
                                                          thirdOrderSelection,
                                                    ),
                                                  );
                                                  Future.delayed(
                                                    Duration(milliseconds: 500),
                                                    () {
                                                      thirdOrderController
                                                          .openMenu();
                                                    },
                                                  );
                                                },
                                                builder: (hovered) {
                                                  return SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child: Center(
                                                      child: RichText(
                                                        text: TextSpan(
                                                          text:
                                                              feeling
                                                                  .emojiCode ??
                                                              feeling
                                                                  .feelingName ??
                                                              '',
                                                        ),
                                                        textScaler:
                                                            TextScaler.linear(
                                                              3,
                                                            ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  );
                                                },
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
                                      color: ColorScheme.of(context).onPrimary,
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
                                                  feeling.feelingParentName ==
                                                  secondOrderSelection,
                                            )
                                            .map((feeling) {
                                              return PieAction.builder(
                                                buttonTheme: PieButtonTheme(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  iconColor: Colors.transparent,
                                                ),
                                                buttonThemeHovered:
                                                    PieButtonTheme(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      iconColor:
                                                          Colors.transparent,
                                                    ),
                                                tooltip: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: textOffset),
                                                    Text(
                                                      feeling.feelingName ?? '',
                                                    ),
                                                  ],
                                                ),
                                                onSelect: () async {
                                                  debugPrint(
                                                    feeling.feelingName ?? '',
                                                  );
                                                  safeSetState(() {
                                                    thirdOrderSelection =
                                                        feeling.feelingName ??
                                                        '';
                                                    thirdOrderEmoji =
                                                        feeling.emojiCode ?? '';
                                                  });
                                                  widget.callback(
                                                    FeelingsInfo(
                                                      firstOrderSelection:
                                                          firstOrderSelection,
                                                      secondOrderSelection:
                                                          secondOrderSelection,
                                                      thirdOrderSelection:
                                                          thirdOrderSelection,
                                                    ),
                                                  );
                                                },
                                                builder: (hovered) {
                                                  return SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child: Center(
                                                      child: RichText(
                                                        text: TextSpan(
                                                          text:
                                                              feeling
                                                                  .emojiCode ??
                                                              feeling
                                                                  .feelingName ??
                                                              '',
                                                        ),
                                                        textScaler:
                                                            TextScaler.linear(
                                                              3,
                                                            ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  );
                                                },
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
                                      color: ColorScheme.of(context).onPrimary,
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
                                onPressed: () {
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
                                      secondOrderSelection:
                                          secondOrderSelection,
                                      thirdOrderSelection: thirdOrderSelection,
                                    ),
                                  );
                                  Future.delayed(
                                    Duration(milliseconds: 500),
                                    () {
                                      firstOrderController.openMenu();
                                    },
                                  );
                                },
                                icon: Icon(Icons.restart_alt_rounded),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 300),
                      ],
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
