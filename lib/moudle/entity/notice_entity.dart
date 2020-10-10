/// username : "qq"
/// password : "qq"

class NoticeEntity {

  int  code;
  String message;


  static NoticeEntity fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    NoticeEntity userBean = NoticeEntity();
    userBean.code = map['code'];
    userBean.message = map['message'];
    return userBean;
  }

  Map toJson() => {
    "code": code,
    "password": message,
  };
}