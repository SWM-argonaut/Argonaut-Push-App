import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';

class Tag extends StatefulWidget {
  const Tag({Key? key}) : super(key: key);

  @override
  _TagState createState() => _TagState();
}

class _TagState extends State<Tag> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("태그등록"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "키를 입력해주세요!",
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              controller: _textController,
            ),
            ElevatedButton(onPressed: _sendTag, child: Text("확인"))
          ],
        ),
      ),
    );
  }

  _sendTag() async {
    // 놀랍게도 이모지도 받아준다.
    var result = await OneSignal.shared.sendTag(_textController.text, "권한?");
    log(result.toString()); // 모든 태그들을 key:value 로 준다.
  }
}
