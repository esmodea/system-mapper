import 'package:flutter/material.dart';
import 'package:system_mapper/data/hive_objects/member.dart';
import 'package:system_mapper/user_interface/widgets/member_form.dart';

class MemberCard extends StatelessWidget {
  final Member? member;
  const MemberCard({super.key, this.member});

  @override
  Widget build(BuildContext context) {
    if (member != null) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: ColorScheme.of(context).surface,
        ),
        padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
        constraints: BoxConstraints(maxWidth: 500, maxHeight: 200),
        child: Row(
          children: [
            Text(member!.memberName ?? 'ERROR'),
            FloatingActionButton(onPressed: () {}, child: Icon(Icons.edit)),
          ],
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: ColorScheme.of(context).surface,
        ),
        padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
        constraints: BoxConstraints(maxWidth: 500, maxHeight: 200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Add a new member'),
            FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return MemberForm(
                      callback: () {
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      );
    }
  }
}
