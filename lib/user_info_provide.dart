import 'dart:convert';

import 'package:TATO/moudle/entity/user_entity.dart';
import 'package:TATO/page/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/flag_key.dart';

class UserInfoProvide with ChangeNotifier {

  UserEntity userEntity;



  updateUserInfo ({String username, String password}) async{
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

  get getUser => userEntity; //3

}
