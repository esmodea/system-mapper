import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/hive_objects/system/system.dart';
import 'package:system_mapper/data/hive_objects/system/system_front_type.dart';
import 'package:system_mapper/user_interface/widgets/widget_states/fronting_status/single_front_status.dart';
import 'package:system_mapper/user_interface/widgets/widget_states/fronting_status/standard_front_status.dart';
import 'package:system_mapper/utils/current.dart';

class FrontingStatus extends StatelessWidget {
  final bool isBlank;
  final Box<System> systemBox;
  const FrontingStatus({
    super.key,
    this.isBlank = false,
    required this.systemBox,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Current.standardFrontListenable,
      builder: (context, value, child) {
        return ValueListenableBuilder(
          valueListenable: Current.singleFrontListenable,
          builder: (context, value, child) {
            switch (SystemFrontType.parse(
              Current.system?.frontType.toString() ?? '',
            )) {
              case SystemFrontType.onlyTrackFront:
                return StandardFrontStatus(
                  isBlank: isBlank,
                  systemBox: systemBox,
                );
              case SystemFrontType.trackSingleFront:
                return SingleFrontStatus(
                  isBlank: isBlank,
                  systemBox: systemBox,
                );
              default:
                return StandardFrontStatus(
                  isBlank: isBlank,
                  systemBox: systemBox,
                );
            }
          },
        );
      },
    );
  }
}
