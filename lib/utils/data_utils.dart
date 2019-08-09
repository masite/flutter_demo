import 'dart:async' show Future;
import './net_utils.dart';
import '../model/user_info.dart';
import '../api/Api.dart';

class DataUtils{
  // 登陆获取用户信息
  static Future<UserInfo> doLogin(Map<String,String> params) async{
    var response = await NetUtils.post(Api.DO_LOGIN, params);
    UserInfo userInfo = UserInfo.fromJson(response);
    return userInfo;
  }
}









