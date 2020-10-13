/// username : "qq"
/// password : "qq"

class UserEntity {

  String username;
  String password;
  String avatar;

  UserEntity({this.username, this.password, this.avatar="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1602579488919&di=071fb3fa2807918b7b01e991cfbd31f5&imgtype=0&src=http%3A%2F%2Ft9.baidu.com%2Fit%2Fu%3D3363001160%2C1163944807%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1280%26h%3D830"});

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