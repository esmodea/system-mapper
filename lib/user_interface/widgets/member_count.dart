import 'package:flutter/material.dart';
import 'package:system_mapper/utils/current.dart';

class MemberCount extends StatelessWidget {
  const MemberCount({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorScheme.of(context).surface.withAlpha(80),
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
            Current.system?.membersList?.length.toString() ?? '0',
            style: TextTheme.of(context).displaySmall,
          ),
        ],
      ),
    );
  }
}
