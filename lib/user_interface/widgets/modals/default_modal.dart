import 'package:flutter/material.dart';
import 'package:system_mapper/user_interface/widgets/system_text_button.dart';

void defaultCallback() {}

class DefaultModal extends StatelessWidget {
  final String buttonText;
  final VoidCallback completionCallback;
  final Size preferredSize;
  final Widget child;
  const DefaultModal({
    super.key,
    this.buttonText = '',
    this.completionCallback = defaultCallback,
    this.preferredSize = const Size(600, 400),
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('default modal rendered...');
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: ColorScheme.of(context).shadow,
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: Offset(15, 15),
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(24)),
              color: ColorScheme.of(context).primary,
            ),
            width: preferredSize.width,
            height: preferredSize.height,
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                child,
                SizedBox(
                  width: 300,
                  child: SystemTextButton(
                    text: buttonText,
                    onPressed: () {
                      completionCallback();
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    fontSize: ButtonFontSize.large,
                    isExpanded: true,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    return SizedBox.shrink();
  }
}
