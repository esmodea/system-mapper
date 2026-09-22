import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:system_mapper/data/hive_objects/feelings/feeling.dart';
import 'package:system_mapper/data/hive_objects/feelings/feeling_entry.dart';
import 'package:system_mapper/data/hive_objects/front/front_entry.dart';
import 'package:system_mapper/data/hive_objects/system/system_front_type.dart';
import 'package:system_mapper/user_interface/widgets/cards/selected_feeling_card.dart';
import 'package:system_mapper/user_interface/widgets/cards/standard/member_card.dart';
import 'package:system_mapper/user_interface/widgets/inputs/feelings_wheel.dart';
import 'package:system_mapper/user_interface/widgets/modals/default_modal.dart';
import 'package:system_mapper/user_interface/widgets/system_text_button.dart';
import 'package:system_mapper/utils/current.dart';
import 'package:system_mapper/utils/safe_set_state.dart';

class EndFrontForm extends StatefulWidget {
  final FrontEntry? initialEntry;
  const EndFrontForm({super.key, this.initialEntry});

  @override
  State<EndFrontForm> createState() => _EndFrontFormState();
}

class _EndFrontFormState extends SafeState<EndFrontForm> {
  late FrontEntry entry = widget.initialEntry ?? FrontEntry();

  @override
  void initState() {
    entry.endTime = DateTime.now();
    super.initState();
  }

  void pickStartDateTime() async {
    DateTime startTime =
        await showOmniDateTimePicker(
          context: context,
          constraints: BoxConstraints(maxWidth: 600),
          selectableDayPredicate: (date) {
            return date.isBefore(DateTime.now()) ||
                date.isAtSameMomentAs(DateTime.now());
          },
        ) ??
        entry.startTime ??
        DateTime.now();
    entry.startTime = startTime;
    safeSetState(() {
      entry;
    });
  }

  void pickEndDateTime() async {
    DateTime endTime =
        await showOmniDateTimePicker(
          context: context,
          constraints: BoxConstraints(maxWidth: 600),
          selectableDayPredicate: (date) {
            return date.isBefore(DateTime.now()) ||
                date.isAtSameMomentAs(DateTime.now());
          },
        ) ??
        entry.endTime ??
        DateTime.now();
    entry.endTime = endTime;
    safeSetState(() {
      entry;
    });
  }

  void pickStartFeeling() {
    DefaultModal(
      buttonText: 'Cancel',
      preferredSize: Size(648, 552),
      child: FeelingsSelector(
        callback: (info) {
          Feeling? feeling =
              Feeling.getFeeling(info.thirdOrderSelection) ??
              Feeling.getFeeling(info.secondOrderSelection) ??
              Feeling.getFeeling(info.firstOrderSelection);

          debugPrint(feeling?.toString());

          FeelingEntry newFeelingEntry = FeelingEntry(feeling: feeling);
          entry.startFeeling = newFeelingEntry;
          safeSetState(() {
            entry;
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
        callback: (info) {
          Feeling? feeling =
              Feeling.getFeeling(info.thirdOrderSelection) ??
              Feeling.getFeeling(info.secondOrderSelection) ??
              Feeling.getFeeling(info.firstOrderSelection);

          debugPrint(feeling?.toString());

          FeelingEntry newFeelingEntry = FeelingEntry(feeling: feeling);
          entry.endFeeling = newFeelingEntry;
          safeSetState(() {
            entry;
          });
        },
      ),
    ).build(context);
  }

  bool validateForm() {
    bool formIsValid = false;
    if (entry.member?.memberBio != null) {
      formIsValid = true;
    }

    if (entry.startTime == entry.endTime) {
      formIsValid = false;
    }
    return formIsValid;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorScheme.of(context).primaryContainer,
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      constraints: BoxConstraints(
        maxWidth: 600,
        maxHeight: ((MediaQuery.heightOf(context) / 6) * 5) - 26,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SystemTextButton(
                    text: 'Select a member',
                    onPressed: () {
                      WidgetsFlutterBinding.ensureInitialized()
                          .addPostFrameCallback((_) {
                            DefaultModal(
                              buttonText: 'Cancel',
                              child: Column(
                                children: [
                                  ...Current.system?.membersList?.map((member) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                              ),
                                              child: Text(
                                                member.memberName ?? '',
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 8.0,
                                              ),
                                              child: FloatingActionButton(
                                                onPressed: () {
                                                  entry.member = member;
                                                  safeSetState(() {
                                                    entry = entry;
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
                    member: entry.member,
                    hideBio: true,
                    showEditButton: false,
                  ),
                  SizedBox(height: 40),
                  SystemTextButton(
                    text: 'Change front start time',
                    onPressed: pickStartDateTime,
                  ),
                  SizedBox(height: 40),
                  SystemTextButton(
                    text: 'Change front end time',
                    onPressed: pickEndDateTime,
                  ),
                  SizedBox(height: 40),
                  SystemTextButton(
                    text: 'Edit your starting feeling',
                    onPressed: pickStartFeeling,
                  ),
                  SelectedFeelingCard(
                    shouldShowFirst: false,
                    shouldShowSecond: false,
                    shouldShowThird: entry.startFeeling != null,
                    firstOrderEmoji: '',
                    firstOrderSelection: '',
                    secondOrderEmoji: '',
                    secondOrderSelection: '',
                    thirdOrderEmoji:
                        entry.startFeeling?.feeling?.emojiCode ?? '',
                    thirdOrderSelection:
                        entry.startFeeling?.feeling?.feelingName ?? '',
                  ),
                  SystemTextButton(
                    text: 'Choose how you\'re feeling now',
                    onPressed: pickEndFeeling,
                  ),
                  SelectedFeelingCard(
                    shouldShowFirst: false,
                    shouldShowSecond: false,
                    shouldShowThird: entry.endFeeling != null,
                    firstOrderEmoji: '',
                    firstOrderSelection: '',
                    secondOrderEmoji: '',
                    secondOrderSelection: '',
                    thirdOrderEmoji: entry.endFeeling?.feeling?.emojiCode ?? '',
                    thirdOrderSelection:
                        entry.endFeeling?.feeling?.feelingName ?? '',
                  ),
                  SizedBox(height: 40),
                  Opacity(
                    opacity: validateForm() ? 1 : 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        switch (SystemFrontType.parse(
                          Current.system?.frontType.toString() ?? '',
                        )) {
                          SystemFrontType.trackSingleFront => SystemTextButton(
                            text: 'Remove from front',
                            disabled: !validateForm(),
                            onPressed: () {
                              if (entry.isOnlyConscious ?? false) {
                                entry.removeFromConsciousness();
                              } else {
                                entry.removeFromSingleFront();
                              }
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            },
                          ),
                          _ => SystemTextButton(
                            text: 'Remove from front',
                            disabled: !validateForm(),
                            onPressed: () {
                              entry.removeFromStandardFront();
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            },
                          ),
                        },
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
