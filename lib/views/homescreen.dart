import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:localnotification/main.dart';

import 'package:timezone/timezone.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void showNotification() async {
    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails(
      "Notification-Youtube",
      "Youtube",
      priority: Priority.max,
      importance: Importance.high,
    );
    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);
    DateTime scheduledate = DateTime.now().add(Duration(seconds: 5));
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    await notificationsPlugin.zonedSchedule(
      01,
      "Local Notification",
      "Time to show Local Notification",
      TZDateTime.from(scheduledate, local),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      androidAllowWhileIdle: true,
      payload: "nextscreen",
    );
  }

  void checkNotification() async {
    NotificationAppLaunchDetails? details =
        await notificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null) {
      NotificationResponse? response = details.notificationResponse;
      if (response != null) {
        String? payload = response.payload;
        // Navigator.pushNamed(context, payload!);
        // ignore: use_build_context_synchronously

        log("notifictaion payload : $payload");
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homescreen"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showNotification();
        },
        child: const Icon(Icons.notification_add),
      ),
    );
  }
}
