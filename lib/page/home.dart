import 'package:flutter/material.dart';

import 'package:argonaute_push/functions/functions.dart';
import 'package:argonaute_push/page/push_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("푸시 앱")),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "키를 입력해주세요!",
              style: TextStyle(fontSize: 20),
            ),
            TextField(),
            ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PushList())),
                child: Text("확인"))
          ],
        ),
      ),
    );
  }
}
