import 'package:flutter/material.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/utils/current.dart';

class FrontingStatusDebug extends StatefulWidget {
  const FrontingStatusDebug({super.key});

  @override
  State<FrontingStatusDebug> createState() => _FrontingStatusDebugState();
}

class _FrontingStatusDebugState extends State<FrontingStatusDebug> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Current.frontArchiveListenable,
      builder: (context, value, child) {
        return ValueListenableBuilder(
          valueListenable: Current.frontListenable,
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
                  ...Current.front?.membersInFront
                          ?.map((member) => Text(member.memberName ?? ''))
                          .toList() ??
                      [],
                  Text(
                    'Current ${ModelType.frontEntry.pluralTitle}:',
                    style: TextTheme.of(context).headlineLarge,
                  ),
                  ...Current.front?.activeFrontEntries
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
                    'Current ${ModelType.frontArchive.pluralTitle}:',
                    style: TextTheme.of(context).headlineLarge,
                  ),
                  ...Current.frontArchive?.archivedFrontEntries
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
