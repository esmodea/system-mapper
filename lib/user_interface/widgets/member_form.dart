import 'dart:math';

import 'package:flutter/material.dart';
import 'package:system_mapper/data/hive_objects/member.dart';
import 'package:system_mapper/data/hive_objects/system.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/user_interface/widgets/system_text_button.dart';
import 'package:system_mapper/user_interface/widgets/system_text_input.dart';
import 'package:system_mapper/utils/current.dart';
import 'package:system_mapper/utils/safe_update_state.dart';

Random random = Random();

class MemberForm extends StatefulWidget {
  final VoidCallback callback;
  const MemberForm({super.key, required this.callback});

  @override
  State<MemberForm> createState() => _MemberFormState();
}

// class _MemberFormState extends State<MemberForm> {
//   @override
//   Widget build(BuildContext context) {
//     return const Text('System form');
//   }
// }

class _MemberFormState extends State<MemberForm> {
  final _formKey = GlobalKey<FormState>();

  bool _isValid = false;

  // Input controllers
  final _memberNameController = TextEditingController();
  final _memberBioController = TextEditingController();

  // Input titles
  final String _memberNameTitle = 'Member name';
  final String _memberBioTitle = 'Member bio';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _memberNameController.dispose();
    _memberBioController.dispose();
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
    final Color labelsColor = Theme.of(context).colorScheme.onPrimary;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        // border: Border.all(
        //   color: Theme.of(context).colorScheme.primary,
        //   width: 2,
        // ),
      ),
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
                      controller: _memberNameController,
                      labelText: _memberNameTitle,
                      labelColor: labelsColor,
                      validator: _validateNotEmpty,
                      onChanged: (value) {
                        safeSetState(() {
                          _isValid =
                              _validateNotEmpty(_memberNameController.text) !=
                                  null &&
                              _validateNotEmpty(_memberBioController.text) !=
                                  null;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    // System Bio
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: 600,
                        maxHeight: 200,
                      ),
                      child: SystemTextInput(
                        controller: _memberBioController,
                        labelText: _memberBioTitle,
                        labelColor: labelsColor,
                        validator: _validateNotEmpty,
                        expands: true,
                        onChanged: (value) {
                          safeSetState(() {
                            _isValid =
                                _validateNotEmpty(_memberNameController.text) !=
                                    null &&
                                _validateNotEmpty(_memberBioController.text) !=
                                    null;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Action Buttons
                    SystemTextButton(
                      text: 'Create Member',
                      color: ButtonColor.secondary,
                      disabled: _isValid,
                      onPressed: () async {
                        final System system = System(
                          id: Current.system?.systemUUID,
                          membersList: [
                            ...Current.system?.membersList ?? [],
                            Member(
                              memberName: _memberNameController.text,
                              memberBio: _memberBioController.text,
                            ),
                          ],
                        );

                        await system.saveSafely();

                        // debugPrint(
                        //   ModelType.system.appBox
                        //       .getById(Current.system?.systemUUID)
                        //       ?.membersList
                        //       ?.length
                        //       .toString(),
                        // );

                        await system.updateCurrent();

                        // debugPrint(
                        //   Current.system?.membersList?.length.toString(),
                        // );

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
    );
  }
}
