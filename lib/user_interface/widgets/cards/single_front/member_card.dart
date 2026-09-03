import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:system_mapper/data/hive_objects/system/member.dart';
import 'package:system_mapper/user_interface/widgets/forms/member_form.dart';
import 'package:system_mapper/user_interface/widgets/select_replacement_fronter.dart';
import 'package:system_mapper/user_interface/widgets/system_text_button.dart';
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
  late bool inFront = widget.member?.inFrontCheck() ?? false;
  late bool isConscious = widget.member?.consciousCheck() ?? false;
  bool hideFrontTimes = true;
  late Duration timeFronting;

  late Timer _timer;

  @override
  void initState() {
    if (isConscious) {
      timeFronting = DateTime.now().difference(
        Current
                .singleFront
                ?.activeConsciousnessEntries?[max(
                  0,
                  Current.singleFront?.activeConsciousnessEntries?.indexWhere(
                        (entry) =>
                            entry.member?.memberName ==
                            widget.member?.memberName,
                      ) ??
                      0,
                )]
                .startTime ??
            DateTime.now(),
      );
    } else if (inFront) {
      timeFronting = DateTime.now().difference(
        Current
                .singleFront
                ?.activeFrontEntries?[max(
                  0,
                  Current.singleFront?.activeFrontEntries?.indexWhere(
                        (entry) =>
                            entry.member?.memberName ==
                            widget.member?.memberName,
                      ) ??
                      0,
                )]
                .startTime ??
            DateTime.now(),
      );
    } else {
      timeFronting = Duration(milliseconds: 0);
    }
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (isConscious &&
          (Current.singleFront?.activeConsciousnessEntries?.isNotEmpty ??
              false)) {
        safeSetState(
          () => timeFronting = DateTime.now().difference(
            Current
                    .singleFront
                    ?.activeConsciousnessEntries?[max(
                      0,
                      Current.singleFront?.activeConsciousnessEntries
                              ?.indexWhere(
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
        safeSetState(() {
          hideFrontTimes = false;
        });
      } else if (inFront &&
          (Current.singleFront?.activeFrontEntries?.isNotEmpty ?? false)) {
        safeSetState(
          () => timeFronting = DateTime.now().difference(
            Current
                    .singleFront
                    ?.activeFrontEntries?[max(
                      0,
                      Current.singleFront?.activeFrontEntries?.indexWhere(
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
        safeSetState(() {
          hideFrontTimes = false;
        });
      } else {
        safeSetState(() {
          hideFrontTimes = true;
        });
      }
      safeSetState(() {
        inFront = widget.member?.inFrontCheck() ?? false;
        isConscious = widget.member?.consciousCheck() ?? false;
      });
      // debugPrint('inFront:');
      // debugPrint(inFront.toString());
      // debugPrint('isConscious:');
      // debugPrint(isConscious.toString());
      if (Current.singleFront?.activeFrontEntries?.isNotEmpty ?? false) {}
    });
    SchedulerBinding.instance.scheduleFrame();
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
      return LayoutBuilder(
        builder: (context, constraints) {
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
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 10),
                            CircleAvatar(
                              radius: 24,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(24),
                                  ),
                                  color:
                                      widget.member?.avatarColor ??
                                      ColorScheme.of(context).primaryContainer,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            SizedBox(
                              width: constraints.maxWidth / 3,
                              child: Text(
                                widget.member!.memberName ?? '',
                                style: TextTheme.of(context).headlineMedium,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        if (!widget.hideButtons)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (widget.showFrontTime &&
                                  timeFronting.inMicroseconds > 0 &&
                                  !hideFrontTimes)
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                        minHeight: 60,
                                        minWidth: 96,
                                      ),
                                      width: constraints.maxWidth / 6,
                                      padding: EdgeInsets.all(16),
                                      child: Wrap(
                                        children: [
                                          Text(
                                            '${(timeFronting.inDays / 7) >= 1 ? '${(timeFronting.inDays / 7)}w ' : ''}${timeFronting.inDays > 0 ? '${timeFronting.inDays % 7}d ' : ''}${timeFronting.inHours > 0 ? '${timeFronting.inHours % 24}h ' : ''}${timeFronting.inMinutes > 0 && !(timeFronting.inDays > 0) ? '${timeFronting.inMinutes % 60}m ' : ''}${timeFronting.inSeconds > 0 && !(timeFronting.inHours > 0) ? '${timeFronting.inSeconds % 60}s ' : ''}',
                                            style: TextTheme.of(
                                              context,
                                            ).bodyLarge,
                                            maxLines: 1,
                                            overflow: TextOverflow.clip,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              if (!((inFront || isConscious) &&
                                      !hideFrontTimes) ||
                                  !widget.hideBio)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      if (timeFronting.inMicroseconds > 0 &&
                                          !hideFrontTimes) {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Center(
                                              child: Container(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: ColorScheme.of(
                                                        context,
                                                      ).shadow,
                                                      spreadRadius: 0,
                                                      blurRadius: 10,
                                                      offset: Offset(15, 15),
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                        Radius.circular(38),
                                                      ),
                                                  color: ColorScheme.of(
                                                    context,
                                                  ).primaryContainer,
                                                ),
                                                width: 600,
                                                height: 400,
                                                padding: EdgeInsets.all(24),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      'You can\'t edit a member that\'s currently in the front!',
                                                      style: TextTheme.of(
                                                        context,
                                                      ).displayLarge,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    SizedBox(
                                                      width: 300,
                                                      child: SystemTextButton(
                                                        text: 'Okay...',
                                                        onPressed: () {
                                                          if (Navigator.canPop(
                                                            context,
                                                          )) {
                                                            Navigator.pop(
                                                              context,
                                                            );
                                                          }
                                                        },
                                                        fontSize: ButtonFontSize
                                                            .large,
                                                        isExpanded: true,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context) {
                                            return MemberForm(
                                              isEdit: true,
                                              editMember: widget.member,
                                              callback: () {
                                                Navigator.of(context).pop();
                                              },
                                            );
                                          },
                                        );
                                      }
                                    },
                                    child: Icon(Icons.edit),
                                  ),
                                ),
                              ValueListenableBuilder(
                                valueListenable: Current.systemListenable,
                                builder: (context, value, child) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FloatingActionButton(
                                      onPressed: () {
                                        if (inFront || isConscious) {
                                          widget.member
                                              ?.removeFromSingleFront();
                                          if (!isConscious) {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return SelectReplacementFronter(
                                                  filterMember:
                                                      widget.member ?? Member(),
                                                );
                                              },
                                            );
                                          }
                                        } else {
                                          widget.member?.addToSingleFront();
                                        }
                                        safeSetState(() {
                                          inFront =
                                              widget.member?.inFrontCheck() ??
                                              false;
                                          isConscious =
                                              widget.member?.consciousCheck() ??
                                              false;
                                        });
                                      },
                                      child: ValueListenableBuilder(
                                        valueListenable:
                                            Current.systemListenable,
                                        builder: (context, value, child) {
                                          return Icon(
                                            (inFront || isConscious)
                                                ? Icons.remove
                                                : Icons.add,
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
                if (!widget.hideBio)
                  ValueListenableBuilder(
                    valueListenable: Current.singleFrontListenable,
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
        },
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
                  isScrollControlled: true,
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
