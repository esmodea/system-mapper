import 'package:flutter/material.dart';
import 'package:system_mapper/data/hive_objects/front/front_entry.dart';
import 'package:system_mapper/utils/safe_set_state.dart';

class StandardFrontHistoryCard extends StatefulWidget {
  final FrontEntry? entry;
  const StandardFrontHistoryCard({super.key, this.entry});

  @override
  State<StandardFrontHistoryCard> createState() => _FrontHistoryCardState();
}

class _FrontHistoryCardState extends SafeState<StandardFrontHistoryCard> {
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
