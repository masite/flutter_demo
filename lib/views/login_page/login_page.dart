import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_app/utils/data_utils.dart';
import 'package:flutter_app/views/home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode _emailFocusNode = new FocusNode();
  FocusNode _passwordFocusNode = new FocusNode();
  FocusScopeNode _focusScopeNode = new FocusScopeNode();

  GlobalKey<FormState> _signInFormKey = new GlobalKey();
  TextEditingController _userNameEditingController =
  new TextEditingController();
  TextEditingController _passwordEditingController =
  new TextEditingController();


  bool isShowPassWord = false;
  String username = '';
  String password = '';
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  void showToast(String content) {
    Fluttertoast.showToast(
        msg: content,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Color(int.parse('0xff9E9E9E')),
        textColor: Color(int.parse('0xff666666'))
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.white,
              ),
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 35.0),
                      Image.asset(
                        'assets/images/FlutterGo.png',
                        fit: BoxFit.contain,
                        width: 100.0,
                        height: 100.0,
                      ),
                      buildSignInTextForm(),
                      buildSignInButton(),
                      SizedBox(height: 35.0),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    bottom: 0,
                    child: buildLoading(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoading() {
    if (isLoading) {
      return Opacity(
        opacity: .5,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: Colors.black,
          ),
        ),
      );
    }
    return Container();
  }

  // 创建登录界面的TextForm
  Widget buildSignInTextForm() {
    return new Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 190,
      //  * Flutter提供了一个Form widget，它可以对输入框进行分组，然后进行一些统一操作，如输入内容校验、输入框重置以及输入内容保存。
      child: new Form(
        key: _signInFormKey,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20, bottom: 20),
                child: new TextFormField(
                  controller: _userNameEditingController,
                  //关联焦点
                  focusNode: _emailFocusNode,
                  onEditingComplete: () {
                    if (_focusScopeNode == null) {
                      _focusScopeNode = FocusScope.of(context);
                    }
                    _focusScopeNode.requestFocus(_passwordFocusNode);
                  },

                  decoration: new InputDecoration(
                      icon: new Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      hintText: "Github 登录名",
                      border: InputBorder.none),
                  style: new TextStyle(fontSize: 16, color: Colors.black),
                  //验证
                  validator: (value) {
                    if (value.isEmpty) {
                      return "登录名不可为空!";
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      username = value;
                    });
                  },
                ),
              ),
            ),
            new Container(
              height: 1,
              width: MediaQuery.of(context).size.width * 0.75,
              color: Colors.grey[400],
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
                child: new TextFormField(
                  controller: _passwordEditingController,
                  focusNode: _passwordFocusNode,
                  decoration: new InputDecoration(
                    icon: new Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    hintText: "Github 登录密码",
                    border: InputBorder.none,
                    suffixIcon: new IconButton(
                      icon: new Icon(
                        Icons.remove_red_eye,
                        color: Colors.black,
                      ),
                      onPressed: showPassWord,
                    ),
                  ),
                  //输入密码，需要用*****显示
                  obscureText: !isShowPassWord,
                  style: new TextStyle(fontSize: 16, color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "密码不可为空!";
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
              ),
            ),
            new Container(
              height: 1,
              width: MediaQuery.of(context).size.width * 0.75,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  // 点击控制密码是否显示
  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  Widget buildSignInButton() {
    return new GestureDetector(
      child: new Container(
        padding: EdgeInsets.only(left: 42, right: 42, top: 10, bottom: 10),
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Theme.of(context).primaryColor),
        child: new Text(
          "LOGIN",
          style: new TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      onTap: () {
        // 利用key来获取widget的状态FormState,可以用过FormState对Form的子孙FromField进行统一的操作
        if (_signInFormKey.currentState.validate()) {
          // 如果输入都检验通过，则进行登录操作
          // Scaffold.of(context)
          //     .showSnackBar(new SnackBar(content: new Text("执行登录操作")));
          //调用所有自孩子的save回调，保存表单内容
          doLogin();
        }
      },
    );
  }

  void doLogin() {
    _signInFormKey.currentState.save();
    DataUtils.doLogin({'code': username})
        .then((result) {
      print(result);
      setState(() {
        isLoading = false;
      });

    }).catchError((onError) {
      print(onError);
      setState(() {
        isLoading = false;
      });
    });
    _navigateToSecondPage(context);


  }

  _navigateToSecondPage(BuildContext context) async {
    dynamic customArgumnets = await Navigator.pushNamed(context, '/home',
        arguments: CustomArgumnets('Android进阶之光'));//1
    print(customArgumnets.content);
  }
}
