import 'package:flutter/material.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:system_mapper/data/hive_objects/feelings/feeling.dart';

class FeelingsSelectorButton extends PieAction {
  FeelingsSelectorButton({
    super.buttonTheme,
    super.buttonThemeHovered,
    super.semanticsLabel,
    required super.child,
    required super.onSelect,
    required super.tooltip,
  });

  static PieAction feelingsSelectorButton(
    Feeling feeling,
    double textOffset,
    void Function(Feeling feeling) selectorMethod,
  ) {
    return PieAction.builder(
      buttonTheme: PieButtonTheme(
        backgroundColor: Colors.transparent,
        iconColor: Colors.transparent,
      ),
      buttonThemeHovered: PieButtonTheme(
        backgroundColor: Colors.transparent,
        iconColor: Colors.transparent,
      ),
      tooltip: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [SizedBox(width: 120), Text(feeling.feelingName ?? '')],
      ),
      onSelect: () {
        selectorMethod(feeling);
      },
      builder: (hovered) {
        return SizedBox(
          width: 100,
          height: 100,
          child: Center(
            child: RichText(
              text: TextSpan(
                text: feeling.emojiCode ?? feeling.feelingName ?? '',
              ),
              textScaler: TextScaler.linear(3),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
  }

  static PieAction feelingsSelectorButtonMobile(
    Feeling feeling,
    double textOffset,
    void Function(Feeling feeling) selectorMethod,
  ) {
    return PieAction.builder(
      buttonTheme: PieButtonTheme(
        backgroundColor: Colors.transparent,
        iconColor: Colors.transparent,
      ),
      buttonThemeHovered: PieButtonTheme(
        backgroundColor: Colors.transparent,
        iconColor: Colors.transparent,
      ),
      tooltip: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(feeling.feelingName ?? '')],
      ),
      onSelect: () {
        selectorMethod(feeling);
      },
      builder: (hovered) {
        return SizedBox(
          width: 100,
          height: 100,
          child: Center(
            child: RichText(
              text: TextSpan(
                text: feeling.emojiCode ?? feeling.feelingName ?? '',
              ),
              textScaler: TextScaler.linear(3),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
  }
}
