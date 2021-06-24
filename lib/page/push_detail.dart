import 'package:flutter/material.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';

const titleStyle = TextStyle(
  fontSize: 50,
);
const bodyStyle = TextStyle(
  fontSize: 30,
);

class PushDetail extends StatefulWidget {
  final OSNotification? notification;

  const PushDetail({Key? key, this.notification}) : super(key: key);

  @override
  _PushDetailState createState() =>
      _PushDetailState(notification: notification);
}

class _PushDetailState extends State<PushDetail> {
  final OSNotification? notification;

  _PushDetailState({this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("푸시 앱"),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "title : ${notification?.title}\n",
                style: titleStyle,
              ),
              Text(
                "body : ${notification?.body}",
                style: bodyStyle,
              )
            ],
          ),
        ));
  }
}
