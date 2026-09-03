import 'package:flutter/material.dart';
import 'package:system_mapper/data/hive_objects/system/system_front_type.dart';
import 'package:system_mapper/user_interface/widgets/widget_states/fronting_status/single_front_status.dart';
import 'package:system_mapper/user_interface/widgets/widget_states/fronting_status/standard_front_status.dart';
import 'package:system_mapper/utils/current.dart';

class FrontingStatus extends StatefulWidget {
  final bool isBlank;
  const FrontingStatus({super.key, this.isBlank = false});

  @override
  State<FrontingStatus> createState() => _FrontingStatusState();
}

class _FrontingStatusState extends State<FrontingStatus> {
  @override
  Widget build(BuildContext context) {
    switch (SystemFrontType.parse(Current.system?.frontType.toString() ?? '')) {
      case SystemFrontType.onlyTrackFront:
        return StandardFrontStatus(isBlank: widget.isBlank);
      case SystemFrontType.trackSingleFront:
        return SingleFrontStatus(isBlank: widget.isBlank);
      default:
        return StandardFrontStatus(isBlank: widget.isBlank);
    }
  }
}
