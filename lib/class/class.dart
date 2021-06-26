import 'package:onesignal_flutter/onesignal_flutter.dart';

class Item {
  String? title, body;

  Item({required this.title, required this.body});
  Item.notification(OSNotification item) {
    this.title = "${item.title}";
    this.body = "${item.body}";
  }
}
