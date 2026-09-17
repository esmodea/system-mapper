import 'package:flutter/material.dart';
import 'package:system_mapper/data/hive_objects/system/member.dart';
import 'package:system_mapper/utils/current.dart';
import 'package:uuid/uuid.dart';

class SelectReplacementFronter extends StatelessWidget {
  final Member filterMember;
  const SelectReplacementFronter({super.key, required this.filterMember});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.bottomCenter,
        width: 600,
        height: 400,
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Text('Add a member to the front?'),
            ...Current.system?.membersList?.map((member) {
                  if (filterMember.memberName != member.memberName) {
                    return Row(
                      children: [
                        Text(member.memberName ?? ''),
                        FloatingActionButton(
                          heroTag:
                              '${'${member.memberName}${Uuid().v6().toString()}'}heroTag',
                          onPressed: () async {
                            await member.removeFromSingleFront();
                            await member.addToSingleFront();
                            if (context.mounted) {
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            }
                          },
                        ),
                      ],
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                }) ??
                [],
          ],
        ),
      ),
    );
  }
}
