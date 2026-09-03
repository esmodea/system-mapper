import 'package:flutter/material.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/utils/current.dart';

class SingleFrontingStatusDebug extends StatefulWidget {
  const SingleFrontingStatusDebug({super.key});

  @override
  State<SingleFrontingStatusDebug> createState() => _FrontingStatusDebugState();
}

class _FrontingStatusDebugState extends State<SingleFrontingStatusDebug> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Current.singleFrontArchiveListenable,
      builder: (context, value, child) {
        return ValueListenableBuilder(
          valueListenable: Current.singleFrontListenable,
          builder: (context, value, child) {
            debugPrint(
              'archivedConsciousnessEntries: ${Current.singleFrontArchive?.archivedConsciousnessEntries}',
            );
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Debug Info:',
                    style: TextTheme.of(context).displayLarge,
                  ),
                  Text(
                    'Current Fronters:',
                    style: TextTheme.of(context).headlineLarge,
                  ),
                  ...Current.singleFront?.membersInFront
                          ?.map((member) => Text(member.memberName ?? ''))
                          .toList() ??
                      [],
                  Text(
                    'Current Conscious:',
                    style: TextTheme.of(context).headlineLarge,
                  ),
                  ...Current.singleFront?.membersConscious
                          ?.map((member) => Text(member.memberName ?? ''))
                          .toList() ??
                      [],
                  Text(
                    'Current ${ModelType.frontEntry.pluralTitle}:',
                    style: TextTheme.of(context).headlineLarge,
                  ),
                  ...Current.singleFront?.activeFrontEntries
                          ?.map(
                            (frontEntry) => Wrap(
                              children: [
                                Text(frontEntry.member?.memberName ?? ''),
                                Text(frontEntry.startTime.toString()),
                                if (frontEntry.endTime != null)
                                  Text(frontEntry.endTime.toString()),
                                Text(frontEntry.frontEntryUUID.toString()),
                                Text(frontEntry.memberUUID.toString()),
                              ],
                            ),
                          )
                          .toList() ??
                      [],

                  Text(
                    'Current Conscious Entries:',
                    style: TextTheme.of(context).headlineLarge,
                  ),
                  ...Current.singleFront?.activeConsciousnessEntries
                          ?.map(
                            (frontEntry) => Wrap(
                              children: [
                                Text(frontEntry.member?.memberName ?? ''),
                                Text(frontEntry.startTime.toString()),
                                if (frontEntry.endTime != null)
                                  Text(frontEntry.endTime.toString()),
                                Text(frontEntry.frontEntryUUID.toString()),
                                Text(frontEntry.memberUUID.toString()),
                              ],
                            ),
                          )
                          .toList() ??
                      [],
                  Text(
                    'Current ${ModelType.standardFrontArchive.pluralTitle}:',
                    style: TextTheme.of(context).headlineLarge,
                  ),
                  ...Current.singleFrontArchive?.archivedFrontEntries
                          ?.map(
                            (frontEntry) => Wrap(
                              children: [
                                Text(frontEntry.member?.memberName ?? ''),
                                Text(frontEntry.startTime.toString()),
                                if (frontEntry.endTime != null)
                                  Text(frontEntry.endTime.toString()),
                                Text(frontEntry.frontEntryUUID.toString()),
                                Text(frontEntry.memberUUID.toString()),
                              ],
                            ),
                          )
                          .toList()
                          .reversed ??
                      [],
                  Text(
                    'Current Conscious Archives:',
                    style: TextTheme.of(context).headlineLarge,
                  ),
                  ...Current.singleFrontArchive?.archivedConsciousnessEntries
                          ?.map(
                            (frontEntry) => Wrap(
                              children: [
                                Text(frontEntry.member?.memberName ?? ''),
                                Text(frontEntry.startTime.toString()),
                                if (frontEntry.endTime != null)
                                  Text(frontEntry.endTime.toString()),
                                Text(frontEntry.frontEntryUUID.toString()),
                                Text(frontEntry.memberUUID.toString()),
                              ],
                            ),
                          )
                          .toList()
                          .reversed ??
                      [],
                ],
              ),
            );
          },
        );
      },
    );
  }
}
