/// username : "qq"
/// password : "qq"

class UserLoginForm {

  String username;
  String password;
  static UserLoginForm fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    UserLoginForm userBean = UserLoginForm();
    userBean.username = map['username'];
    userBean.password = map['password'];
    return userBean;
  }

  Map toJson() => {
    "username": username,
    "password": password,
  };
}