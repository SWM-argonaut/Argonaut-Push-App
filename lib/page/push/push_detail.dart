import 'package:flutter/material.dart';

import 'package:argonaute_push/class/class.dart' show Item;

const titleStyle = TextStyle(
  fontSize: 50,
);
const bodyStyle = TextStyle(
  fontSize: 30,
);

class PushDetail extends StatefulWidget {
  final Item? item;

  const PushDetail({Key? key, this.item}) : super(key: key);

  @override
  _PushDetailState createState() => _PushDetailState(item: item);
}

class _PushDetailState extends State<PushDetail> {
  final Item? item;

  _PushDetailState({this.item});

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
                "title : ${item?.title}\n",
                style: titleStyle,
              ),
              Text(
                "body : ${item?.body}",
                style: bodyStyle,
              )
            ],
          ),
        ));
  }
}
