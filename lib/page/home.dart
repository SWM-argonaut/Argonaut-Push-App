import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:localstorage/localstorage.dart';

import 'package:argonaute_push/page/push_list.dart';
import 'package:argonaute_push/page/tag.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final LocalStorage _storage = new LocalStorage('data.json');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _storage.ready,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(
              // 로딩화면
              child: CircularProgressIndicator(),
            );
          }

          return _storage.getItem("current_tag") == null ? Tag() : PushList();
        });
  }
}
