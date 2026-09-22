import 'dart:async';
import 'package:flutter/material.dart';
import 'package:system_mapper/data/hive_objects/front/front_entry.dart';
import 'package:system_mapper/data/hive_objects/system/system.dart';
import 'package:system_mapper/user_interface/widgets/forms/end_front_form.dart';
import 'package:system_mapper/utils/current.dart';
import 'package:system_mapper/utils/safe_set_state.dart';
import 'package:uuid/uuid.dart';

class FrontingCard extends StatefulWidget {
  final FrontEntry? entry;
  final System system;
  const FrontingCard({super.key, this.entry, required this.system});

  @override
  State<FrontingCard> createState() => _FrontingCardState();
}

class _FrontingCardState extends SafeState<FrontingCard> {
  late bool isConscious = widget.entry?.member?.consciousCheck() ?? false;

  late Duration timeFronting;

  late Timer _timer;

  @override
  void initState() {
    if (isConscious) {
      timeFronting = DateTime.now().difference(
        widget.entry?.startTime ?? DateTime.now(),
      );
    } else {
      timeFronting = DateTime.now().difference(
        widget.entry?.startTime ?? DateTime.now(),
      );
    }
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (isConscious) {
        timeFronting = DateTime.now().difference(
          widget.entry?.startTime ?? DateTime.now(),
        );
      } else {
        timeFronting = DateTime.now().difference(
          widget.entry?.startTime ?? DateTime.now(),
        );
      }
      safeSetState(() {
        timeFronting;
      });
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
    if (widget.entry?.member != null) {
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
                            CircleAvatar(
                              radius: 24,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(24),
                                  ),
                                  color:
                                      widget.entry?.member?.avatarColor ??
                                      ColorScheme.of(context).primaryContainer,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            SizedBox(
                              width: (constraints.maxWidth / 3) - 5,
                              child: Text(
                                widget.entry?.member?.memberName ?? '',
                                style: TextTheme.of(context).headlineMedium,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (timeFronting.inMicroseconds > 0)
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                      minHeight: 60,
                                      minWidth: 96,
                                    ),
                                    alignment: Alignment.center,
                                    width: constraints.maxWidth / 4,
                                    padding: EdgeInsets.all(16),
                                    child: Wrap(
                                      children: [
                                        Text(
                                          '${(timeFronting.inDays / 7) >= 1 ? '${(timeFronting.inDays / 7).roundToDouble().toInt()}w ' : ''}${timeFronting.inDays > 0 ? '${timeFronting.inDays % 7}d ' : ''}${timeFronting.inHours > 0 ? '${timeFronting.inHours % 24}h ' : ''}${timeFronting.inMinutes > 0 && !(timeFronting.inDays > 0) ? '${timeFronting.inMinutes % 60}m ' : ''}${timeFronting.inSeconds > 0 && !(timeFronting.inHours > 0) ? '${timeFronting.inSeconds % 60}s ' : ''}',
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton(
                                heroTag:
                                    '${'${widget.entry?.member?.memberName}${Uuid().v6().toString()}'}heroTagFrontingCard',
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    // isScrollControlled: true,
                                    // constraints: BoxConstraints(
                                    //   maxHeight:
                                    //       (MediaQuery.heightOf(context) / 6) *
                                    //       5,
                                    // ),
                                    builder: (context) {
                                      return Dialog(
                                        child: EndFrontForm(
                                          initialEntry: widget.entry,
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: ValueListenableBuilder(
                                  valueListenable: Current.systemListenable,
                                  builder: (context, value, child) {
                                    return Icon(Icons.remove);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
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
        padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        constraints: BoxConstraints(maxHeight: 200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Something has gone deeply wrong...',
              style: TextTheme.of(
                context,
              ).bodyMedium?.copyWith(color: ColorScheme.of(context).onPrimary),
            ),
          ],
        ),
      );
    }
  }
}
