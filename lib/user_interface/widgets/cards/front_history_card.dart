import 'package:flutter/material.dart';
import 'package:system_mapper/data/hive_objects/front/front_entry.dart';
import 'package:system_mapper/data/hive_objects/system/member.dart';
import 'package:system_mapper/user_interface/widgets/cards/selected_feeling_card.dart';
import 'package:system_mapper/user_interface/widgets/cards/standard/member_card.dart';

class FrontHistoryCard extends StatelessWidget {
  final FrontEntry? entry;
  final double? maxWidth;
  const FrontHistoryCard({super.key, this.entry, this.maxWidth});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Duration duration =
            entry?.endTime?.difference(entry?.startTime ?? DateTime.now()) ??
            Duration(seconds: 0);
        return GestureDetector(
          onTap: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          child: Container(
            constraints: BoxConstraints(
              maxHeight: 600,
              maxWidth: maxWidth ?? constraints.maxWidth,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: ColorScheme.of(context).tertiary,
            ),
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MemberCard(
                  member: entry?.member ?? Member(),
                  showEditButton: false,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('startDate: ${entry?.startTime}'),
                        Text(
                          'endDate: ${entry?.startTime == entry?.endTime ? null : entry?.endTime}',
                        ),
                        Text(
                          'Duration: ${'${(duration.inDays / 7) >= 1 ? '${(duration.inDays / 7).roundToDouble().toInt()}w ' : ''}${duration.inDays > 0 ? '${duration.inDays % 7}d ' : ''}${duration.inHours > 0 ? '${duration.inHours % 24}h ' : ''}${duration.inMinutes > 0 && !(duration.inDays > 0) ? '${duration.inMinutes % 60}m ' : ''}${duration.inSeconds > 0 && !(duration.inHours > 0) ? '${duration.inSeconds % 60}s ' : ''}'}',
                        ),
                        Text('Was only conscious: ${entry?.isOnlyConscious}'),
                        Text('Start feeling'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SelectedFeelingCard(
                              shouldShowFirst: false,
                              shouldShowSecond: false,
                              shouldShowThird: true,
                              firstOrderEmoji: '',
                              firstOrderSelection: '',
                              secondOrderEmoji: '',
                              secondOrderSelection: '',
                              thirdOrderEmoji:
                                  entry?.startFeeling?.feeling?.emojiCode ?? '',
                              thirdOrderSelection:
                                  entry?.startFeeling?.feeling?.feelingName ??
                                  'No Emotion',
                            ),
                          ],
                        ),
                        Text('End feeling'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SelectedFeelingCard(
                              shouldShowFirst: false,
                              shouldShowSecond: false,
                              shouldShowThird: true,
                              firstOrderEmoji: '',
                              firstOrderSelection: '',
                              secondOrderEmoji: '',
                              secondOrderSelection: '',
                              thirdOrderEmoji:
                                  entry?.endFeeling?.feeling?.emojiCode ?? '',
                              thirdOrderSelection:
                                  entry?.endFeeling?.feeling?.feelingName ??
                                  'No Emotion',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
