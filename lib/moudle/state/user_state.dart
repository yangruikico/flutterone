class UserState {

  String username;
  String password;

  static UserState fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    UserState userBean = UserState();
    userBean.username = map['username'];
    userBean.password = map['password'];
    return userBean;
  }

  Map toJson() => {
    "username": username,
    "password": password,
  };
}