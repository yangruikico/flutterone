/// username : "qq"
/// password : "qq"

class UserEntity {

  String username;
  String password;

  static UserEntity fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    UserEntity userBean = UserEntity();
    userBean.username = map['username'];
    userBean.password = map['password'];
    return userBean;
  }

  Map toJson() => {
    "username": username,
    "password": password,
  };
}