import 'package:flutter/material.dart';

/// Defines font size of the button.
enum ButtonFontSize { small, medium, large }

/// Defines available color schemes.
enum ButtonColor { primary, secondary, tertiary, error }

/// A general button class for creating buttons with text inside.
///
/// It has a [ButtonColor] class and a [ButtonFontSize] class. It also gets
/// its state from [SystemTextButtonState].
class SystemTextButton extends StatefulWidget {
  final BuildContext? context;
  final String text;
  final GestureTapCallback onPressed;
  final Icon? icon;
  final bool? disabled;
  final ButtonColor color;
  final ButtonFontSize fontSize;
  final bool isExpanded;
  final Axis expansionAxis;

  const SystemTextButton({
    super.key,
    this.context,
    required this.text,
    required this.onPressed,
    this.icon,
    this.disabled = false,
    this.color = ButtonColor.primary,
    this.fontSize = ButtonFontSize.medium,
    this.isExpanded = false,
    this.expansionAxis = Axis.vertical,
  });

  @override
  SystemTextButtonState createState() => SystemTextButtonState();
}

class SystemTextButtonState extends State<SystemTextButton> {
  BuildContext get _context => widget.context ?? context;

  @override
  Widget build(BuildContext context) {
    // Takes the theme from the button's context.
    ThemeData theme = Theme.of(_context);
    ColorScheme colorScheme = theme.colorScheme;
    ButtonStyle buttonStyle =
        theme.textButtonTheme.style ?? const ButtonStyle();
    Color backgroundColor;
    Color foregroundColor;
    Color borderColor;

    // A switch case which uses the [SystemTextButton.color] to allow the button to change visually with state.
    switch (widget.color) {
      case ButtonColor.primary:
        backgroundColor = colorScheme.primary;
        foregroundColor = colorScheme.onPrimary;
        borderColor = colorScheme.onSecondary;
        break;
      case ButtonColor.secondary:
        backgroundColor = colorScheme.secondary;
        foregroundColor = colorScheme.onSecondary;
        borderColor = colorScheme.outline;
        break;
      case ButtonColor.tertiary:
        backgroundColor = colorScheme.onPrimary;
        foregroundColor = colorScheme.secondary;
        borderColor = colorScheme.secondary;
        break;
      case ButtonColor.error:
        backgroundColor = colorScheme.error;
        foregroundColor = colorScheme.onError;
        borderColor = colorScheme.onError;
        break;
    }

    // This makes sure it only displays when [SystemTextButton.disabled] isn't true.
    if (widget.disabled != null && widget.disabled!) {
      backgroundColor =
          buttonStyle.backgroundColor?.resolve({WidgetState.disabled}) ??
          backgroundColor;
      foregroundColor =
          buttonStyle.foregroundColor?.resolve({WidgetState.disabled}) ??
          foregroundColor;
      borderColor = buttonStyle.side?.resolve({})?.color ?? borderColor;
    }

    // A switch case which uses [SystemTextButton.fontSize].
    double fontSize;
    switch (widget.fontSize) {
      case ButtonFontSize.small:
        fontSize = 12.0;
        break;
      case ButtonFontSize.medium:
        fontSize = 18.0;
        break;
      case ButtonFontSize.large:
        fontSize = 38.0;
        break;
    }

    // Defines the style of the button using the above defined variables.
    ButtonStyle style = buttonStyle.copyWith(
      backgroundColor: WidgetStateProperty.all(backgroundColor),
      foregroundColor: WidgetStateProperty.all(foregroundColor),
      side: WidgetStateProperty.all(BorderSide(color: borderColor, width: 2)),
      textStyle: WidgetStateProperty.resolveWith<TextStyle>((
        Set<WidgetState> states,
      ) {
        TextStyle? themeTextStyle = buttonStyle.textStyle != null
            ? buttonStyle.textStyle!.resolve({})
            : const TextStyle();
        return themeTextStyle!.copyWith(
          color: foregroundColor,
          fontSize: fontSize,
        );
      }),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(12)),
        ),
      ),
      padding: WidgetStatePropertyAll(EdgeInsets.all(16)),
    );

    // This builds the button with an icon if available.
    Widget button = widget.icon != null
        ? TextButton.icon(
            onPressed: widget.disabled ?? false ? null : widget.onPressed,
            style: style,
            icon: widget.icon!,
            label: Text(widget.text, textAlign: TextAlign.center),
          )
        : TextButton(
            onPressed: widget.disabled ?? false ? null : widget.onPressed,
            style: style,
            child: Text(widget.text, textAlign: TextAlign.center),
          );

    // This allows the button to fill its container when necessary.
    return widget.isExpanded
        ? Flex(
            direction: Axis.horizontal,
            children: [Expanded(child: button)],
          )
        : button;
  }
}
