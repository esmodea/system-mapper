import 'dart:math';

import 'package:flutter/material.dart';
import 'package:system_mapper/data/hive_objects/system/system.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/user_interface/widgets/system_text_button.dart';
import 'package:system_mapper/user_interface/widgets/system_text_input.dart';
import 'package:system_mapper/utils/current.dart';
import 'package:system_mapper/utils/safe_update_state.dart';
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

class _SystemFormState extends State<SystemForm> {
  final _formKey = GlobalKey<FormState>();

  bool _isValid = false;
  // DateTime _datePickerValue = DateTime.now().subtract(
  //   const Duration(days: 365 * 13 + 5),
  // );

  // Input controllers
  final _systemNameController = TextEditingController();
  final _systemBioController = TextEditingController();

  // Input titles
  final String _systemNameTitle = 'System name';
  final String _systemBioTitle = 'System bio';

  // Input error states
  String? _systemNameError;
  String? _systemBioError;

  @override
  void dispose() {
    super.dispose();
    _systemNameController.dispose();
    _systemBioController.dispose();
  }

  // Input validators
  String? _validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Text box cannot be empty.';
    }
    return null;
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
                          onChanged: (value) {
                            safeSetState(() {
                              _isValid =
                                  _validateNotEmpty(
                                        _systemNameController.text,
                                      ) !=
                                      null &&
                                  _validateNotEmpty(
                                        _systemBioController.text,
                                      ) !=
                                      null;
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
                            onChanged: (value) {
                              safeSetState(() {
                                _isValid =
                                    _validateNotEmpty(
                                          _systemNameController.text,
                                        ) !=
                                        null &&
                                    _validateNotEmpty(
                                          _systemBioController.text,
                                        ) !=
                                        null;
                              });
                            },
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
