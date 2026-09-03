import 'package:flutter/material.dart';

class WelcomeSplash extends StatelessWidget {
  final VoidCallback callback;
  const WelcomeSplash({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorScheme.of(context).primaryContainer,
      child: Column(
        children: [
          Expanded(
            child: Scaffold(
              body: Center(
                child: Text(
                  'Welcome!',
                  style: TextTheme.of(context).headlineLarge,
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  callback();
                },
                // backgroundColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text('→'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
