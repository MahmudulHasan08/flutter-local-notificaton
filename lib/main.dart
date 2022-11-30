import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:localnotification/views/homescreen.dart';
import 'package:localnotification/views/nextscreen.dart';
import 'package:timezone/data/latest_10y.dart';

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeTimeZones();
  AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings("@mipmap/ic_launcher");
  // ignore: prefer_const_constructors
  DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    requestCriticalPermission: true,
  );
  InitializationSettings initializationSettings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
  );
  bool? initized = await notificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (response) {
    log(response.payload.toString());
    log("shetu");
  });

  log("notification : $initized");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        "nextscreen": (context) => NextScreen(),
      },
    );
  }
}
