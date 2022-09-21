import 'package:pills_reminder/utils.dart';

class ReminderField {
  static const createdTime = 'createdTime';
}

//?The ToDos objects
class Reminder {
  int? id;
  String title;
  String description;
  DateTime? createdTime;
  bool isDone;

  Reminder({
    this.id, //!nullable
    required this.createdTime,
    required this.title,
    this.description = '',
    this.isDone = false,
  });

  static Reminder fromJson(Map<String, dynamic> json) => Reminder(
        createdTime: Utils.toDateTime(json['createdTime']),
        title: json['title'],
        description: json['description'],
        id: json['id'],
        isDone: json['isDone'],
      );
  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime!),
        'title': title,
        'description': description,
        'id': id,
        'isDone': isDone,
      };
}
