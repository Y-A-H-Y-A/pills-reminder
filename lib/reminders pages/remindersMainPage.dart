import 'package:flutter/material.dart';

import '../reminders widgets/addReminderDialogWidget.dart';
import '../reminders widgets/completedListWidget.dart';
import '../reminders widgets/remindersListWidget.dart';
import '../styles/customStyles.dart';

class RemindersMainPage extends StatefulWidget {
  const RemindersMainPage({Key? key, this.payload}) : super(key: key);
  final String? payload;
  static const String pageRout = 'remindersMainPage';

  @override
  State<RemindersMainPage> createState() => _RemindersMainPageState();
}

class _RemindersMainPageState extends State<RemindersMainPage>
    with SingleTickerProviderStateMixin {
  //?Custom controller for Tabs
  late TabController controller;

  //?Initialising the controller
  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  //?To clean the controller
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reminders',
          style: CustomTextStyle.style(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF715DC0),
        bottom: TabBar(controller: controller, tabs: [
          Text(
            'To-Take',
            style: CustomTextStyle.style(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
          Text(
            'Taken',
            style: CustomTextStyle.style(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ]),
      ),
      body: TabBarView(controller: controller, children: [
        const RemindersListWidget(),
        CompletedListWidget(),
      ]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFF715DC0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => AddReminderDialogWidget(),
          barrierDismissible: true,
        ),
      ),
    );
  }
}
