import 'package:flutter/material.dart';

class FrontingForm extends StatefulWidget {
  const FrontingForm({super.key});

  @override
  State<FrontingForm> createState() => _FrontingFormState();
}

class _FrontingFormState extends State<FrontingForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
