import 'package:onesignal_flutter/onesignal_flutter.dart';

class Item {
  String? title, push, body;

  Item({required this.title, required this.push, required this.body});
  Item.notification(OSNotification item) {
    this.title = "${item.title}";
    this.push = "${item.body}";
    this.body = "";
  }

  static List<Item> jsonToItems(List<dynamic> json) {
    List<Item> items = [];

    for (var item in json) {
      items.add(Item(
        title: item['title'],
        push: item['pushText'],
        body: item['mainText'],
      ));
    }

    return items;
  }
}
