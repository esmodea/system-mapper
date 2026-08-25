import 'package:flutter/material.dart';
import 'package:system_mapper/data/hive_objects/member.dart';
import 'package:system_mapper/user_interface/widgets/member_card.dart';
import 'package:system_mapper/utils/current.dart';

class SystemMembers extends StatefulWidget {
  const SystemMembers({super.key});

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
    return ValueListenableBuilder(
      valueListenable: Current.systemListenable,
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: ColorScheme.of(context).primary,
          ),
          constraints: BoxConstraints(maxWidth: 600, maxHeight: 600),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...Current.system?.membersList
                          ?.map((member) => MemberCard(member: member))
                          .toList() ??
                      [],
                  MemberCard(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
