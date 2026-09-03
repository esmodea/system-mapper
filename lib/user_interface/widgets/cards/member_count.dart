import 'dart:async';

import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:system_mapper/utils/current.dart';

class MemberCount extends StatefulWidget {
  final MemberCountType type;
  final Color? backgroundColor;
  final bool isBlank;
  const MemberCount({
    super.key,
    required this.type,
    this.backgroundColor,
    this.isBlank = false,
  });

  @override
  State<MemberCount> createState() => _MemberCountState();
}

class _MemberCountState extends State<MemberCount> {
  AnimatedDigitController controller = AnimatedDigitController(0);

  @override
  void initState() {
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (mounted) {
        controller.addValue(widget.type.count() - controller.value);
      } else {
        timer.cancel();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    Color? _backgroundColor =
        widget.backgroundColor ?? ColorScheme.of(context).surface;
    if (widget.isBlank) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Shimmer(
          duration: Duration(seconds: 1),
          child: Container(
            decoration: BoxDecoration(
              color: _backgroundColor.withAlpha(80),
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            width: 80,
            height: 80,
            alignment: Alignment.center,
            child: Row(mainAxisSize: MainAxisSize.min, children: []),
          ),
        ),
      );
    }
    return ValueListenableBuilder(
      valueListenable: Current.systemListenable,
      builder: (context, value, child) {
        return ValueListenableBuilder(
          valueListenable: Current.standardFrontListenable,
          builder: (context, value, child) {
            controller.addValue(widget.type.count() - controller.value);
            return Container(
              decoration: BoxDecoration(
                color: _backgroundColor.withAlpha(80),
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              width: 80,
              height: 80,
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person_outline,
                    size: TextTheme.of(context).displaySmall?.fontSize,
                  ),
                  AnimatedDigitWidget(controller: controller, loop: false),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

enum MemberCountType {
  totalCount(),
  frontCount(),
  consciousSingleFrontCount();

  const MemberCountType();

  int count() {
    switch (this) {
      case (totalCount):
        return Current.system?.membersList?.length ?? 0;
      case (frontCount):
        return Current.standardFront?.membersInFront?.length ?? 0;
      case (consciousSingleFrontCount):
        return Current.singleFront?.membersConscious?.length ?? 0;
    }
  }
}
