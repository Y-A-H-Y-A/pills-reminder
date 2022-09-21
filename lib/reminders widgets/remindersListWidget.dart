import 'package:flutter/material.dart';
import 'package:pills_reminder/providers/remindersProvider.dart';
import 'package:provider/provider.dart';

import 'reminderWidget.dart';

class RemindersListWidget extends StatelessWidget {
  const RemindersListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RemindersProvider>(context);
    final reminders = provider.reminder;
    return reminders.isEmpty
        ? const Center(
            child: Text(
              'No reminders',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(height: 8),
            itemCount: reminders.length,
            itemBuilder: (context, index) {
              final reminder = reminders[index];

              return ReminderWidget(reminder: reminder);
            },
          );
  }
}
