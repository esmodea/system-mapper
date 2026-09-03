import 'package:flutter/material.dart';
import 'package:system_mapper/data/hive_objects/system/member.dart';
import 'package:system_mapper/data/hive_objects/system/system_front_type.dart';
import 'package:system_mapper/user_interface/widgets/widget_states/system_members/single_system_members.dart';
import 'package:system_mapper/user_interface/widgets/widget_states/system_members/standard_system_members.dart';
import 'package:system_mapper/utils/current.dart';

class SystemMembers extends StatefulWidget {
  final bool isBlank;
  const SystemMembers({super.key, this.isBlank = false});

  @override
  State<SystemMembers> createState() => _SystemMembersState();
}

class _SystemMembersState extends State<SystemMembers> {
  List<Member> memberList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (SystemFrontType.parse(Current.system?.frontType.toString() ?? '')) {
      case SystemFrontType.onlyTrackFront:
        return StandardSystemMembers(isBlank: widget.isBlank);
      case SystemFrontType.trackSingleFront:
        return SingleSystemMembers(isBlank: widget.isBlank);
      default:
        return StandardSystemMembers(isBlank: widget.isBlank);
    }
  }
}
