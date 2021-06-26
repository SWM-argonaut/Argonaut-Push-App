import 'package:flutter/material.dart';

import 'package:argonaute_push/page/tag.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("설정"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Tag())),
            child: Text("태그 바꾸기"),
          )
        ]),
      ),
    );
  }
}
