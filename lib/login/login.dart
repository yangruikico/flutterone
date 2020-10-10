import 'dart:convert';
import 'dart:math';

import 'package:TATO/config/flag_key.dart';
import 'package:TATO/moudle/entity/notice_entity.dart';
import 'package:TATO/moudle/entity/user_entity.dart';
import 'package:TATO/moudle/form/user.dart';
import 'package:TATO/page/base_widget.dart';
import 'package:TATO/page/home.dart';
import 'package:TATO/services/register.dart';
import 'package:TATO/user_info_provide.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends BaseWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends BaseWidgetState {
  static final _formKey = GlobalKey<FormState>();

  FocusNode _passwordFocusNode;
  var _form = UserLoginForm();

  @override
  void initState() {
    title = '登录';
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();

    super.dispose();
  }

  void _submit() async{
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      //请求网络,onSuccess:(UserEntity userEntity){
      //
      //
      //       }, onFailed:(NoticeEntity noticeEntity){},

   /*   Register().accountLoginAction(_form,
          onSuccess: (UserEntity userEntity) {},
          onFailed: (NoticeEntity noticeEntity) {});*/


      saveUser(UserEntity(username: _form.username, password: _form.password));


    }




    /* showModalBottomSheet(
       context: context,
       builder: (BuildContext context) {
         return Container(
           height: 200,
           color: Colors.amber,
         );
       });*/
  }


  Future<void>  saveUser(UserEntity userEntity) async {

    SharedPreferences _prefs = await SharedPreferences.getInstance();

    Provider.of<UserInfoProvide>(context,listen: false).updateUserInfo(username: _form.username, password: _form.password.toString());

    _prefs.setBool(FlagKey.ISLOGIN, true);

    _prefs.setString(FlagKey.USER, json.encode(userEntity.toJson())).then((value) {
      Navigator.push( context,
            MaterialPageRoute(builder: (context) {
              return HomePage();
            }));
    });



  }


  @override
  body() {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ListView(
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      onSaved: (value) => _form.username = value,
                      onFieldSubmitted: (value) => FocusScope.of(context)
                          .requestFocus(_passwordFocusNode),
                      decoration: InputDecoration(
                        icon: Icon(Icons.account_circle),
                        hintText: '用户名、手机或邮箱',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return '请输入用户名';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      focusNode: _passwordFocusNode,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      onSaved: (value) => _form.password = value,
                      onFieldSubmitted: (value) => _submit(),
                      decoration: InputDecoration(
                        icon: Icon(Icons.vpn_key),
                        hintText: '密码',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return '请输入密码';
                        }
                        return null;
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: RaisedButton(
                        padding: EdgeInsets.all(6),
                        onPressed: _submit,
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          '登录',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .button
                              .copyWith(
                                fontSize: 16,
                                letterSpacing: 32,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '还没有帐号？',
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(color: Theme.of(context).hintColor),
              ),
              FlatButton(
                onPressed: () {},
                child: Text(
                  '注册一个',
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
