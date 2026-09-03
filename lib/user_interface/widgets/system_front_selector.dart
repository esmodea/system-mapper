import 'package:flutter/material.dart';
import 'package:system_mapper/data/hive_objects/system/system_front_type.dart';
import 'package:system_mapper/utils/safe_set_state.dart';

class SystemFrontSelector extends StatefulWidget {
  final Function(SystemFrontType type) stateCallback;
  const SystemFrontSelector({super.key, required this.stateCallback});

  @override
  State<SystemFrontSelector> createState() => _SystemFrontSelectorState();
}

class _SystemFrontSelectorState extends SafeState<SystemFrontSelector> {
  SystemFrontType type = .onlyTrackFront;
  @override
  Widget build(BuildContext context) {
    return SegmentedButton<SystemFrontType>(
      selected: <SystemFrontType>{type},
      onSelectionChanged: (Set<SystemFrontType> value) {
        safeSetState(() {
          type = value.first;
        });
        widget.stateCallback(value.first);
      },
      multiSelectionEnabled: false,
      segments: [
        ButtonSegment<SystemFrontType>(
          icon: Icon(SystemFrontType.onlyTrackFront.icon),
          value: SystemFrontType.onlyTrackFront,
          label: Text(SystemFrontType.onlyTrackFront.label),
        ),
        ButtonSegment<SystemFrontType>(
          icon: Icon(SystemFrontType.trackSingleFront.icon),
          value: SystemFrontType.trackSingleFront,
          label: Text(SystemFrontType.trackSingleFront.label),
        ),
      ],
    );
  }
}
