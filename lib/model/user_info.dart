class UserInfo {
  String username;
  int id;
  String avatarPic;

  UserInfo({
    this.avatarPic,
    this.id,
    this.username,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
        avatarPic: json['avatar'],
        id: int.parse(json['userId']),
        username: json['nickName']);
  }
}