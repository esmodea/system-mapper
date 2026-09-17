import 'package:flutter/material.dart';
import 'package:system_mapper/utils/current.dart';

class GraphView extends StatefulWidget {
  const GraphView({super.key});

  @override
  State<GraphView> createState() => _GraphViewState();
}

class _GraphViewState extends State<GraphView> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Current.standardFrontArchiveListenable,
      builder: (context, value, child) {
        return ValueListenableBuilder(
          valueListenable: Current.singleFrontArchiveListenable,
          builder: (context, systemBox, child) {
            return FutureBuilder(
              future: Future.delayed(Duration(seconds: 1)),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState.name == 'done') {
                  return LayoutBuilder(
                    builder: ((context, constraints) {
                      return Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: (constraints.maxWidth / 10) * 6,
                              maxHeight: (constraints.maxHeight),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 24, left: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [],
                              ),
                            ),
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: ((constraints.maxWidth / 10) * 4) - 20,
                              maxHeight: (constraints.maxHeight),
                            ),
                            child: SingleChildScrollView(
                              child: Column(children: [
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  );
                } else {
                  return LayoutBuilder(
                    builder: ((context, constraints) {
                      return Wrap(
                        spacing: 20,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: (constraints.maxWidth / 10) * 6,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 24,
                                left: 24,
                                right: 24,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [],
                              ),
                            ),
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: ((constraints.maxWidth / 10) * 4) - 20,
                            ),
                            child: SingleChildScrollView(
                              child: Column(children: [
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}
