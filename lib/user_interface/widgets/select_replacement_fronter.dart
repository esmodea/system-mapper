import 'package:flutter/material.dart';
import 'package:system_mapper/data/hive_objects/system/member.dart';
import 'package:system_mapper/user_interface/widgets/system_text_button.dart';
import 'package:system_mapper/utils/current.dart';

class SelectReplacementFronter extends StatelessWidget {
  final Member filterMember;
  const SelectReplacementFronter({super.key, required this.filterMember});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorScheme.of(context).shadow,
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(15, 15),
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(38)),
          color: ColorScheme.of(context).primaryContainer,
        ),
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
            SystemTextButton(
              text: 'No way!',
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
