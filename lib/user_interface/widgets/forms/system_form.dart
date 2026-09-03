import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:system_mapper/data/hive_objects/system/system.dart';
import 'package:system_mapper/data/hive_objects/system/system_front_type.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/user_interface/widgets/system_front_selector.dart';
import 'package:system_mapper/user_interface/widgets/system_text_button.dart';
import 'package:system_mapper/user_interface/widgets/system_text_input.dart';
import 'package:system_mapper/utils/current.dart';
import 'package:system_mapper/utils/safe_set_state.dart';
import 'package:uuid/uuid.dart';

Random random = Random();

class SystemForm extends StatefulWidget {
  final VoidCallback callback;
  const SystemForm({super.key, required this.callback});

  @override
  State<SystemForm> createState() => _SystemFormState();
}

// class _SystemFormState extends State<SystemForm> {
//   @override
//   Widget build(BuildContext context) {
//     return const Text('System form');
//   }
// }

class _SystemFormState extends SafeState<SystemForm> {
  final _formKey = GlobalKey<FormState>();

  bool _isValid = false;
  SystemFrontType type = .onlyTrackFront;
  // DateTime _datePickerValue = DateTime.now().subtract(
  //   const Duration(days: 365 * 13 + 5),
  // );

  // Input controllers
  final _systemNameController = TextEditingController();
  final _systemBioController = TextEditingController();

  // Input titles
  final String _systemNameTitle = 'System name';
  final String _systemBioTitle = 'System bio';

  @override
  void dispose() {
    super.dispose();
    _systemNameController.dispose();
    _systemBioController.dispose();
  }

  // Input validators
  String? _validateNotEmpty(String? value) {
    debugPrint('validating...');
    if (value == null || value.trim().isEmpty) {
      return 'Text box cannot be empty.';
    }
    return null;
  }

  void validateForm(String value) {
    safeSetState(() {
      _isValid =
          _validateNotEmpty(_systemNameController.text) != null &&
          _validateNotEmpty(_systemBioController.text) != null;
    });
    SchedulerBinding.instance.scheduleFrame();
  }

  @override
  Widget build(BuildContext context) {
    // Get global app state
    final Color labelsColor = Theme.of(context).colorScheme.onSurface;

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // System Name
                        SystemTextInput(
                          controller: _systemNameController,
                          labelText: _systemNameTitle,
                          labelColor: labelsColor,
                          validator: _validateNotEmpty,
                          onChanged: validateForm,
                        ),

                        const SizedBox(height: 20),

                        SystemFrontSelector(
                          stateCallback: (SystemFrontType frontType) {
                            safeSetState(() {
                              type = frontType;
                            });
                          },
                        ),

                        const SizedBox(height: 20),

                        // System Bio
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: 600,
                            maxHeight: 500,
                          ),
                          child: SystemTextInput(
                            controller: _systemBioController,
                            labelText: _systemBioTitle,
                            labelColor: labelsColor,
                            validator: _validateNotEmpty,
                            expands: true,
                            onChanged: validateForm,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Action Buttons
                        SystemTextButton(
                          text: 'Create System',
                          color: ButtonColor.secondary,
                          disabled: _isValid,
                          onPressed: () async {
                            debugPrint('Creating system...');
                            String newUUID = Uuid().v4();

                            final System newSystem = System(
                              id: newUUID,
                              systemName: _systemNameController.text,
                              systemBio: _systemBioController.text,
                              systemUUID: newUUID,
                              frontTypeString: type.toString(),
                            );

                            await newSystem.save();

                            debugPrint(
                              ModelType.system.appBox
                                  .getById(newUUID)
                                  ?.systemName,
                            );
                            debugPrint(
                              ModelType.system.appBox
                                  .getById(newUUID)
                                  ?.systemBio,
                            );

                            await newSystem.updateCurrent();

                            debugPrint(Current.system?.systemName);
                            debugPrint(Current.system?.systemBio);

                            widget.callback();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
