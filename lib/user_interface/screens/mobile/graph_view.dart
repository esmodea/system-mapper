import 'package:flutter/material.dart';
import 'package:system_mapper/data/hive_objects/front/front_entry.dart';
import 'package:system_mapper/user_interface/widgets/calendar_view.dart';
import 'package:system_mapper/user_interface/widgets/cards/front_history_card.dart';
import 'package:system_mapper/user_interface/widgets/data_visualizers/front_entry_cell.dart';
import 'package:system_mapper/utils/current.dart';
import 'package:uuid/uuid.dart';

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

            List<List<EntryCellInfo?>> entryPlacementMatrix = EntryCalculator(
              entries: frontHistoryEntries,
            ).getBinaryMatrix(MatrixCalculationType.hours);

            return FutureBuilder(
              future: Future.delayed(Duration(seconds: 1)),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState.name == 'done') {
                  return LayoutBuilder(
                    builder: ((context, constraints) {
                      return ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth,
                          maxHeight: constraints.maxHeight,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 24,
                            left: 24,
                            right: 24,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [...frontHistoryWidgets],
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                } else {
                  return LayoutBuilder(
                    builder: ((context, constraints) {
                      return ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth,
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
