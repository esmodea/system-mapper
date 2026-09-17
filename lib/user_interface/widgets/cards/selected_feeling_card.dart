import 'package:flutter/material.dart';

class SelectedFeelingCard extends StatelessWidget {
  final bool shouldShowFirst;
  final bool shouldShowSecond;
  final bool shouldShowThird;
  final String firstOrderEmoji;
  final String firstOrderSelection;
  final String secondOrderEmoji;
  final String secondOrderSelection;
  final String thirdOrderEmoji;
  final String thirdOrderSelection;
  const SelectedFeelingCard({
    super.key,
    required this.shouldShowFirst,
    required this.shouldShowSecond,
    required this.shouldShowThird,
    required this.firstOrderEmoji,
    required this.firstOrderSelection,
    required this.secondOrderEmoji,
    required this.secondOrderSelection,
    required this.thirdOrderEmoji,
    required this.thirdOrderSelection,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // transform: Matrix4.translationValues(textOffset / 2, 0, 0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorScheme.of(context).primary,
          borderRadius: BorderRadius.all(Radius.circular(48)),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Selected emotion'),
            Container(
              height: 2,
              width: 100,
              color: ColorScheme.of(context).onPrimary,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (shouldShowFirst && !shouldShowSecond && !shouldShowThird)
                  RichText(
                    text: TextSpan(text: firstOrderEmoji),
                    overflow: TextOverflow.ellipsis,
                    textScaler: TextScaler.linear(1),
                  ),
                if (shouldShowFirst && !shouldShowSecond && !shouldShowThird)
                  RichText(
                    text: TextSpan(
                      text: firstOrderSelection,
                      style: TextTheme.of(context).displayMedium?.copyWith(
                        fontSize: TextTheme.of(context).headlineSmall?.fontSize,
                      ),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                if (shouldShowSecond && !shouldShowThird)
                  RichText(
                    text: TextSpan(text: secondOrderEmoji),
                    overflow: TextOverflow.ellipsis,
                    textScaler: TextScaler.linear(2),
                  ),
                if (shouldShowSecond && !shouldShowThird)
                  RichText(
                    text: TextSpan(
                      text: secondOrderSelection,
                      style: TextTheme.of(context).displayMedium?.copyWith(
                        fontSize: TextTheme.of(context).headlineLarge?.fontSize,
                      ),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                if (shouldShowThird)
                  RichText(
                    text: TextSpan(text: thirdOrderEmoji),
                    overflow: TextOverflow.ellipsis,
                    textScaler: TextScaler.linear(3),
                  ),
                if (shouldShowThird)
                  RichText(
                    text: TextSpan(
                      text: thirdOrderSelection,
                      style: TextTheme.of(context).displayMedium,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
