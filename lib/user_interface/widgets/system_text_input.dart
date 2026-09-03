import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SystemTextInput extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final Color? labelColor;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool enabled;
  final bool expands;

  const SystemTextInput({
    super.key,
    required this.controller,
    required this.labelText,
    this.labelColor = Colors.black,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.expands = false,
  });

  @override
  State<SystemTextInput> createState() => _SystemTextInputState();
}

class _SystemTextInputState extends State<SystemTextInput> {
  final FocusNode _focusNode = FocusNode();

  final _formFieldKey = GlobalKey<FormFieldState<String>>();

  @override
  void initState() {
    super.initState();

    // Add a function to be called once a field loses focus
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _validateField();
      }
    });
  }

  void _validateField() {
    _formFieldKey.currentState?.validate();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      key: _formFieldKey,
      initialValue: widget.controller.text,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (field) {
        Border border = Border.all(
          color: field.hasError ? Colors.red : Colors.grey[300]!,
          width: 1,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Field Label
            Text(
              widget.labelText,
              style: TextStyle(fontSize: 16, color: widget.labelColor),
            ),

            const SizedBox(height: 6),

            // Field
            Stack(
              alignment: Alignment.centerRight,
              children: [
                // Field Container
                Container(
                  constraints: BoxConstraints(maxWidth: 600, maxHeight: 100),
                  decoration: BoxDecoration(
                    color: widget.enabled ? Colors.white : Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                    border: border,
                  ),
                  padding: widget.expands
                      ? EdgeInsets.only(top: 12)
                      : EdgeInsets.only(top: 4),
                  child: TextField(
                    focusNode: _focusNode,
                    keyboardType: widget.keyboardType,
                    obscureText: widget.obscureText,
                    controller: widget.controller,
                    onChanged: (value) {
                      field.didChange(value);
                      if (widget.onChanged != null) {
                        widget.onChanged!(value);
                      }
                      SchedulerBinding.instance.scheduleForcedFrame();
                    },
                    enabled: widget.enabled,
                    maxLines: null,
                    minLines: null,
                    expands: widget.expands,
                    onEditingComplete: () {
                      _focusNode.unfocus();
                    },
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 4),
                      border: InputBorder.none,
                      errorText: null,
                    ),
                  ),
                ),

                // Graphic to show in case we have an error
                if (widget.enabled && field.hasError)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Tooltip(
                        message: field.errorText,
                        child: const Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),

                // Graphic to show in case we validate correctly
                // if (widget.enabled &&
                //     !field.hasError &&
                //     widget.controller.text.isNotEmpty)
                //   Padding(
                //     padding: const EdgeInsets.only(right: 8),
                //     child: Icon(
                //       Icons.check_circle,
                //       color: Colors.green.shade600,
                //     ),
                //   ),
              ],
            ),

            // Error message
            if (field.hasError)
              Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Text(
                  field.errorText ?? "",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorScheme.of(context).primary,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
