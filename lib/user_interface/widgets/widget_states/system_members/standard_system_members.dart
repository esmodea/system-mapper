import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:system_mapper/user_interface/widgets/cards/standard/member_card.dart';
import 'package:system_mapper/utils/current.dart';

class StandardSystemMembers extends StatefulWidget {
  final bool isBlank;
  const StandardSystemMembers({super.key, this.isBlank = false});

  @override
  State<StandardSystemMembers> createState() => _StandardSystemMembersState();
}

class _StandardSystemMembersState extends State<StandardSystemMembers> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Current.standardFrontListenable,
      builder: (context, value, child) {
        return ValueListenableBuilder(
          valueListenable: Current.systemListenable,
          builder: (context, value, child) {
            if (widget.isBlank) {
              return Shimmer(
                duration: Duration(seconds: 1),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: ColorScheme.of(context).primary,
                      ),
                      constraints: BoxConstraints(maxHeight: 600),
                      child: Center(
                        child: Column(
                          children: [Expanded(child: Stack(children: [
                                ],
                              ))],
                        ),
                      ),
                    ),
                    IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          // color: ColorScheme.of(context).primary,
                          gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            transform: GradientRotation(-0.1),
                            colors: [
                              ColorScheme.of(context).primary.withAlpha(0),
                              ColorScheme.of(context).primary.withAlpha(0),
                              ColorScheme.of(context).primary.withAlpha(0),
                              ColorScheme.of(context).primary.withAlpha(0),
                              ColorScheme.of(context).primary.withAlpha(0),
                              ColorScheme.of(context).primary,
                              ColorScheme.of(context).primary,
                            ],
                          ),
                        ),
                        constraints: BoxConstraints(maxHeight: 600),
                        child: Column(
                          children: [
                            Expanded(
                              child: SizedBox.expand(
                                child: Row(
                                  children: [
                                    Expanded(child: SizedBox.expand()),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: ColorScheme.of(context).primary,
                  ),
                  constraints: BoxConstraints(maxHeight: 600),
                  child: Center(
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    spacing: 10,
                                    children: [
                                      ...Current.system?.membersList
                                              ?.map(
                                                (member) => MemberCard(
                                                  member: member,
                                                  showFrontTime: true,
                                                ),
                                              )
                                              .toList() ??
                                          [],
                                      Opacity(opacity: 0, child: MemberCard()),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 10,
                                right: 10,
                                bottom: 10,
                                child: MemberCard(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      // color: ColorScheme.of(context).primary,
                      gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        transform: GradientRotation(-0.1),
                        colors: [
                          ColorScheme.of(context).primary.withAlpha(0),
                          ColorScheme.of(context).primary.withAlpha(0),
                          ColorScheme.of(context).primary.withAlpha(0),
                          ColorScheme.of(context).primary.withAlpha(0),
                          ColorScheme.of(context).primary.withAlpha(0),
                          ColorScheme.of(context).primary,
                          ColorScheme.of(context).primary,
                        ],
                      ),
                    ),
                    constraints: BoxConstraints(maxHeight: 600),
                    child: Column(
                      children: [
                        Expanded(
                          child: SizedBox.expand(
                            child: Row(
                              children: [Expanded(child: SizedBox.expand())],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  right: 10,
                  bottom: 10,
                  child: MemberCard(),
                ),
              ],
            );
          },
        );
      },
    );
  }
}