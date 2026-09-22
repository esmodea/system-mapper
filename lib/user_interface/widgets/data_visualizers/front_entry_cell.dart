import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:system_mapper/data/hive_objects/front/front_entry.dart';
import 'package:system_mapper/user_interface/widgets/cards/front_history_card.dart';
import 'package:system_mapper/utils/current.dart';
import 'package:system_mapper/utils/safe_set_state.dart';

const List<double> idMatrix = [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1];

enum EntryCellType { emptyCell, leftEnd, middle, rightEnd, alone }

class FrontHistoryOverlayWrapper extends StatefulWidget {
  final OverlayPortalController controller;
  final FrontEntry entry;
  final Widget child;
  const FrontHistoryOverlayWrapper({
    super.key,
    required this.controller,
    required this.entry,
    required this.child,
  });

  @override
  State<FrontHistoryOverlayWrapper> createState() =>
      _FrontHistoryOverlayWrapperState();
}

class _FrontHistoryOverlayWrapperState
    extends SafeState<FrontHistoryOverlayWrapper> {
  bool isInBox = false;

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: widget.controller,
      overlayChildBuilder: (context) {
        return GestureDetector(
          onTap: () {
            Current.settings?.turnOffTooltip(widget.controller);
            if (isInBox) {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: FrontHistoryCard(entry: widget.entry, maxWidth: 400),
                  );
                },
              );
            }
          },
          child: Container(
            transform: Matrix4.translationValues(
              Current.cursor?.cursorX ?? 0,
              Current.cursor?.cursorY ?? 0,
              0,
            ),
            child: FrontHistoryOverlay(entry: widget.entry),
          ),
        );
      },
      overlayLocation: OverlayChildLocation.nearestOverlay,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: FrontHistoryCard(entry: widget.entry, maxWidth: 400),
              );
            },
          );
        },
        child: MouseRegion(
          onHover: (event) {
            safeSetState(() {
              isInBox = true;
            });
            Current.settings?.turnOnTooltip(widget.controller);
          },
          onExit: (event) {
            safeSetState(() {
              isInBox = false;
            });
            Current.settings?.turnOffTooltip(widget.controller);
          },
          child: widget.child,
        ),
      ),
    );
  }
}

class FrontHistoryOverlay extends StatefulWidget {
  final FrontEntry entry;
  const FrontHistoryOverlay({super.key, required this.entry});

  @override
  State<FrontHistoryOverlay> createState() => _FrontHistoryOverlayState();
}

class _FrontHistoryOverlayState extends SafeState<FrontHistoryOverlay> {
  double opacity = 0;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      safeSetState(() {
        opacity = 1;
      });
    });
    Timer.periodic(Duration(milliseconds: 100), (_) {
      SchedulerBinding.instance.scheduleForcedFrame();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 1),
      opacity: opacity,
      child: Container(
        constraints: BoxConstraints(maxWidth: 400),
        child: Text(widget.entry.member?.memberName ?? ''),
      ),
    );
  }
}

class FrontEntryCell extends StatefulWidget {
  final EntryCellType type;
  final Size size;
  final FrontEntry entry;
  final Color color;
  final int cellCount;
  // final int rowIndex;
  const FrontEntryCell({
    super.key,
    required this.type,
    required this.size,
    required this.entry,
    required this.color,
    required this.cellCount,
    // required this.rowIndex,
  });

  @override
  State<FrontEntryCell> createState() => _FrontEntryCellState();
}

class _FrontEntryCellState extends SafeState<FrontEntryCell> {
  OverlayPortalController controller = OverlayPortalController();

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case (EntryCellType.emptyCell):
        return SizedBox(width: widget.size.width, height: widget.size.height);
      case (EntryCellType.leftEnd):
        return FrontHistoryOverlayWrapper(
          controller: controller,
          entry: widget.entry,
          child: Container(
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              border: Border.symmetric(
                vertical: BorderSide(
                  color: widget.color,
                  width: 3,
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
              ),
            ),
            width: widget.size.width,
            height: widget.size.height,
            child: OverflowBox(
              alignment: Alignment.topLeft,
              maxHeight: widget.size.height,
              maxWidth: widget.size.width * widget.cellCount,
              fit: OverflowBoxFit.deferToChild,
              child: widget.cellCount > 5
                  ? SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.entry.member?.memberName ?? '',
                          overflow: TextOverflow.visible,
                          maxLines: 1,
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ),
          ),
        );
      case (EntryCellType.middle):
        return FrontHistoryOverlayWrapper(
          controller: controller,
          entry: widget.entry,
          child: Container(
            decoration: BoxDecoration(color: widget.color),
            width: widget.size.width,
            height: widget.size.height,
            transform: Matrix4.fromList(idMatrix).scaledByDouble(1.1, 1, 1, 1),
          ),
        );
      case (EntryCellType.rightEnd):
        return FrontHistoryOverlayWrapper(
          controller: controller,
          entry: widget.entry,
          child: Container(
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              border: Border.symmetric(
                vertical: BorderSide(
                  color: widget.color,
                  width: 3,
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
              ),
            ),
            width: widget.size.width,
            height: widget.size.height,
          ),
        );
      case (EntryCellType.alone):
        return FrontHistoryOverlayWrapper(
          controller: controller,
          entry: widget.entry,
          child: Container(
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.symmetric(
                vertical: BorderSide(
                  color: widget.color,
                  width: 3,
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
              ),
            ),
            width: widget.size.width,
            height: widget.size.height,
          ),
        );
    }
  }
}

enum MatrixCalculationType { minutes, hours, days }

class EntryCellInfo {
  final bool shouldDisplay;
  final bool isStart;
  final bool isEnd;
  final bool isStandAlone;
  final int cellCount;
  final FrontEntry relevantEntry;

  const EntryCellInfo({
    required this.shouldDisplay,
    required this.isStart,
    required this.isEnd,
    required this.isStandAlone,
    required this.cellCount,
    required this.relevantEntry,
  });

  Widget widget(Size cellSize) {
    if (shouldDisplay) {
      if (isStandAlone) {
        return FrontEntryCell(
          type: EntryCellType.alone,
          size: cellSize,
          entry: relevantEntry,
          cellCount: cellCount,
          color: relevantEntry.member?.avatarColor ?? Colors.transparent,
        );
      }
      if (isStart) {
        return FrontEntryCell(
          type: EntryCellType.leftEnd,
          size: cellSize,
          entry: relevantEntry,
          cellCount: cellCount,
          color: relevantEntry.member?.avatarColor ?? Colors.transparent,
        );
      } else if (isEnd) {
        return FrontEntryCell(
          type: EntryCellType.rightEnd,
          size: cellSize,
          entry: relevantEntry,
          cellCount: cellCount,
          color: relevantEntry.member?.avatarColor ?? Colors.transparent,
        );
      }
      return FrontEntryCell(
        type: EntryCellType.middle,
        size: cellSize,
        entry: relevantEntry,
        cellCount: cellCount,
        color: relevantEntry.member?.avatarColor ?? Colors.transparent,
      );
    }
    return FrontEntryCell(
      type: EntryCellType.emptyCell,
      size: cellSize,
      entry: relevantEntry,
      cellCount: cellCount,
      color: relevantEntry.member?.avatarColor ?? Colors.transparent,
    );
  }
}

class EntryCalculator {
  final List<FrontEntry> entries;
  EntryCalculator({required this.entries});

  // final List<List<Widget>> _widgetsMatrix = [];

  // List<List<Widget>> get widgetsMatrix => _widgetsMatrix;

  List<List<EntryCellInfo?>> getBinaryMatrix(MatrixCalculationType matrixType) {
    List<List<EntryCellInfo?>> returnList = [];
    List<FrontEntry> sortedEntries = _sortEntries();
    List<FrontEntry> sortedEndDateEntries = _sortEntriesByEndDate();
    DateTime matrixStartDate =
        sortedEntries.firstOrNull?.startTime ?? DateTime.now();
    DateTime matrixEndDate =
        sortedEndDateEntries.firstOrNull?.endTime ?? DateTime.now();
    int matrixLength = 0;
    List<List<EntryCellInfo?>> rudamentaryList = [];

    // debugPrint(
    //   'original first start date: ${entries.first.startTime!.toString()}',
    // );
    // debugPrint(
    //   'sorted first start date: ${sortedEntries.first.startTime!.toString()}',
    // );

    // debugPrint('original first end date: ${entries.first.endTime!.toString()}');
    // debugPrint(
    //   'sorted first end date: ${sortedEndDateEntries.first.endTime!.toString()}',
    // );

    switch (matrixType) {
      case (MatrixCalculationType.minutes):
        matrixLength = _getLength(
          matrixStartDate,
          matrixEndDate,
          Duration(minutes: 1),
        );
        rudamentaryList = _createRudamentaryMatrix(
          sortedEntries,
          matrixStartDate,
          matrixEndDate,
          Duration(minutes: 1),
        );

        returnList = _combineRows(matrixLength, rudamentaryList);

        // for (List list in returnList) {
        //   debugPrint(list.toString());
        // }

        return returnList;
      case (MatrixCalculationType.hours):
        matrixLength = _getLength(
          matrixStartDate,
          matrixEndDate,
          Duration(hours: 1),
        );
        rudamentaryList = _createRudamentaryMatrix(
          sortedEntries,
          matrixStartDate,
          matrixEndDate,
          Duration(hours: 1),
        );

        returnList = _combineRows(matrixLength, rudamentaryList);

        // for (List list in returnList) {
        //   debugPrint(list.toString());
        // }

        return returnList;
      case (MatrixCalculationType.days):
        matrixLength = _getLength(
          matrixStartDate,
          matrixEndDate,
          Duration(days: 1),
        );
        rudamentaryList = _createRudamentaryMatrix(
          sortedEntries,
          matrixStartDate,
          matrixEndDate,
          Duration(days: 1),
        );

        returnList = _combineRows(matrixLength, rudamentaryList);

        // for (List list in returnList) {
        //   debugPrint(list.toString());
        // }

        return returnList;
    }
  }

  List<List<EntryCellInfo?>> _createRudamentaryMatrix(
    List<FrontEntry> sortedEntries,
    DateTime matrixStartDate,
    DateTime matrixEndDate,
    Duration interval,
  ) {
    List<List<EntryCellInfo?>> returnList = [];
    int matrixLength = _getLength(matrixStartDate, matrixEndDate, interval);
    for (int x = 0; x < sortedEntries.length; x++) {
      int entryLength = _getLength(
        sortedEntries[x].startTime!,
        sortedEntries[x].endTime!,
        interval,
      );
      int lengthBefore = _getLength(
        matrixStartDate,
        sortedEntries[x].startTime!,
        interval,
      );
      int lengthAfter = matrixLength - (lengthBefore + entryLength);
      List<EntryCellInfo?> newList = List.filled(matrixLength, null);
      for (int i = 0; i < matrixLength; i++) {
        // debugPrint(
        //   (i > max(lengthBefore - 1, 0) &&
        //           i < (matrixLength - max(lengthAfter - 1, 0)))
        //       .toString(),
        // );
        if (i > lengthBefore - 1 &&
            i < (matrixLength - max(lengthAfter - 1, 0))) {
          bool isStart = false;
          bool isEnd = false;
          bool isStandAlone = false;

          if (i == lengthBefore) {
            isStart = true;
          }
          if (i == lengthBefore + entryLength || i == matrixLength - 1) {
            isEnd = true;
          }
          if (isStart && isEnd) {
            isStandAlone = true;
          }

          newList[i] = EntryCellInfo(
            shouldDisplay: true,
            // isStart: i - 1 < 0 || newList[i - 1] == null,
            // isEnd: i + 1 == matrixLength || i + 1 == lengthBefore + entryLength,
            // isStandAlone:
            //     (i - 1 < 0 || newList[i - 1] == null) &&
            //     (i + 1 == matrixLength || i + 1 == lengthBefore + entryLength),
            isStart: isStart,
            isEnd: isEnd,
            isStandAlone: isStandAlone,
            cellCount: entryLength,
            relevantEntry: sortedEntries[x],
          );
        }
        // debugPrint(newList[i].toString());
      }
      returnList.add(newList);
      // debugPrint('startTime: ${sortedEntries[x].startTime!}');
      // debugPrint('endTime: ${sortedEntries[x].endTime!}');
      // debugPrint('lengthBefore: $lengthBefore');
      // debugPrint('entryLength: $entryLength');
      // debugPrint('lengthAfter: $lengthAfter');
    }
    // for (List list in returnList) {
    //   debugPrint(list.toString());
    // }
    return returnList;
  }

  List<List<EntryCellInfo?>> _combineRows(
    int matrixLength,
    List<List<EntryCellInfo?>> matrix,
  ) {
    List<List<EntryCellInfo?>> newMatrix = matrix;

    for (int i = 0; i < newMatrix.length;) {
      // debugPrint(i.toString());
      if (i < newMatrix.length - 1) {
        bool canCombine = _canCombineRows(
          firstRow: newMatrix[i + 0],
          secondRow: newMatrix[i + 1],
        );
        if (canCombine) {
          newMatrix[i + 1] = _combineTwoRows(
            firstRow: newMatrix[i + 0],
            secondRow: newMatrix[i + 1],
          );
          newMatrix.removeAt(i);
        } else {
          i++;
        }
      } else {
        i++;
      }
    }

    return newMatrix;
  }

  bool _canCombineRows({
    required List<EntryCellInfo?> firstRow,
    required List<EntryCellInfo?> secondRow,
  }) {
    if (firstRow.length == secondRow.length) {
      for (int i = 0; i < firstRow.length; i++) {
        if (i + 1 != firstRow.length &&
            (firstRow[i] == null) == (secondRow[i + 1] == null) &&
            firstRow[i] != null) {
          return false;
        }
        if (i - 1 > 0 &&
            (firstRow[i] == null) == (secondRow[i - 1] == null) &&
            firstRow[i] != null) {
          return false;
        }
        if ((firstRow[i] == null) == (secondRow[i] == null) &&
            firstRow[i] != null) {
          return false;
        }
      }
    } else {
      throw ArgumentError(
        '${firstRow.length}, ${secondRow.length} \n ${firstRow.toString()} \n ${secondRow.toString()}',
      );
    }
    return true;
  }

  List<EntryCellInfo?> _combineTwoRows({
    required List<EntryCellInfo?> firstRow,
    required List<EntryCellInfo?> secondRow,
  }) {
    List<EntryCellInfo?> newRow = secondRow;
    if (firstRow.length == secondRow.length) {
      for (int i = 0; i < firstRow.length; i++) {
        bool firstRowNull = firstRow[i] == null;
        bool secondRowNull = secondRow[i] == null;

        if (firstRowNull != secondRowNull) {
          if (!firstRowNull) {
            newRow[i] = firstRow[i];
          } else if (!secondRowNull) {
            newRow[i] = secondRow[i];
          }
        } else {
          if (!firstRowNull) {
            throw ArgumentError();
          }
        }
      }
    } else {
      throw ArgumentError();
    }
    return newRow;
  }

  int _getLength(DateTime startDate, DateTime endDate, Duration interval) {
    DateTime mutibleStartDate = startDate;
    int finalLength = 0;
    // debugPrint(mutibleStartDate.toString());
    // debugPrint(endDate.toString());
    for (int i = 0; mutibleStartDate.isBefore(endDate); i++) {
      // debugPrint(i.toString());
      // debugPrint(mutibleStartDate.toString());
      mutibleStartDate = mutibleStartDate.add(interval);
      finalLength = i;
    }
    return finalLength;
  }

  List<FrontEntry> _sortEntries() {
    List<FrontEntry> frontEntries = entries;
    frontEntries.sort(
      (entryOne, entryTwo) =>
          entryOne.startTime!.compareTo(entryTwo.startTime!),
    );
    // for (FrontEntry entry in frontEntries) {
    //   debugPrint(
    //     'each front entry start date: ${entry.startTime?.toIso8601String()}',
    //   );
    // }
    return [...frontEntries];
  }

  List<FrontEntry> _sortEntriesByEndDate() {
    List<FrontEntry> frontEntries = entries;
    frontEntries.sort(
      (entryOne, entryTwo) => entryTwo.endTime!.compareTo(entryOne.endTime!),
    );
    // for (FrontEntry entry in frontEntries) {
    //   debugPrint(
    //     'each front entry end date: ${entry.endTime?.toIso8601String()}',
    //   );
    // }
    return [...frontEntries];
  }
}
