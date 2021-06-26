import 'package:flutter/material.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:argonaute_push/class/class.dart' show Item;
import 'package:argonaute_push/page/push/push_detail.dart';
import 'package:argonaute_push/page/settings.dart';

class PushList extends StatefulWidget {
  const PushList({Key? key}) : super(key: key);

  @override
  _PushListState createState() => _PushListState();
}

class _PushListState extends State<PushList> {
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
        body: PagedListView<int, Item>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Item>(
            itemBuilder: _itemBuilder,
          ),
        ));
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
    // TODO
    // try {
    //   final newItems =
    //       await RemoteApi.getCharacterList(pageKey, _pageSize); //api 적용해야됨
    //   final isLastPage = newItems.length < _pageSize;
    //   if (isLastPage) {
    //     _pagingController.appendLastPage(newItems);
    //   } else {
    //     final nextPageKey = pageKey + newItems.length;
    //     _pagingController.appendPage(newItems, nextPageKey);
    //   }
    // } catch (error) {
    //   _pagingController.error = error;
    // }
  }
}
