import 'package:flutter/material.dart';
import 'package:system_mapper/utils/misc_classes/months.dart';

class DateTimeCard extends StatelessWidget {
  final DateTime? dateTime;
  final double size;
  const DateTimeCard({super.key, required this.dateTime, this.size = 80});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size + 20,
      child: Column(
        children: [
          Container(
            color: Colors.red[300],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(Months.fromDateTime(dateTime).displayName),
                Text(dateTime?.year.toString() ?? ''),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: size,
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(
                dateTime?.day.toString() ?? '',
                style: TextTheme.of(
                  context,
                ).headlineLarge?.copyWith(color: Colors.black),
              ),
            ),
          ),
          Container(
            color: ColorScheme.of(context).shadow,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ((dateTime?.hour ?? 0) % 12).toString(),
                  style: TextTheme.of(
                    context,
                  ).bodySmall?.copyWith(color: Colors.white),
                ),
                Text(
                  ':',
                  style: TextTheme.of(
                    context,
                  ).bodySmall?.copyWith(color: Colors.white),
                ),
                Text(
                  dateTime?.minute.isNaN ?? false
                      ? 'Error'
                      : '${dateTime!.minute.toString().length <= 1 ? '0' : ''}${dateTime!.minute.toString()}',
                  style: TextTheme.of(
                    context,
                  ).bodySmall?.copyWith(color: Colors.white),
                ),
                if ((dateTime?.hour ?? 0) <= 12)
                  Text(
                    'am',
                    style: TextTheme.of(
                      context,
                    ).bodySmall?.copyWith(color: Colors.white),
                  ),
                if ((dateTime?.hour ?? 0) > 12)
                  Text(
                    'pm',
                    style: TextTheme.of(
                      context,
                    ).bodySmall?.copyWith(color: Colors.white),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
