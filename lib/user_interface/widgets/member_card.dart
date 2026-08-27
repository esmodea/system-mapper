import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:system_mapper/data/hive_objects/member.dart';
import 'package:system_mapper/user_interface/widgets/member_form.dart';
import 'package:system_mapper/utils/current.dart';
import 'package:system_mapper/utils/safe_set_state.dart';

class MemberCard extends StatefulWidget {
  final Member? member;
  final bool hideBio;
  final bool hideButtons;
  final bool showFrontTime;
  const MemberCard({
    super.key,
    this.member,
    this.hideBio = false,
    this.hideButtons = false,
    this.showFrontTime = false,
  });

  @override
  State<MemberCard> createState() => _MemberCardState();
}

class _MemberCardState extends SafeState<MemberCard> {
  late bool inFront =
      widget.member?.inFront ?? widget.member?.inFrontCheck() ?? true;
  bool hideFrontTimes = true;
  late Duration timeFronting = DateTime.now().difference(
    Current
            .front
            ?.activeFrontEntries?[max(
              0,
              Current.front?.activeFrontEntries?.indexWhere(
                    (entry) =>
                        entry.member?.memberName == widget.member?.memberName,
                  ) ??
                  0,
            )]
            .startTime ??
        DateTime.now(),
  );

  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if ((Current.front?.activeFrontEntries?.indexWhere(
                (entry) =>
                    widget.member?.memberName == entry.member?.memberName,
              ) ??
              -1) >=
          0) {
        safeSetState(
          () => timeFronting = DateTime.now().difference(
            Current
                    .front
                    ?.activeFrontEntries?[max(
                      0,
                      Current.front?.activeFrontEntries?.indexWhere(
                            (entry) =>
                                entry.member?.memberName ==
                                widget.member?.memberName,
                          ) ??
                          0,
                    )]
                    .startTime ??
                DateTime.now(),
          ),
        );
        // if (mounted) {
        //   setState(() {
        //     hideFrontTimes = false;
        //   });
        // }
        safeSetState(() {
          hideFrontTimes = false;
        });
      } else {
        safeSetState(() {
          hideFrontTimes = true;
        });
      }
      if (inFront == true) {
        safeSetState(() {
          inFront =
              widget.member?.inFront ?? widget.member?.inFrontCheck() ?? true;
        });
      }
      // debugPrint(
      //   DateTime.now()
      //       .difference(
      //         Current
      //                 .front
      //                 ?.activeFrontEntries?[max(
      //                   0,
      //                   Current.front?.activeFrontEntries?.indexWhere(
      //                         (entry) =>
      //                             entry.member?.memberName ==
      //                             widget.member?.memberName,
      //                       ) ??
      //                       0,
      //                 )]
      //                 .startTime ??
      //             DateTime.now(),
      //       )
      //       .toString(),
      // );
      if (Current.front?.activeFrontEntries?.isNotEmpty ?? false) {
        // debugPrint(
        //   Current
        //       .front
        //       ?.activeFrontEntries?[max(
        //         0,
        //         Current.front?.activeFrontEntries?.indexWhere(
        //               (entry) =>
        //                   entry.member?.memberName == widget.member?.memberName,
        //             ) ??
        //             0,
        //       )]
        //       .startTime
        //       .toString(),
        // );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(Current.front?.toString());
    // debugPrint(Current.front?.membersInFront?.toString());
    // debugPrint(widget.member?.inFrontCheck().toString());
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
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.member!.memberName ?? '',
                      style: TextTheme.of(context).headlineMedium,
                    ),
                    if (!widget.hideButtons)
                      ValueListenableBuilder(
                        valueListenable: Current.systemListenable,
                        builder: (context, value, child) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FloatingActionButton(
                              onPressed: () {
                                if (widget.member?.inFront ??
                                    widget.member?.inFrontCheck() ??
                                    true) {
                                  widget.member?.removeFromFront();
                                } else {
                                  widget.member?.addToFront();
                                }
                                safeSetState(
                                  () => inFront =
                                      widget.member?.inFront ??
                                      widget.member?.inFrontCheck() ??
                                      true,
                                );
                              },
                              child: Icon(inFront ? Icons.remove : Icons.add),
                            ),
                          );
                        },
                      ),
                  ],
                ),
                if (widget.showFrontTime &&
                    timeFronting.inMicroseconds > 0 &&
                    !hideFrontTimes)
                  Positioned(
                    right: 60,
                    top: 30,
                    child: SizedBox(
                      width: 180,
                      height: 60,
                      child: Text(
                        'Fronting for ${(timeFronting.inDays / 7) > 0 ? '${(timeFronting.inDays / 7)}w ' : ''}${timeFronting.inDays > 0 ? '${timeFronting.inDays % 7}d ' : ''}${timeFronting.inHours > 0 ? '${timeFronting.inHours % 24}h ' : ''}${timeFronting.inMinutes > 0 ? '${timeFronting.inMinutes % 60}m ' : ''}${timeFronting.inSeconds > 0 ? '${timeFronting.inSeconds % 60}s ' : ''}',
                        style: TextTheme.of(context).bodyLarge,
                      ),
                    ),
                  ),
              ],
            ),
            if (!widget.hideBio)
              ValueListenableBuilder(
                valueListenable: Current.frontListenable,
                builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 80),
                    child: Divider(thickness: 2),
                  );
                },
              ),
            if (!widget.hideBio)
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
