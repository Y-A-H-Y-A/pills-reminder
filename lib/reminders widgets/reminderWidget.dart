import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pills_reminder/models/remindersModel.dart';
import 'package:pills_reminder/providers/remindersProvider.dart';
import 'package:pills_reminder/reminders%20pages/editRemindersPage.dart';
import 'package:provider/provider.dart';

import '../APIs/oldNotificationsAPI.dart';
import '../reminders pages/remindersMainPage.dart';
import '../styles/customStyles.dart';
import '../utils.dart';

class ReminderWidget extends StatefulWidget {
  final Reminder reminder;
  const ReminderWidget({
    Key? key,
    required this.reminder,
  }) : super(key: key);

  @override
  State<ReminderWidget> createState() => _ReminderWidgetState();
}

class _ReminderWidgetState extends State<ReminderWidget> {
  TimeOfDay time = TimeOfDay(hour: 10, minute: 30);
  @override
  void initState() {
    super.initState();

    NotificationApi.init();
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) => Navigator.pushNamed(
        context,
        RemindersMainPage.pageRout,
      );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Slidable(
        actionPane: const SlidableDrawerActionPane(),
        key: Key(widget.reminder.id.toString()),
        actions: [
          IconSlideAction(
            color: Colors.green,
            onTap: () => editReminder(context, widget.reminder),
            caption: 'Edit',
            icon: Icons.edit,
          )
        ],
        secondaryActions: [
          IconSlideAction(
            color: Colors.red,
            caption: 'Delete',
            onTap: () => deleteReminder(context, widget.reminder),
            icon: Icons.delete,
          )
        ],
        child: buildReminder(context),
      ),
    );
  }

  Widget buildReminder(BuildContext context) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return GestureDetector(
      onTap: () => editReminder(context, widget.reminder),
      child: Container(
        color: const Color(0xFF8D83B5),
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 21),
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(
                  activeColor: Theme.of(context).primaryColor,
                  checkColor: Colors.white,
                  value: widget.reminder.isDone,
                  onChanged: (_) {
                    final provider =
                        Provider.of<RemindersProvider>(context, listen: false);
                    final isDone =
                        provider.toggleReminderStatus(widget.reminder);

                    Utils.showSnackBar(
                      context,
                      isDone ? 'Task completed' : 'Task marked incomplete',
                    );
                  },
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.reminder.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 22,
                        ),
                      ),
                      if (widget.reminder.description.isNotEmpty)
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Text(
                            widget.reminder.description,
                            style: TextStyle(fontSize: 20, height: 1.5),
                          ),
                        ),
                      // const Text('Hello'),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              height: 45,
                              width: 100,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xFF715DC0),
                                  side: const BorderSide(
                                      color: Colors.white, width: 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10), // <-- Radius
                                  ),
                                ),
                                onPressed: () async {
                                  TimeOfDay? newTime = await showTimePicker(
                                    context: context,
                                    initialTime: time,
                                  );

                                  //?if 'CANCLE' => null
                                  if (newTime == null) return;
                                  //? if 'OK' => TimeOfDay
                                  setState(() => time = newTime);
                                },
                                child: Text('$hours : $minutes',
                                    textAlign: TextAlign.left,
                                    style: CustomTextStyle.style(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    )),
                              )),
                          const SizedBox(width: 10),
                          //? The "Notify me" button
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFF715DC0))),
                            onPressed: () => NotificationApi.showNotification(
                              title: widget.reminder.title,
                              body: widget.reminder.description,
                              payload: '',
                            ),
                            child: const Text("Notify me"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void deleteReminder(BuildContext context, Reminder reminder) {
    final provider = Provider.of<RemindersProvider>(context, listen: false);
    provider.removeReminder(reminder);

    Utils.showSnackBar(context, 'Deleted the task');
  }

  void editReminder(BuildContext context, Reminder reminder) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditRemindersPage(reminder: reminder),
        ),
      );
}
