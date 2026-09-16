import 'package:flutter/material.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:system_mapper/utils/current.dart';
import 'package:system_mapper/utils/safe_set_state.dart';

class FeelingsSelector extends StatefulWidget {
  final Widget child;
  const FeelingsSelector({super.key, required this.child});

  @override
  State<FeelingsSelector> createState() => _FeelingsSelectorState();
}

class _FeelingsSelectorState extends SafeState<FeelingsSelector> {
  final PieMenuController firstOrderController = PieMenuController();
  final PieMenuController secondOrderController = PieMenuController();
  final PieMenuController thirdOrderController = PieMenuController();
  final EdgeInsets padding = EdgeInsets.only(top: 100, bottom: 100, left: 100);

  String firstOrderSelection = '';
  String secondOrderSelection = '';
  String thirdOrderSelection = '';

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
            height: 100,
            alignment: Alignment.center,
            child: Text(
              'Specify your emotion:',
              style: TextTheme.of(context).displayLarge,
            ),
          ),
          SizedBox(
            width: 600,
            height: 300,
            child: PieCanvas(
              theme: PieTheme(
                tooltipCanvasAlignment: Alignment.centerRight,
                overlayColor: Colors.transparent,
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
                                    tooltip: Text(feeling.feelingName ?? ''),
                                    onSelect: () async {
                                      debugPrint(feeling.feelingName ?? '');
                                      safeSetState(() {
                                        firstOrderSelection =
                                            feeling.feelingName ?? '';
                                      });
                                      Future.delayed(
                                        Duration(milliseconds: 500),
                                        () {
                                          secondOrderController.openMenu();
                                        },
                                      );
                                    },
                                    builder: (hovered) {
                                      return SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: Text(
                                          feeling.feelingName ?? '',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                    },
                                  );
                                }) ??
                                [],
                          ],
                          onPressed: () => firstOrderController.openMenu(),
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
                                          tooltip: Text(
                                            feeling.feelingName ?? '',
                                          ),
                                          onSelect: () async {
                                            debugPrint(
                                              feeling.feelingName ?? '',
                                            );
                                            safeSetState(() {
                                              secondOrderSelection =
                                                  feeling.feelingName ?? '';
                                            });
                                            Future.delayed(
                                              Duration(milliseconds: 500),
                                              () {
                                                thirdOrderController.openMenu();
                                              },
                                            );
                                          },
                                          builder: (hovered) {
                                            return SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: Text(
                                                feeling.feelingName ?? '',
                                              ),
                                            );
                                          },
                                        );
                                      }) ??
                                  [],
                            ],
                            onPressed: () => secondOrderController.openMenu(),
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
                                          tooltip: Text(
                                            feeling.feelingName ?? '',
                                          ),
                                          onSelect: () async {
                                            debugPrint(
                                              feeling.feelingName ?? '',
                                            );
                                            safeSetState(() {
                                              thirdOrderSelection =
                                                  feeling.feelingName ?? '';
                                            });
                                          },
                                          builder: (hovered) {
                                            return SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: Text(
                                                feeling.feelingName ?? '',
                                              ),
                                            );
                                          },
                                        );
                                      }) ??
                                  [],
                            ],
                            onPressed: () => thirdOrderController.openMenu(),
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
                    ],
                  ),
                  SizedBox(width: 300),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
