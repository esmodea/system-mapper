import 'package:flutter/material.dart';

class WelcomeSplash extends StatelessWidget {
  final VoidCallback callback;
  const WelcomeSplash({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: callback, child: Text('Welcome!'));
  }
}
