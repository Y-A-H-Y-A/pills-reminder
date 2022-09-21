import 'package:flutter/material.dart';
import 'package:pills_reminder/providers/remindersProvider.dart';
import 'package:pills_reminder/reminders%20widgets/reminderWidget.dart';
import 'package:provider/provider.dart';

class CompletedListWidget extends StatelessWidget {
  const CompletedListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RemindersProvider>(context);
    final reminders = provider.remindersCompleted;

    return reminders.isEmpty
        ? const Center(
            child: Text(
              'No completed tasks. ',
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
