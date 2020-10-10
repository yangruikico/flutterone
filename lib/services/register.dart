import 'dart:ffi';

import 'package:TATO/moudle/entity/notice_entity.dart';
import 'package:TATO/moudle/entity/user_entity.dart';
import 'package:TATO/moudle/form/user.dart';
import 'package:TATO/moudle/state/app_state.dart';
import 'package:TATO/services/weiguan.dart';
import 'package:TATO/util/factory.dart';
import 'package:flutter/cupertino.dart';

class Register {

  Future accountLoginAction(UserLoginForm form,
      {Function(UserEntity) onSuccess, Function(NoticeEntity) onFailed}) async {
    final wgService = await WgFactory().getWgService();
    final response =
        await wgService.post('/account/login', data: form.toJson());

    if (response.code == WgApiResponse.codeOk) {
      final user = UserEntity.fromMap(response.data['user']);
      if (onSuccess != null) {
        onSuccess(user);
      }
    } else {
      if (onFailed != null) {
        var noticeEntity = NoticeEntity();
        noticeEntity.message = response.message;
        onFailed(noticeEntity);
      }
    }
  }
}
