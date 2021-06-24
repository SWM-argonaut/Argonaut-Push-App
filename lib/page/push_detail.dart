import 'package:flutter/material.dart';

class PushDetail extends StatefulWidget {
  const PushDetail({Key? key}) : super(key: key);

  @override
  _PushDetailState createState() => _PushDetailState();
}

class _PushDetailState extends State<PushDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("푸시 앱"),
        ),
        body: Container(
          child: Text("디테일 페이지"),
        ));
  }
}
