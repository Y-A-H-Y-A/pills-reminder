import 'package:flutter/material.dart';
import 'package:pills_reminder/models/remindersModel.dart';
import 'package:pills_reminder/providers/remindersProvider.dart';
import 'package:pills_reminder/reminders%20widgets/remindersFormWidget.dart';
import 'package:provider/provider.dart';

class EditRemindersPage extends StatefulWidget {
  final Reminder reminder;
  EditRemindersPage({Key? key, required this.reminder}) : super(key: key);

  @override
  State<EditRemindersPage> createState() => _EditRemindersPageState();
}

class _EditRemindersPageState extends State<EditRemindersPage> {
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String description;

  @override
  void initState() {
    super.initState();

    title = widget.reminder.title;
    description = widget.reminder.description;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Edit Reminder'),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                final provider =
                    Provider.of<RemindersProvider>(context, listen: false);
                provider.removeReminder(widget.reminder);

                Navigator.of(context).pop();
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ReminderFormWidget(
              title: title,
              description: description,
              onChangedTitle: (title) => setState(() => this.title = title),
              onChangedDescription: (description) =>
                  setState(() => this.description = description),
              onSavedReminder: saveReminder,
            ),
          ),
        ),
      );

  void saveReminder() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<RemindersProvider>(context, listen: false);

      provider.updateReminder(widget.reminder, title, description);

      Navigator.of(context).pop();
    }
  }
}
