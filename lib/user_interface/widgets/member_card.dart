import 'package:flutter/material.dart';
import 'package:system_mapper/data/hive_objects/member.dart';
import 'package:system_mapper/user_interface/widgets/member_form.dart';
import 'package:system_mapper/utils/current.dart';
import 'package:system_mapper/utils/safe_set_state.dart';

class MemberCard extends StatefulWidget {
  final Member? member;
  const MemberCard({super.key, this.member});

  @override
  State<MemberCard> createState() => _MemberCardState();
}

class _MemberCardState extends SafeState<MemberCard> {
  late bool inFront = widget.member?.inFront() ?? true;

  @override
  Widget build(BuildContext context) {
    debugPrint(Current.front?.toString());
    debugPrint(Current.front?.membersInFront?.toString());
    debugPrint(widget.member?.inFront().toString());
    if (widget.member != null) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: ColorScheme.of(context).surface,
        ),
        padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
        constraints: BoxConstraints(maxHeight: 200),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.member!.memberName ?? '',
                  style: TextTheme.of(context).headlineMedium,
                ),
                FloatingActionButton(
                  onPressed: () {
                    if (widget.member?.inFront() ?? false) {
                      widget.member?.removeFromFront();
                    } else {
                      widget.member?.addToFront();
                    }
                    safeSetState(
                      () => inFront = widget.member?.inFront() ?? true,
                    );
                    setState(() {
                      
                    });
                  },
                  child: Icon(inFront ? Icons.remove : Icons.add),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 60),
              child: Divider(thickness: 2),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorScheme.of(context).primary.withAlpha(100),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                padding: EdgeInsets.all(10),
                child: Text(
                  widget.member!.memberBio ?? '',
                  style: TextTheme.of(context).bodyMedium,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          // color: ColorScheme.of(context).surface,
        ),
        padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
        constraints: BoxConstraints(maxHeight: 200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Add a new member',
              style: TextTheme.of(
                context,
              ).bodyMedium?.copyWith(color: ColorScheme.of(context).onPrimary),
            ),
            SizedBox(width: 10),
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
