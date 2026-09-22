import 'package:flutter/material.dart';
import 'package:system_mapper/data/hive_objects/front/front_entry.dart';
import 'package:system_mapper/user_interface/widgets/cards/front_history_card.dart';
// import 'package:system_mapper/user_interface/widgets/data_visualizers/front_entry_cell.dart';
import 'package:system_mapper/utils/current.dart';

class GraphView extends StatefulWidget {
  const GraphView({super.key});

  @override
  State<GraphView> createState() => _GraphViewState();
}

class _GraphViewState extends State<GraphView> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Current.standardFrontArchiveListenable,
      builder: (context, standardFrontBox, child) {
        return ValueListenableBuilder(
          valueListenable: Current.singleFrontArchiveListenable,
          builder: (context, singleFrontBox, child) {
            List<Widget> frontHistoryWidgets = [];
            List<FrontEntry> frontHistoryEntries = [];
            if (standardFrontBox.isNotEmpty) {
              frontHistoryWidgets = [
                ...frontHistoryWidgets,
                ...standardFrontBox.values.first.archivedFrontEntries?.map((
                      entry,
                    ) {
                      return FrontHistoryCard(entry: entry);
                    }) ??
                    [],
              ];
              frontHistoryEntries = [
                ...frontHistoryEntries,
                ...standardFrontBox.values.first.archivedFrontEntries ?? [],
              ];
            }
            if (singleFrontBox.isNotEmpty) {
              frontHistoryWidgets = [
                ...frontHistoryWidgets,
                ...singleFrontBox.values.first.archivedFrontEntries?.map((
                      entry,
                    ) {
                      return FrontHistoryCard(entry: entry);
                    }) ??
                    [],
              ];
              frontHistoryEntries = [
                ...frontHistoryEntries,
                ...singleFrontBox.values.first.archivedFrontEntries ?? [],
              ];
              frontHistoryWidgets = [
                ...frontHistoryWidgets,
                ...singleFrontBox.values.first.archivedConsciousnessEntries
                        ?.map((entry) {
                          return FrontHistoryCard(entry: entry);
                        }) ??
                    [],
              ];
              frontHistoryEntries = [
                ...frontHistoryEntries,
                ...singleFrontBox.values.first.archivedConsciousnessEntries ??
                    [],
              ];
            }

            for (int i = 0; i < frontHistoryWidgets.length; i++) {
              frontHistoryWidgets.insert(i, SizedBox(height: 10));
              i++;
            }
            frontHistoryWidgets.removeAt(0);

            // List<List<EntryCellInfo?>> entryPlacementMatrix = EntryCalculator(
            //   entries: frontHistoryEntries,
            // ).getBinaryMatrix(MatrixCalculationType.hours);

            return FutureBuilder(
              future: Future.delayed(Duration(seconds: 1)),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState.name == 'done') {
                  return LayoutBuilder(
                    builder: ((context, constraints) {
                      return Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: (constraints.maxWidth / 10) * 6,
                              maxHeight: constraints.maxHeight,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 24, left: 24),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [...frontHistoryWidgets],
                                ),
                              ),
                            ),
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: ((constraints.maxWidth / 10) * 4) - 20,
                              maxHeight: (constraints.maxHeight),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  // SingleChildScrollView(
                                  //   scrollDirection: Axis.horizontal,
                                  //   child: Column(
                                  //     children: [
                                  //       ...entryPlacementMatrix.map((row) {
                                  //         return Row(
                                  //           textDirection: TextDirection.rtl,
                                  //           children: [
                                  //             EntryCellInfo(
                                  //               shouldDisplay: false,
                                  //               isStart: false,
                                  //               isEnd: false,
                                  //               isStandAlone: false,
                                  //               cellCount: 0,
                                  //               relevantEntry: FrontEntry(),
                                  //             ).widget(Size(10, 50)),
                                  //             ...row
                                  //                 .map((entry) {
                                  //                   return entry?.widget(
                                  //                         Size(10, 50),
                                  //                       ) ??
                                  //                       EntryCellInfo(
                                  //                         shouldDisplay: false,
                                  //                         isStart: false,
                                  //                         isEnd: false,
                                  //                         isStandAlone: false,
                                  //                         cellCount: 0,
                                  //                         relevantEntry:
                                  //                             FrontEntry(),
                                  //                       ).widget(Size(10, 50));
                                  //                 })
                                  //                 .toList()
                                  //                 .reversed,
                                  //             EntryCellInfo(
                                  //               shouldDisplay: false,
                                  //               isStart: false,
                                  //               isEnd: false,
                                  //               isStandAlone: false,
                                  //               cellCount: 0,
                                  //               relevantEntry: FrontEntry(),
                                  //             ).widget(Size(10, 50)),
                                  //           ],
                                  //         );
                                  //       }),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  );
                } else {
                  return LayoutBuilder(
                    builder: ((context, constraints) {
                      return Wrap(
                        spacing: 20,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: (constraints.maxWidth / 10) * 6,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 24,
                                left: 24,
                                right: 24,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [],
                              ),
                            ),
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: ((constraints.maxWidth / 10) * 4) - 20,
                            ),
                            child: SingleChildScrollView(
                              child: Column(children: [
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}
