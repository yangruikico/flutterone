import 'dart:convert';
import 'package:TATO/config/flag_key.dart';
import 'package:TATO/moudle/entity/user_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../user_info_provide.dart';
import '../text_input.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Provider<UserInfoProvide>(
        create: (_) => UserInfoProvide(),
        dispose: (context, value) => value.dispose(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('profile information'),
            centerTitle: true,
            leading: Text(""),
          ),
          body: _Body(userEntity: context.watch<UserInfoProvide>().userEntity),
        ));
  }
}

class _Body extends StatefulWidget {
  final UserEntity userEntity;

  _Body({Key key, @required this.userEntity}) : super(key: key);

  @override
  _BodyState createState() => _BodyState(userEntity);
}

class _BodyState extends State<_Body> {
  UserEntity userEntity;

  _BodyState(this.userEntity);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TextInputPage(
                          title: '设置用户名',
                          hintText: '2-20 个中英文字符',
                          initialValue: userEntity.username,
                          validator: (value) {
                            if (value.length < 2 || value.length > 20) {
                              return '长度不符合要求';
                            }
                            return null;
                          },
                          onSubmit: (
                                  {String value,
                                  Function() onSuccess,
                                  Function() onFailed}) =>
                              _modifyUser(UserEntity(username: value),
                                  onSuccess, onFailed),
                        ),
                      ));
                    },
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    title: Text(
                      '用户名',
                      style: TextStyle(fontSize: 18),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          '${userEntity.username}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Icon(Icons.keyboard_arrow_right)
                      ],
                    ),
                  ),
                  Divider(height: 1),
                  ListTile(
                    onTap: () {},
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    title: Text(
                      '密码',
                      style: TextStyle(fontSize: 18),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          '${userEntity.password}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Icon(Icons.keyboard_arrow_right)
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  void _modifyUser(
      UserEntity form, Function() onSuccess, Function() onFailed) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();

      Provider.of<UserInfoProvide>(context, listen: false)//context.watch<UserInfoProvide>()
        .updateUserInfo(
            username: form.username, password: form.password.toString());
      _prefs
          .setString(FlagKey.USER, json.encode(userEntity.toJson()))
          .then((value) {
        onSuccess();
      });
    } catch (e) {
      print(e);
      onFailed();
    }
  }
}
