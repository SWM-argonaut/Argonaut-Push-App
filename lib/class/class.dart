import 'package:onesignal_flutter/onesignal_flutter.dart';

class Item {
  String? title, body;

  Item({required this.title, required this.body});
  Item.notification(OSNotification item) {
    this.title = "${item.title}";
    this.body = "${item.body}";
  }

  static List<Item> jsonToItems(List<dynamic> json) {
    List<Item> items = [];

    for (var item in json) {
      items.add(Item(
        title: item['title'],
        body: item['mainText'],
      ));
    }

    return items;
  }
}
