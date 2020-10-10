import 'package:TATO/moudle/entity/user_entity.dart';
import 'package:flutter/cupertino.dart';

class UserInfoProvide with ChangeNotifier {
 /* UserEntity userEntity;


  UserInfoProvide(this.userEntity);

  updateUserInfo({String username, String password}) {
    if (userEntity == null) {
      userEntity = UserEntity();
    }
    if (username.isNotEmpty) {
      userEntity.username = username;
    }

    if (username.isNotEmpty) {
      userEntity.password = password;
    }
    notifyListeners();
  }

  get getUser => userEntity; //3*/


  int _count;

  UserInfoProvide(this._count);

  void add() {
    _count++;
    notifyListeners();
  }

  get count => _count;
}
