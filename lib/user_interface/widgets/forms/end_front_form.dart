import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:system_mapper/data/hive_objects/feelings/feeling.dart';
import 'package:system_mapper/data/hive_objects/feelings/feeling_entry.dart';
import 'package:system_mapper/data/hive_objects/front/front_entry.dart';
import 'package:system_mapper/data/hive_objects/system/system_front_type.dart';
import 'package:system_mapper/user_interface/widgets/cards/selected_feeling_card.dart';
import 'package:system_mapper/user_interface/widgets/cards/standard/member_card.dart';
import 'package:system_mapper/user_interface/widgets/inputs/date_time_input.dart';
import 'package:system_mapper/user_interface/widgets/inputs/feeling_input.dart';
import 'package:system_mapper/user_interface/widgets/inputs/member_input.dart';
import 'package:system_mapper/user_interface/widgets/inputs/sub_inputs/feelings_selector.dart';
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

  void pickStartDateTimeSelector() async {
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

  void pickEndDateTimeSelector() async {
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

  void pickStartFeelingSelector(Feeling? feeling) {
    FeelingEntry newFeelingEntry = FeelingEntry(feeling: feeling);
    entry.startFeeling = newFeelingEntry;
    safeSetState(() {
      entry;
    });
  }

  void pickEndFeelingSelector(Feeling? feeling) {
    FeelingEntry newFeelingEntry = FeelingEntry(feeling: feeling);
    entry.endFeeling = newFeelingEntry;
    safeSetState(() {
      entry;
    });
  }

  void pickMemberSelector() {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      DefaultModal(
        buttonText: 'Cancel',
        child: Column(
          children: [
            ...Current.system?.membersList?.map((member) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(member.memberName ?? ''),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FloatingActionButton(
                          onPressed: () {
                            entry.member = member;
                            safeSetState(() {
                              entry = entry;
                            });
                            if (Navigator.canPop(context)) {
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
        color: ColorScheme.of(context).primary,
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
                  MemberInput(
                    selector: pickMemberSelector,
                    label: 'Select a member',
                    displayMember: entry.member,
                  ),
                  SizedBox(height: 40),
                  DateTimeInput(
                    selector: pickStartDateTimeSelector,
                    label: 'Start date & time',
                    displayTime: entry.startTime,
                  ),
                  SizedBox(height: 40),
                  DateTimeInput(
                    selector: pickEndDateTimeSelector,
                    label: 'End date & time',
                    displayTime: entry.endTime,
                  ),
                  SizedBox(height: 40),
                  FeelingInput(
                    label: 'Start feeling',
                    selector: pickStartFeelingSelector,
                    displayFeeling: entry.startFeeling?.feeling,
                  ),
                  SizedBox(height: 40),
                  FeelingInput(
                    label: 'End feeling',
                    selector: pickEndFeelingSelector,
                    displayFeeling: entry.endFeeling?.feeling,
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
