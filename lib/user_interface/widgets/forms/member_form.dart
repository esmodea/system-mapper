import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:system_mapper/data/hive_objects/system/member.dart';
import 'package:system_mapper/data/hive_objects/system/system.dart';
import 'package:system_mapper/user_interface/widgets/system_text_button.dart';
import 'package:system_mapper/user_interface/widgets/system_text_input.dart';
import 'package:system_mapper/utils/current.dart';
import 'package:system_mapper/utils/safe_set_state.dart';
import 'package:uuid/uuid.dart';

Random random = Random();

class MemberForm extends StatefulWidget {
  final bool isEdit;
  final bool shouldCallbackInCancel;
  final Member? editMember;
  final VoidCallback callback;
  const MemberForm({
    super.key,
    required this.callback,
    this.isEdit = false,
    this.editMember,
    this.shouldCallbackInCancel = false,
  });

  @override
  State<MemberForm> createState() => _MemberFormState();
}

// class _MemberFormState extends State<MemberForm> {
//   @override
//   Widget build(BuildContext context) {
//     return const Text('System form');
//   }
// }

class _MemberFormState extends SafeState<MemberForm> {
  late final bool isEdit = widget.isEdit && widget.editMember != null;

  final _formKey = GlobalKey<FormState>();

  bool _isValid = false;

  // Input controllers
  late final _memberNameController = TextEditingController(
    text: widget.editMember?.memberName,
  );
  late final _memberBioController = TextEditingController(
    text: widget.editMember?.memberBio,
  );

  // Input titles
  final String _memberNameTitle = 'Member name';
  final String _memberBioTitle = 'Member bio';

  // Color values
  late Color selectedColor =
      widget.editMember?.avatarColor ??
      ColorScheme.of(context).primaryContainer;

  void updateColor(Color color) {
    safeSetState(() {
      selectedColor = color;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  // }

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
        color: Theme.of(context).colorScheme.primary,
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

                    LayoutBuilder(
                      builder: (context, constraints) {
                        debugPrint(constraints.maxWidth.toString());

                        return InputDecorator(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            labelText: 'Avatar Color:',
                            labelStyle: TextTheme.of(context).labelLarge
                                ?.copyWith(
                                  color: ColorScheme.of(context).onPrimary,
                                ),
                            maintainLabelSize: true,
                          ),
                          child: ColorPicker(
                            enableAlpha: false,
                            hexInputBar: true,
                            pickerColor: selectedColor,
                            onColorChanged: updateColor,
                            pickerAreaBorderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            colorPickerWidth: constraints.maxWidth / 3,
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (Navigator.canPop(context))
                          SystemTextButton(
                            text: 'Cancel',
                            color: ButtonColor.error,
                            onPressed: () async {
                              if (Navigator.canPop(context)) {
                                Navigator.of(context).pop();
                              }
                              if (widget.shouldCallbackInCancel) {
                                widget.callback();
                              }
                            },
                          ),
                        SystemTextButton(
                          text: '${isEdit ? 'Edit' : 'Create'} Member',
                          color: ButtonColor.secondary,
                          disabled: _isValid,
                          onPressed: () async {
                            List<Member>? memberList =
                                Current.system?.membersList;

                            if (memberList != null && isEdit) {
                              memberList.removeWhere(
                                (member) =>
                                    member.memberName ==
                                    widget.editMember!.memberName,
                              );
                            }

                            Member? member;

                            if (!isEdit) {
                              member = Member(
                                id: Uuid().v5(
                                  Namespace.url.value,
                                  _memberNameController.text,
                                ),
                                memberName: _memberNameController.text,
                                memberBio: _memberBioController.text,
                                avatarColor: selectedColor,
                              );
                            } else {
                              member = Member(
                                id: Uuid().v5(
                                  Namespace.url.value,
                                  widget.editMember?.memberName,
                                ),
                                memberName: _memberNameController.text,
                                memberBio: _memberBioController.text,
                                avatarColor: selectedColor,
                              );
                            }

                            final System system = System(
                              id: Current.system?.systemUUID,
                              membersList: [...memberList ?? [], member],
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
