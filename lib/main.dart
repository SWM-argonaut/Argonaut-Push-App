import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:argonaute_push/config.dart';
import 'package:argonaute_push/page/home.dart';
import 'package:argonaute_push/page/push_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  static final _navigatorKey = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    initOneSignal();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Argonaute Push',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }

  Future<void> initOneSignal() async {
    //Remove this method to stop OneSignal Debugging
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setAppId(OnesiganlAppId);

    // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });

    // Called when the user opens or taps an action on a notification.
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      log(result.notification.title.toString());

      _navigatorKey.currentState?.push(MaterialPageRoute(
          builder: (context) => PushDetail(notification: result.notification)));
    });
  }
}
