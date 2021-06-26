import 'package:flutter/material.dart';

import 'package:argonaute_push/page/push_detail.dart';
import 'package:argonaute_push/page/settings.dart';

class PushList extends StatefulWidget {
  const PushList({Key? key}) : super(key: key);

  @override
  _PushListState createState() => _PushListState();
}

class _PushListState extends State<PushList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text("푸시 리스트"),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Settings())),
                  child: Icon(Icons.settings)),
            ],
          ),
          body: ListView(
            children: [
              ElevatedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PushDetail())),
                  child: Text("자세히"))
            ],
          )),
    );
  }
}
