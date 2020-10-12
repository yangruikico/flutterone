import 'dart:convert';

import 'package:TATO/moudle/entity/user_entity.dart';
import 'package:TATO/page/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfoProvide with ChangeNotifier {
  UserEntity userEntity;

  UserInfoProvide(this.userEntity);

  updateUserInfo({String username, String password}) async {
    print("yangrui${username.isNotEmpty}");
    if (username.isNotEmpty) {
      userEntity.username = username;
    }
    print("yangrui${password.isNotEmpty}");
    if (password.isNotEmpty && password != "null") {
      userEntity.password = password;
    }
    notifyListeners();
  }

  get getUser => userEntity; //3

}
