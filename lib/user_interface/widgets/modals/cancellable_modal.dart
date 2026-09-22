import 'package:flutter/material.dart';
import 'package:system_mapper/user_interface/widgets/system_text_button.dart';

void defaultCallback() {}

class CancellableModal extends StatelessWidget {
  final String confirmButtonText;
  final String cancelButtonText;
  final VoidCallback completionCallback;
  final Size preferredSize;
  final Widget returnWidget;
  final Widget child;
  const CancellableModal({
    super.key,
    this.confirmButtonText = 'Sure',
    this.cancelButtonText = 'Cancel',
    this.completionCallback = defaultCallback,
    this.preferredSize = const Size(600, 400),
    this.returnWidget = const SizedBox.shrink(),
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) {
          return Center(
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
                borderRadius: BorderRadius.all(Radius.circular(38)),
                color: ColorScheme.of(context).primary,
              ),
              width: preferredSize.width,
              height: preferredSize.height,
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  child,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: 150,
                            child: SystemTextButton(
                              text: cancelButtonText,
                              onPressed: () {
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
                      Column(
                        children: [
                          SizedBox(
                            width: 140,
                            child: SystemTextButton(
                              text: confirmButtonText,
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
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
    return returnWidget;
  }
}
