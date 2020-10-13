/// username : "qq"
/// password : "qq"

class UserEntity {

  String username;
  String password;
  String avatar;

  UserEntity({this.username, this.password});

  static UserEntity fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    UserEntity userBean = UserEntity();
    userBean.username = map['username'];
    userBean.password = map['password'];
    userBean.avatar = map['avatar'];
    return userBean;
  }

  Map toJson() => {
    "username": username,
    "password": password,
    "avatar": avatar,
  };
}