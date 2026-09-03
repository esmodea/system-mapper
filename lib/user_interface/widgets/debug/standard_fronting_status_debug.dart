import 'package:flutter/material.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/utils/current.dart';

class StandardFrontingStatusDebug extends StatefulWidget {
  const StandardFrontingStatusDebug({super.key});

  @override
  State<StandardFrontingStatusDebug> createState() =>
      _FrontingStatusDebugState();
}

class _FrontingStatusDebugState extends State<StandardFrontingStatusDebug> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Current.standardFrontArchiveListenable,
      builder: (context, value, child) {
        return ValueListenableBuilder(
          valueListenable: Current.standardFrontListenable,
          builder: (context, value, child) {
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
                  ...Current.standardFront?.membersInFront
                          ?.map((member) => Text(member.memberName ?? ''))
                          .toList() ??
                      [],
                  Text(
                    'Current ${ModelType.frontEntry.pluralTitle}:',
                    style: TextTheme.of(context).headlineLarge,
                  ),
                  ...Current.standardFront?.activeFrontEntries
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
                  ...Current.standardFrontArchive?.archivedFrontEntries
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
