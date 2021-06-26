import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:localstorage/localstorage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class Tag extends StatefulWidget {
  const Tag({Key? key}) : super(key: key);

  @override
  _TagState createState() => _TagState();
}

class _TagState extends State<Tag> {
  bool _isSending = false;
  late TextEditingController _textController;
  final LocalStorage _storage = new LocalStorage('data.json');

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
        child: FutureBuilder(
            future: _storage.ready,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "키를 입력해주세요!",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                    controller: _textController,
                  ),
                  ElevatedButton(onPressed: _addTagPopup, child: Text("확인"))
                ],
              );
            }),
      ),
    );
  }

  _addTagPopup() {
    if (_isSending) {
      return;
    }

    _isSending = true;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text("계정 전환 중"),
            content: FutureBuilder(
              future: _addTag(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    // TODO 로딩화면 꾸미기
                    child: CircularProgressIndicator(),
                  );
                }

                // TODO 에러처리

                return Column(children: [
                  // TODO 성공 페이지 꾸미기
                  Text(snapshot.data),
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("확인"))
                ]);
              },
            ),
          );
        });

    _isSending = false;
  }

  _addTag() async {
    try {
      if (_storage.getItem("current_tag") != null) {
        await OneSignal.shared.deleteTag(_storage.getItem("current_tag"));
      }

      // 놀랍게도 이모지도 받아준다.
      var tags = await OneSignal.shared.sendTag(_textController.text, "태그 값");
      log(tags.toString()); // 모든 태그들을 key:value 로 준다.

      await _storage.setItem("tags", tags);
      await _storage.setItem("current_tag", _textController.text);
    } catch (err) {
      log(err.toString());
      return err.toString();
    }

    return "done";
  }
}
