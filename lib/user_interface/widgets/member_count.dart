import 'package:flutter/material.dart';
import 'package:system_mapper/utils/current.dart';

class MemberCount extends StatelessWidget {
  final MemberCountType type;
  final Color? backgroundColor;
  const MemberCount({super.key, required this.type, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    Color? _backgroundColor =
        backgroundColor ?? ColorScheme.of(context).surface;
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
          Text(
            type.count().toString(),
            style: TextTheme.of(context).displaySmall,
          ),
        ],
      ),
    );
  }
}

enum MemberCountType {
  totalCount(),
  frontCount();

  const MemberCountType();

  int count() {
    switch (this) {
      case (totalCount):
        return Current.system?.membersList?.length ?? 0;
      case (frontCount):
        return Current.front?.membersInFront?.length ?? 0;
    }
  }
}
