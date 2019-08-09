import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_app/model/book_recommend.dart';
import 'package:flutter_app/model/feed_books.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> items = new List<String>.generate(30, (i) => "第$i行");

  List<String> icons = new List<String>();
  List<RecommendBean> cardbeanList = List<RecommendBean>();
  List<RecommendBean> cardbeanList2 = List<RecommendBean>();

  FeedBooksBean feedBooksBean;

  Dio _dio;

  int pageNo = 1;
  int pageSize = 10;

  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        pageNo++;
        _getMoreData();
      }
    });

    _dio = Dio();
    BaseOptions options = new BaseOptions();
    options.responseType = ResponseType.plain;
    _dio.options = options;
    _getHttp();
    getFeedBooks();
  }

  @override
  Widget build(BuildContext context) {
    final CustomArgumnets customArgumnets =
        ModalRoute
            .of(context)
            .settings
            .arguments;
    if (icons.length == 0) {
      icons.add("assets/images/1.png");
      icons.add("assets/images/2.png");
      icons.add("assets/images/3.png");
      icons.add("assets/images/4.png");
      icons.add("assets/images/5.png");
      icons.add("assets/images/6.png");
      icons.add("assets/images/6.png");
      icons.add("assets/images/6.png");
    }
    return Scaffold(
      backgroundColor: Color(int.parse("0xffF8F8F8")),
      appBar: AppBar(
          leading: IconButton(
              icon: Container(
                child: Image.asset(
                  "assets/images/ic_back.png",
                  width: 20,
                  height: 20,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          elevation: 0,
          centerTitle: true,
          title: Text(customArgumnets.content,
              style: TextStyle(
                  color: Color(int.parse("0xff333333")),
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          brightness: Brightness.light,
          backgroundColor: Color(int.parse("0xffF8F8F8"))),

      body: Container(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
//              controller: _scrollController,
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                    child: Text("今日推荐",
                        style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  //-------------------横向列表
                  Container(
                      height: 167,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cardbeanList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 137,
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(4.0)),
                                  image: new DecorationImage(
                                    image: new ExactAssetImage(icons[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                width: 105,
                                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: _getText(index),
                              ),
                              Container(
                                width: 105,
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Text(
                                  cardbeanList[index].title,
                                  style: TextStyle(
                                    color: Color(int.parse("0xFF333333")),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          );
                        },
                      )),
                  //
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
                    height: 20,
                    child: Divider(
                      color: Color(int.parse("0xFFE0E0E0")),
                      height: 16,
                    ),
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                    child: Text("0-2岁",
                        style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  _getList(),
                ],
              )),
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    cardbeanList.clear();
    await _getHttp();
    return null;
  }

  Widget _getList() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: ListView.builder(
        shrinkWrap: true,
        physics: new NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: cardbeanList2.length,
        itemBuilder: (context, index) {
          return Container(
            height: 150,
            child: _createListItem(index),
          );
        },
      ),
    );
  }

  Widget _createListItem(int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Stack(
        alignment: const FractionalOffset(0.0, 0.0),
        children: <Widget>[
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            padding: EdgeInsets.fromLTRB(0, 35, 0, 0),
            child: Container(
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(4.0)),
                image: new DecorationImage(
                  image: new ExactAssetImage(
                      "assets/images/item_book_list_back.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                margin: EdgeInsets.fromLTRB(125, 20, 16, 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(cardbeanList2[index].title,
                        style: TextStyle(
                            color: Color(int.parse("0xFF333333")),
                            fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    Text(
                      cardbeanList2[index].briefIntro,
                      style: TextStyle(
                          color: Color(int.parse("0xFF666666")), fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 105,
            height: 140,
            margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
            padding: EdgeInsets.fromLTRB(20, 12, 12, 12),
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(new Radius.circular(4.0)),
              image: new DecorationImage(
                image: new ExactAssetImage(icons[index]),
                fit: BoxFit.cover,
              ),
            ),
            child: Text(cardbeanList2[index].title,
                style: TextStyle(color: Colors.white, fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }

  Widget _getText(int index) {
    if (index % 3 == 0) {
      return Container(
        padding: EdgeInsets.fromLTRB(18, 25, 10, 20),
        child: Text(
          cardbeanList[index].title,
          style: TextStyle(color: Colors.white),
        ),
      );
    } else if (index % 3 == 1) {
      return Container(
        padding: EdgeInsets.fromLTRB(18, 25, 10, 20),
        child: Text(
          cardbeanList[index].title,
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.fromLTRB(18, 25, 10, 20),
        child: Text(
          cardbeanList[index].title,
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }

  void _getHttp() async {
    List books;
    try {
      Response response = await _dio.get(
          "http://114.55.172.160:28080/v1/children-stories/0-2/recommended");
      if (response.statusCode == HttpStatus.OK) {
        books = json.decode(response.data.toString());
        setState(() {
          cardbeanList =
              books.map((m) => new RecommendBean.fromJson(m)).toList();
        });
        print(response);
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: "HttpStatus.end  $e");
    }
  }

  void getFeedBooks() async {
    try {
      Response response = await _dio.get(
          "http://114.55.172.160:28080/v1/children-stories/0-2/feed?pageNo=$pageNo&pageSize=$pageSize");
      if (response.statusCode == HttpStatus.OK) {
        setState(() {
            feedBooksBean = FeedBooksBean.fromJson(json.decode(response.data.toString()));
            cardbeanList2.addAll(feedBooksBean.list);
        });
        print(response);
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: "HttpStatus.end  $e");
    }
  }

  _getMoreData() async {
    if (!isPerformingRequest) {
      setState(() {
        isPerformingRequest = true;
      });
      getFeedBooks();
      setState(() {
        isPerformingRequest = false;
      });
    }
  }
}



// ignore: class_in_class
class CustomArgumnets {
  String content;

  CustomArgumnets(this.content);
}
