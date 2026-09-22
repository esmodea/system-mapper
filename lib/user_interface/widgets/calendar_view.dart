// horizontal_timeline_view.dart
//
// A horizontally-scrolling timeline: each entry is a bar spanning
// [start, end], entries that overlap in time are stacked into separate
// "lanes" so you can see them all, and a date ruler at the top scrolls
// in lockstep with the entry area.
//
// Dependency (pubspec.yaml):
//   linked_scroll_controller: ^0.2.0
//
// Example:
//   HorizontalTimelineView(
//     rangeStart: DateTime(2026, 1, 1),
//     rangeEnd: DateTime(2026, 3, 1),
//     entries: [
//       TimelineEntry(
//         id: 'trip-1',
//         start: DateTime(2026, 1, 3),
//         end: DateTime(2026, 1, 9),
//         builder: (context, width) => Container(
//           decoration: BoxDecoration(
//             color: Colors.indigo,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 8),
//           alignment: Alignment.centerLeft,
//           child: const Text('Trip', style: TextStyle(color: Colors.white)),
//         ),
//       ),
//     ],
//   )

import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:system_mapper/data/hive_objects/front/front_entry.dart';

/// One item to render on the timeline.
///
/// [start] and [end] are compared by calendar day (time-of-day is ignored),
/// so pass whatever DateTimes you have â€” they don't need to be normalized
/// to midnight first.
class TimelineEntry {
  final String id;
  final DateTime start;
  final DateTime end;
  final FrontEntry entry;

  /// Builds the bar's contents. [width] is the bar's rendered pixel width,
  /// in case you want to adapt content (e.g. hide the label below some
  /// width).
  final Widget Function(BuildContext context, double width) builder;

  TimelineEntry({
    required this.id,
    required this.start,
    required this.end,
    required this.entry,
    required this.builder,
  });
}

/// Assigns each entry to the lowest-numbered lane that's free when it
/// starts. This is the same greedy interval-graph-colouring approach
/// behind calendar day views: sort entries by start date, then for each
/// one, reuse the first lane whose current occupant has already ended;
/// if none is free, open a new lane. The result is the minimum number of
/// lanes needed to display every overlap simultaneously.
///
/// Runs in O(n * lanes) â€” fine well past thousands of entries. Swap the
/// inner linear scan for a min-heap keyed by lane end-date if you ever
/// need better asymptotics.
Map<String, int> assignLanes(List<TimelineEntry> entries) {
  final sorted = [...entries]..sort((a, b) => a.start.compareTo(b.start));
  final laneEndDates = <DateTime>[];
  final laneOf = <String, int>{};

  for (final entry in sorted) {
    var placed = false;
    for (var lane = 0; lane < laneEndDates.length; lane++) {
      if (!laneEndDates[lane].isAfter(entry.start)) {
        laneEndDates[lane] = entry.end;
        laneOf[entry.id] = lane;
        placed = true;
        break;
      }
    }
    if (!placed) {
      laneEndDates.add(entry.end);
      laneOf[entry.id] = laneEndDates.length - 1;
    }
  }
  return laneOf;
}

class HorizontalTimelineView extends StatefulWidget {
  final List<TimelineEntry> entries;
  final DateTime rangeStart;
  final DateTime rangeEnd;
  final double pixelsPerDay;
  final double laneHeight;
  final double laneSpacing;
  final double headerHeight;

  /// Optional custom rendering for each day cell in the header ruler.
  /// Defaults to a weekday label + day number, with today highlighted.
  final Widget Function(BuildContext context, DateTime day, double width)?
  dayHeaderBuilder;

  const HorizontalTimelineView({
    super.key,
    required this.entries,
    required this.rangeStart,
    required this.rangeEnd,
    this.pixelsPerDay = 48,
    this.laneHeight = 56,
    this.laneSpacing = 6,
    this.headerHeight = 40,
    this.dayHeaderBuilder,
  });

  @override
  State<HorizontalTimelineView> createState() => _HorizontalTimelineViewState();
}

class _HorizontalTimelineViewState extends State<HorizontalTimelineView> {
  late final LinkedScrollControllerGroup _horizontalGroup;
  late final ScrollController _headerController;
  late final ScrollController _bodyController;

  @override
  void initState() {
    super.initState();
    // Both controllers belong to the same group, so dragging either the
    // header or the entry area moves both â€” that's what makes the date
    // ruler double as a "scrolling date selector".
    _horizontalGroup = LinkedScrollControllerGroup();
    _headerController = _horizontalGroup.addAndGet();
    _bodyController = _horizontalGroup.addAndGet();
  }

  @override
  void dispose() {
    _headerController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  int _dayOffset(DateTime d) {
    final start = DateTime(
      widget.rangeStart.year,
      widget.rangeStart.month,
      widget.rangeStart.day,
    );
    final day = DateTime(d.year, d.month, d.day);
    return day.difference(start).inDays;
  }

  @override
  Widget build(BuildContext context) {
    final totalDays = widget.rangeEnd.difference(widget.rangeStart).inDays;
    final totalWidth = totalDays * widget.pixelsPerDay;

    final laneOf = assignLanes(widget.entries);
    final laneCount = laneOf.values.isEmpty
        ? 0
        : laneOf.values.reduce((a, b) => a > b ? a : b) + 1;
    final bodyHeight = laneCount * (widget.laneHeight + widget.laneSpacing);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Date ruler header ---
        SizedBox(
          height: widget.headerHeight,
          width: double.infinity,
          child: SingleChildScrollView(
            controller: _headerController,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: totalWidth,
              height: widget.headerHeight,
              child: Row(
                children: List.generate(totalDays, (i) {
                  final day = widget.rangeStart.add(Duration(days: i));
                  return SizedBox(
                    width: widget.pixelsPerDay,
                    height: widget.headerHeight,
                    child: widget.dayHeaderBuilder != null
                        ? widget.dayHeaderBuilder!(
                            context,
                            day,
                            widget.pixelsPerDay,
                          )
                        : _DefaultDayHeader(day: day),
                  );
                }),
              ),
            ),
          ),
        ),
        const Divider(height: 1, thickness: 1),
        // --- Entry area ---
        Expanded(
          child: SingleChildScrollView(
            controller: _bodyController,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: totalWidth,
              child: SingleChildScrollView(
                // Only kicks in if there are more lanes than fit vertically.
                child: SizedBox(
                  height: bodyHeight < 1 ? 1 : bodyHeight,
                  child: Stack(
                    children: [
                      _GridLines(
                        totalDays: totalDays,
                        pixelsPerDay: widget.pixelsPerDay,
                        height: bodyHeight,
                      ),
                      for (final entry in widget.entries)
                        Positioned(
                          left: _dayOffset(entry.start) * widget.pixelsPerDay,
                          width:
                              ((_dayOffset(entry.end) - _dayOffset(entry.start))
                                      .clamp(1, totalDays))
                                  .toDouble() *
                              widget.pixelsPerDay,
                          top:
                              laneOf[entry.id]! *
                              (widget.laneHeight + widget.laneSpacing),
                          height: widget.laneHeight,
                          child: Builder(
                            builder: (context) => entry.builder(
                              context,
                              ((_dayOffset(entry.end) - _dayOffset(entry.start))
                                          .clamp(1, totalDays))
                                      .toDouble() *
                                  widget.pixelsPerDay,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DefaultDayHeader extends StatelessWidget {
  final DateTime day;
  const _DefaultDayHeader({required this.day});

  @override
  Widget build(BuildContext context) {
    final isWeekend =
        day.weekday == DateTime.saturday || day.weekday == DateTime.sunday;
    final now = DateTime.now();
    final isToday =
        day.year == now.year && day.month == now.month && day.day == now.day;

    return Container(
      decoration: BoxDecoration(
        color: isToday ? Theme.of(context).colorScheme.primaryContainer : null,
        border: const Border(right: BorderSide(color: Color(0x22000000))),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _weekdayLabel(day.weekday),
            style: TextStyle(
              fontSize: 10,
              color: isWeekend ? Colors.redAccent : Colors.grey,
            ),
          ),
          Text(
            '${day.day}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  String _weekdayLabel(int weekday) =>
      const ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'][weekday - 1];
}

/// Faint vertical gridline per day, drawn once as a single CustomPaint
/// instead of N separate widgets/borders.
class _GridLines extends StatelessWidget {
  final int totalDays;
  final double pixelsPerDay;
  final double height;

  const _GridLines({
    required this.totalDays,
    required this.pixelsPerDay,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(totalDays * pixelsPerDay, height),
      painter: _GridPainter(totalDays: totalDays, pixelsPerDay: pixelsPerDay),
    );
  }
}

class _GridPainter extends CustomPainter {
  final int totalDays;
  final double pixelsPerDay;

  _GridPainter({required this.totalDays, required this.pixelsPerDay});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x11000000)
      ..strokeWidth = 1;
    for (var i = 0; i <= totalDays; i++) {
      final x = i * pixelsPerDay;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) =>
      oldDelegate.totalDays != totalDays ||
      oldDelegate.pixelsPerDay != pixelsPerDay;
}
