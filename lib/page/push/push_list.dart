import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:argonaute_push/class/class.dart' show Item;
import 'package:argonaute_push/page/push/push_detail.dart';
import 'package:argonaute_push/page/settings.dart';

class PushList extends StatefulWidget {
  const PushList({Key? key}) : super(key: key);

  @override
  _PushListState createState() => _PushListState();
}

class _PushListState extends State<PushList> {
  final LocalStorage _storage = new LocalStorage('data.json');
  static const int _pageSize = 10;
  final PagingController<int, Item> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("푸시 리스트"),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Settings())),
                child: Icon(Icons.settings)),
          ],
        ),
        body: FutureBuilder(
            future: _storage.ready,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return PagedListView<int, Item>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Item>(
                  itemBuilder: _itemBuilder,
                ),
              );
            }));
  }

  Container _itemBuilder(BuildContext context, Item item, int index) {
    return Container(
        child: ElevatedButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PushDetail(item: item))),
            child: Column(
              children: [Text("${item.title}"), Text("${item.body}")],
            )));
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _getPage(pageKey); //api 적용해야됨
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      log(error.toString());
      _pagingController.error = error;
    }
  }

  Future<List<Item>> _getPage(int page) async {
    String _tag = _storage.getItem("current_tag");
    // TODO URL 바꿔라
    var _response = await http.get(Uri.parse(
        'https://team-argo.run.goorm.io/push/tag/${_tag}/page/${page}'));

    if (_response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Future(() => Item.jsonToItems(jsonDecode(_response.body)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
