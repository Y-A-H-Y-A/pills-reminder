import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:pills_reminder/providers/remindersProvider.dart';
import 'package:pills_reminder/reminders%20pages/remindersMainPage.dart';
import 'package:provider/provider.dart';

void main() {
  //?initializing the notifications channels
  AwesomeNotifications().initialize(
    'resource://drawable/res_notification_app_icon',
    [
      //basic notifications channel
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Sending basic notifications',
        defaultColor: const Color(0xFF715DC0),
        importance: NotificationImportance.High,
        channelShowBadge: true,
      ),

      //schedualed notifications channel
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => RemindersProvider(),
      child: MaterialApp(
        theme: ThemeData(
          canvasColor: const Color(0xFF2D3537),
          indicatorColor: Colors.white,
          primaryColor: Colors.black,
        ),
        debugShowCheckedModeBanner: true,
        home: const RemindersMainPage(),
      ),
    );
  }
}
