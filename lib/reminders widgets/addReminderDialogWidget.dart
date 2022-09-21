import 'package:flutter/material.dart';
import 'package:pills_reminder/models/remindersModel.dart';
import 'package:pills_reminder/providers/remindersProvider.dart';
import 'package:provider/provider.dart';

import 'remindersFormWidget.dart';

class AddReminderDialogWidget extends StatefulWidget {
  AddReminderDialogWidget({Key? key}) : super(key: key);

  @override
  State<AddReminderDialogWidget> createState() =>
      _AddReminderDialogWidgetState();
}

class _AddReminderDialogWidgetState extends State<AddReminderDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Reminder',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 8),
            ReminderFormWidget(
              onChangedTitle: (title) => setState(() => this.title = title),
              onChangedDescription: (description) =>
                  setState(() => this.description = description),
              onSavedReminder: addReminder,
            ),
          ],
        ),
      ),
    );
  }

  void addReminder() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      final reminder = Reminder(
        title: title,
        description: description,
        createdTime: DateTime.now(),
      );
      final provider = Provider.of<RemindersProvider>(context, listen: false);
      provider.addReminder(reminder);

      Navigator.of(context).pop();
    }
  }
}
