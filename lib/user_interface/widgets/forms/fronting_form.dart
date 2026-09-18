import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:system_mapper/data/hive_objects/feelings/feeling.dart';
import 'package:system_mapper/data/hive_objects/feelings/feeling_entry.dart';
import 'package:system_mapper/data/hive_objects/front/front_entry.dart';
import 'package:system_mapper/data/hive_objects/system/member.dart';
import 'package:system_mapper/data/hive_objects/system/system.dart';
import 'package:system_mapper/data/hive_objects/system/system_front_type.dart';
import 'package:system_mapper/user_interface/widgets/cards/selected_feeling_card.dart';
import 'package:system_mapper/user_interface/widgets/cards/standard/member_card.dart';
import 'package:system_mapper/user_interface/widgets/inputs/feelings_wheel.dart';
import 'package:system_mapper/user_interface/widgets/modals/default_modal.dart';
import 'package:system_mapper/user_interface/widgets/system_text_button.dart';
import 'package:system_mapper/utils/current.dart';
import 'package:system_mapper/utils/safe_set_state.dart';
import 'package:uuid/uuid.dart';

enum FrontingFormType {
  addToFront,
  finalizeFront,
  editFrontEntry,
  createFrontEntry,
}

class FrontingFormData {
  final DateTime startTime;
  final DateTime? endTime;
  final FeelingEntry? startFeeling;
  final FeelingEntry? endFeeling;
  final Member member;
  final String? frontEntryUUID;
  final bool isOnlyConscious;

  const FrontingFormData({
    required this.startTime,
    this.frontEntryUUID,
    this.endTime,
    this.startFeeling,
    this.endFeeling,
    required this.member,
    required this.isOnlyConscious,
  });
}

class FrontingForm extends StatefulWidget {
  final FrontingFormData initialFormData;
  final System system;
  final FrontingFormType type;
  final void Function(FrontEntry entry) addToFrontCallback;
  final void Function(FrontEntry entry) createFrontEntryCallback;
  final void Function(FrontEntry entry) editFrontEntryCallback;
  const FrontingForm({
    super.key,
    required this.initialFormData,
    required this.system,
    this.type = FrontingFormType.addToFront,
    this.addToFrontCallback = defaultCallback,
    this.createFrontEntryCallback = defaultCallback,
    this.editFrontEntryCallback = defaultCallback,
  });

  @override
  State<FrontingForm> createState() => _FrontingFormState();
}

class _FrontingFormState extends SafeState<FrontingForm> {
  final _formKey = GlobalKey<FormState>();

  DateTime startDateTime = DateTime.now();

  DateTime startDateTimeCreate = DateTime.now();
  DateTime endDateTimeCreate = DateTime.now();

  FeelingEntry? feelingEntry;
  late FrontEntry frontEntry = FrontEntry(
    frontEntryUUID: widget.type == FrontingFormType.addToFront
        ? Uuid().v6()
        : widget.initialFormData.frontEntryUUID,
    startTime: widget.initialFormData.startTime,
    endTime: widget.type == FrontingFormType.finalizeFront
        ? DateTime.now()
        : null,
    startFeeling: widget.initialFormData.startFeeling,
    member: widget.initialFormData.member,
  );

  late DateTime startDateTimeEdit = widget.initialFormData.startTime;
  late DateTime endDateTimeEdit =
      widget.initialFormData.endTime ?? widget.initialFormData.startTime;

  late FrontingFormData data = widget.initialFormData;

  bool validateForm() {
    bool formIsValid = false;
    if (frontEntry.member?.memberBio != null) {
      formIsValid = true;
    }

    if (frontEntry.startTime == frontEntry.endTime) {
      formIsValid = false;
    }
    return formIsValid;
  }

  void addToFront() {
    widget.addToFrontCallback(frontEntry);
  }

  void createFrontEntry() {
    widget.createFrontEntryCallback(frontEntry);
  }

  void editFrontEntry() {
    widget.editFrontEntryCallback(frontEntry);
  }

  void pickDateTime() async {
    DateTime startTime = widget.type != FrontingFormType.editFrontEntry
        ? DateTime.now()
        : startDateTimeEdit;
    DateTime endTime = widget.type != FrontingFormType.editFrontEntry
        ? DateTime.now()
        : endDateTimeEdit;
    if (widget.type == FrontingFormType.finalizeFront) {
      startTime = startDateTimeEdit;
    }
    switch (widget.type) {
      case (FrontingFormType.addToFront):
        startTime =
            await showOmniDateTimePicker(
              context: context,
              constraints: BoxConstraints(maxWidth: 600),
            ) ??
            startTime;
        frontEntry.startTime = startTime;
        safeSetState(() {
          startDateTime = startTime;
          frontEntry;
        });
        break;
      case (FrontingFormType.finalizeFront):
        [startTime, endTime] =
            await showOmniDateTimeRangePicker(
              context: context,
              constraints: BoxConstraints(maxWidth: 600),
            ) ??
            [startTime, endTime];
        frontEntry.startTime = startTime;
        frontEntry.endTime = endTime;
        safeSetState(() {
          startDateTimeCreate = startTime;
          endDateTimeCreate = endTime;
          frontEntry;
        });
        break;
      case (FrontingFormType.createFrontEntry):
        [startTime, endTime] =
            await showOmniDateTimeRangePicker(
              context: context,
              constraints: BoxConstraints(maxWidth: 600),
            ) ??
            [startTime, endTime];
        frontEntry.startTime = startTime;
        frontEntry.endTime = endTime;
        safeSetState(() {
          startDateTimeCreate = startTime;
          endDateTimeCreate = endTime;
          frontEntry;
        });
        break;
      case (FrontingFormType.editFrontEntry):
        [startTime, endTime] =
            await showOmniDateTimeRangePicker(
              context: context,
              constraints: BoxConstraints(maxWidth: 600),
            ) ??
            [startTime, endTime];
        frontEntry.startTime = startTime;
        frontEntry.endTime = endTime;
        safeSetState(() {
          startDateTimeEdit = startTime;
          endDateTimeEdit = endTime;
          frontEntry;
        });
        break;
    }
  }

  void pickStartFeeling() {
    DefaultModal(
      buttonText: 'Cancel',
      preferredSize: Size(648, 552),
      child: FeelingsSelector(
        feelingString: switch (widget.type) {
          FrontingFormType.addToFront => 'How do you feel?',
          FrontingFormType.finalizeFront => 'How do you feel?',
          FrontingFormType.createFrontEntry =>
            'How did the alter feel at the start?',
          FrontingFormType.editFrontEntry =>
            'How did the alter feel at the start?',
        },
        callback: (info) {
          Feeling? feeling =
              Feeling.getFeeling(info.thirdOrderSelection) ??
              Feeling.getFeeling(info.secondOrderSelection) ??
              Feeling.getFeeling(info.firstOrderSelection);

          FeelingEntry? newFeelingEntry = feeling != null
              ? FeelingEntry(feeling: feeling)
              : null;
          safeSetState(() {
            feelingEntry = newFeelingEntry;
            frontEntry = FrontEntry(
              startTime: frontEntry.startTime,
              endTime: frontEntry.endTime,
              member: frontEntry.member,
              frontEntryUUID: frontEntry.frontEntryUUID,
              memberUUID: frontEntry.memberUUID,
              isOnlyConscious: frontEntry.isOnlyConscious,
              startFeeling: feelingEntry,
              endFeeling: frontEntry.endFeeling,
            );
            data = FrontingFormData(
              startTime: data.startTime,
              endTime: data.endTime,
              startFeeling: feelingEntry,
              endFeeling: data.endFeeling,
              member: data.member,
              isOnlyConscious: data.isOnlyConscious,
            );
          });
        },
      ),
    ).build(context);
  }

  void pickEndFeeling() {
    DefaultModal(
      buttonText: 'Cancel',
      preferredSize: Size(648, 552),
      child: FeelingsSelector(
        feelingString: switch (widget.type) {
          FrontingFormType.addToFront => 'How do you feel?',
          FrontingFormType.finalizeFront => 'How do you feel?',
          FrontingFormType.createFrontEntry =>
            'How did the alter feel at the end?',
          FrontingFormType.editFrontEntry =>
            'How did the alter feel at the end?',
        },
        callback: (info) {
          Feeling? feeling =
              Feeling.getFeeling(info.thirdOrderSelection) ??
              Feeling.getFeeling(info.secondOrderSelection) ??
              Feeling.getFeeling(info.firstOrderSelection);

          debugPrint(feeling?.toString());

          FeelingEntry newFeelingEntry = FeelingEntry(feeling: feeling);
          safeSetState(() {
            feelingEntry = newFeelingEntry;
            frontEntry = FrontEntry(
              startTime: frontEntry.startTime,
              endTime: frontEntry.endTime,
              member: frontEntry.member,
              frontEntryUUID: frontEntry.frontEntryUUID,
              memberUUID: frontEntry.memberUUID,
              isOnlyConscious: frontEntry.isOnlyConscious,
              startFeeling: frontEntry.startFeeling,
              endFeeling: feelingEntry,
            );
            data = FrontingFormData(
              startTime: data.startTime,
              endTime: data.endTime,
              startFeeling: data.startFeeling,
              endFeeling: feelingEntry,
              member: data.member,
              isOnlyConscious: data.isOnlyConscious,
            );
          });
        },
      ),
    ).build(context);
  }

  void pickBothFeelings() {}

  @override
  Widget build(BuildContext context) {
    MainAxisAlignment timeRowAxisAlignment = MainAxisAlignment.spaceAround;

    return Container(
      padding: const EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 600,
          maxHeight: ((MediaQuery.heightOf(context) / 4) * 3) + 8,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if ((Current.system?.membersList?.isNotEmpty ?? false) &&
                        widget.type != FrontingFormType.finalizeFront)
                      SystemTextButton(
                        text: 'Select a member',
                        onPressed: () {
                          WidgetsFlutterBinding.ensureInitialized()
                              .addPostFrameCallback((_) {
                                DefaultModal(
                                  buttonText: 'Cancel',
                                  child: Column(
                                    children: [
                                      ...Current.system?.membersList?.map((
                                            member,
                                          ) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        left: 8.0,
                                                      ),
                                                  child: Text(
                                                    member.memberName ?? '',
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        right: 8.0,
                                                      ),
                                                  child: FloatingActionButton(
                                                    onPressed: () {
                                                      frontEntry.member =
                                                          member;
                                                      safeSetState(() {
                                                        frontEntry = frontEntry;
                                                      });
                                                      if (Navigator.canPop(
                                                        context,
                                                      )) {
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    child: Icon(Icons.add),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }) ??
                                          [],
                                    ],
                                  ),
                                ).build(context);
                              });
                        },
                      ),
                    MemberCard(
                      member: frontEntry.member,
                      hideBio: true,
                      showEditButton: false,
                    ),
                    SizedBox(height: 40),
                    switch (widget.type) {
                      FrontingFormType.addToFront => SystemTextButton(
                        text: 'Change front start time',
                        onPressed: pickDateTime,
                      ),
                      FrontingFormType.finalizeFront => SystemTextButton(
                        text: 'Change front end time',
                        onPressed: pickDateTime,
                      ),
                      FrontingFormType.createFrontEntry => SystemTextButton(
                        text: 'Select front times',
                        onPressed: pickDateTime,
                      ),
                      FrontingFormType.editFrontEntry => SystemTextButton(
                        text: 'Select front times',
                        onPressed: pickDateTime,
                      ),
                    },
                    SizedBox(height: 40),
                    ...switch (widget.type) {
                      FrontingFormType.addToFront => [
                        SystemTextButton(
                          text: 'Pick a feeling',
                          onPressed: pickStartFeeling,
                        ),
                      ],
                      FrontingFormType.finalizeFront => [
                        SystemTextButton(
                          text: 'Pick a feeling',
                          onPressed: pickEndFeeling,
                        ),
                      ],
                      FrontingFormType.createFrontEntry => [
                        SystemTextButton(
                          text: 'Pick a start feeling',
                          onPressed: pickStartFeeling,
                        ),
                        SizedBox(height: 40),
                        SystemTextButton(
                          text: 'Pick an end feeling',
                          onPressed: pickEndFeeling,
                        ),
                      ],
                      FrontingFormType.editFrontEntry => [
                        SystemTextButton(
                          text: 'Pick a start feeling',
                          onPressed: pickStartFeeling,
                        ),
                        SizedBox(height: 40),
                        SystemTextButton(
                          text: 'Pick an end feeling',
                          onPressed: pickEndFeeling,
                        ),
                      ],
                    },
                    if (frontEntry.startFeeling != null &&
                        widget.type != FrontingFormType.finalizeFront)
                      SelectedFeelingCard(
                        shouldShowFirst: false,
                        shouldShowSecond: false,
                        shouldShowThird: frontEntry.startFeeling != null,
                        firstOrderEmoji: '',
                        firstOrderSelection: '',
                        secondOrderEmoji: '',
                        secondOrderSelection: '',
                        thirdOrderEmoji:
                            frontEntry.startFeeling?.feeling?.emojiCode ?? '',
                        thirdOrderSelection:
                            frontEntry.startFeeling?.feeling?.feelingName ?? '',
                      ),
                    if (frontEntry.endFeeling != null)
                      SelectedFeelingCard(
                        shouldShowFirst: false,
                        shouldShowSecond: false,
                        shouldShowThird: frontEntry.endFeeling != null,
                        firstOrderEmoji: '',
                        firstOrderSelection: '',
                        secondOrderEmoji: '',
                        secondOrderSelection: '',
                        thirdOrderEmoji:
                            frontEntry.endFeeling?.feeling?.emojiCode ?? '',
                        thirdOrderSelection:
                            frontEntry.endFeeling?.feeling?.feelingName ?? '',
                      ),
                    SizedBox(height: 40),
                    Opacity(
                      opacity: validateForm() ? 1 : 0.4,
                      child: switch (widget.type) {
                        FrontingFormType.addToFront => Row(
                          mainAxisAlignment: timeRowAxisAlignment,
                          children: [
                            switch (widget.system.frontType) {
                              SystemFrontType.trackSingleFront =>
                                SystemTextButton(
                                  text: 'Add to front',
                                  disabled: !validateForm(),
                                  onPressed: () {
                                    debugPrint(
                                      'isOnlyConscious: ${widget.initialFormData.isOnlyConscious}',
                                    );
                                    if (!widget
                                        .initialFormData
                                        .isOnlyConscious) {
                                      frontEntry.addToSingleFront();
                                    } else {
                                      frontEntry.addToConsciousness();
                                    }
                                    if (Navigator.canPop(context)) {
                                      Navigator.pop(context);
                                    }
                                  },
                                ),
                              _ => SystemTextButton(
                                text: 'Add to front',
                                disabled: !validateForm(),
                                onPressed: () {
                                  if (widget
                                          .system
                                          .standardFront
                                          ?.activeFrontEntries
                                          ?.where(
                                            (entry) =>
                                                entry.frontEntryUUID ==
                                                frontEntry.frontEntryUUID,
                                          )
                                          .isEmpty ??
                                      false ||
                                          (widget
                                                  .system
                                                  .standardFront
                                                  ?.activeFrontEntries
                                                  ?.where(
                                                    (entry) =>
                                                        entry.frontEntryUUID ==
                                                        frontEntry
                                                            .frontEntryUUID,
                                                  )
                                                  .isNotEmpty ??
                                              true)) {
                                    frontEntry.addToStandardFront();
                                  } else {}
                                  if (Navigator.canPop(context)) {
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            },
                          ],
                        ),
                        FrontingFormType.finalizeFront => Row(
                          mainAxisAlignment: timeRowAxisAlignment,
                          children: [
                            switch (SystemFrontType.parse(
                              Current.system?.frontType.toString() ?? '',
                            )) {
                              SystemFrontType.trackSingleFront =>
                                SystemTextButton(
                                  text: 'Remove from front',
                                  disabled: !validateForm(),
                                  onPressed: () {
                                    debugPrint(
                                      (!widget.initialFormData.isOnlyConscious)
                                          .toString(),
                                    );
                                    if (frontEntry.isOnlyConscious ??
                                        widget
                                            .initialFormData
                                            .isOnlyConscious) {
                                      frontEntry.removeFromConsciousness();
                                    }
                                    frontEntry.removeFromSingleFront();
                                    if (Navigator.canPop(context)) {
                                      Navigator.pop(context);
                                    }
                                  },
                                ),
                              _ => SystemTextButton(
                                text: 'Remove from front',
                                disabled: !validateForm(),
                                onPressed: () {
                                  frontEntry.removeFromStandardFront();
                                  // if (Navigator.canPop(context)) {
                                  //   Navigator.pop(context);
                                  // }
                                },
                              ),
                            },
                          ],
                        ),
                        FrontingFormType.createFrontEntry => Row(
                          mainAxisAlignment: timeRowAxisAlignment,
                          children: [
                            SystemTextButton(
                              text: 'Select front times',
                              disabled: !validateForm(),
                              onPressed: pickDateTime,
                            ),
                          ],
                        ),
                        FrontingFormType.editFrontEntry => Row(
                          mainAxisAlignment: timeRowAxisAlignment,
                          children: [
                            SystemTextButton(
                              text: 'Select front times',
                              disabled: !validateForm(),
                              onPressed: pickDateTime,
                            ),
                          ],
                        ),
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void defaultCallback(FrontEntry entry) {}
