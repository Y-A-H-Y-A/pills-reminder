import 'package:flutter/material.dart';
import 'package:pills_reminder/models/remindersModel.dart';

class RemindersProvider extends ChangeNotifier {
  final List<Reminder> _reminder = [
    //?An Example For A Reminder
    Reminder(
      createdTime: DateTime.now(),
      title: 'Take the headache medicine',
    ),
  ];

  List<Reminder> get reminder =>
      _reminder.where((reminder) => reminder.isDone == false).toList();

  List<Reminder> get remindersCompleted =>
      _reminder.where((reminder) => reminder.isDone == true).toList();

  void addReminder(Reminder reminder) {
    _reminder.add(reminder);

    notifyListeners();
  }

  void removeReminder(Reminder reminder) {
    _reminder.remove(reminder);

    notifyListeners();
  }

  bool toggleReminderStatus(Reminder reminder) {
    reminder.isDone = !reminder.isDone;
    notifyListeners();

    return reminder.isDone;
  }

  void updateReminder(Reminder reminder, String title, String description) {
    reminder.title = title;
    reminder.description = description;

    notifyListeners();
  }
}
