import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:system_mapper/data/hive_objects/system/system.dart';
import 'package:system_mapper/data/hive_objects/system/system_front_type.dart';
import 'package:system_mapper/user_interface/widgets/cards/single_front/member_card.dart'
    as mem_card_single;
import 'package:system_mapper/user_interface/widgets/cards/standard/member_card.dart'
    as mem_card_standard;
import 'package:system_mapper/utils/current.dart';

class SystemMembers extends StatelessWidget {
  final bool isBlank;
  final Box<System> box;
  const SystemMembers({super.key, this.isBlank = false, required this.box});

  @override
  Widget build(BuildContext context) {
    if (isBlank) {
      return Shimmer(
        duration: Duration(seconds: 1),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: ColorScheme.of(context).primary,
              ),
              child: Center(
                child: Column(children: [Stack(children: [
                                ],
                              )]),
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
                child: Column(children: [Row(children: [
                                
                              ],
                            )]),
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
          child: Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          spacing: 10,
                          children: [
                            if (box.values.isNotEmpty)
                              ...box.values.first.membersList
                                      ?.map(
                                        (member) => switch (Current
                                            .system
                                            ?.frontType) {
                                          SystemFrontType.trackSingleFront =>
                                            mem_card_single.MemberCard(
                                              member: member,
                                              showFrontTime: true,
                                            ),
                                          _ => mem_card_standard.MemberCard(
                                            member: member,
                                            showFrontTime: true,
                                          ),
                                        },
                                      )
                                      .toList() ??
                                  [],
                            Opacity(
                              opacity: 0,
                              child: mem_card_standard.MemberCard(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      right: 10,
                      bottom: 10,
                      child: mem_card_standard.MemberCard(),
                    ),
                  ],
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
            child: Column(children: [Row(children: [])]),
          ),
        ),
        Positioned(
          left: 10,
          right: 10,
          bottom: 10,
          child: mem_card_standard.MemberCard(),
        ),
      ],
    );
  }
}
