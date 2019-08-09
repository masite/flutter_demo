import 'dart:convert';
import 'package:flutter_app/model/book_recommend.dart';
class FeedBooksBean{
  bool more;
  int total;
  List<RecommendBean> list;

  FeedBooksBean(this.more, this.total, this.list);

  factory FeedBooksBean.fromJson(Map<String, dynamic> json2) {
    final originList = json2["list"] as List;
    List<RecommendBean> studentList =
    originList.map((value) => RecommendBean.fromJson(value)).toList();
    return FeedBooksBean(json2["more"],json2["total"],studentList);
  }

}
