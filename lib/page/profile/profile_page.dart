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

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: 2, vsync: this);
  }

  void _modifyUser(
      UserEntity form, Function() onSuccess, Function() onFailed) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      Provider.of<UserInfoProvide>(context, listen: false)
          .updateUserInfo(username: form.username, password: form.password);

      print("yangrui${context.read<UserInfoProvide>().userEntity.toJson()}");

      _prefs
          .setString(FlagKey.USER,
          json.encode(context.read<UserInfoProvide>().userEntity.toJson()))
          .then((value) {
        onSuccess();
      });
    } catch (e) {
      print(e);
      onFailed();
    }
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserInfoProvide>.value(
      value: Provider.of<UserInfoProvide>(context, listen: false),
      child: Consumer<UserInfoProvide>(builder: (BuildContext context,
          UserInfoProvide mUserInfoProvide, Widget child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.blue,
                pinned: true,
                elevation: 0,
                expandedHeight: 250,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('个人资料'),
                  background: Column(
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            color: Colors.blue,
                            height: 200,
                          ),CircleAvatar(
                            //头像半径
                            radius: 40,
                            //头像图片
                            backgroundImage: NetworkImage(mUserInfoProvide.userEntity.avatar),
                          ),

                        ],
                      )
                    ],
                  ),
                ),
              ),
              /* SliverPersistentHeader(
            pinned: true,
            delegate: StickyTabBarDelegate(
              child: TabBar(
                labelColor: Colors.black,
                controller: this.tabController,
                tabs: <Widget>[
                  Tab(text: 'Home'),
                  Tab(text: 'Profile'),
                ],
              ),
            ),
          ),*/
              SliverFillRemaining(
                child: Stack(
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
                                      initialValue:
                                          mUserInfoProvide.userEntity.username,
                                      validator: (value) {
                                        if (value.length < 2 ||
                                            value.length > 20) {
                                          return '长度不符合要求';
                                        }
                                        return null;
                                      },
                                      onSubmit: (
                                              {String value,
                                              Function() onSuccess,
                                              Function() onFailed}) =>
                                          _modifyUser(
                                              UserEntity(username: value),
                                              onSuccess,
                                              onFailed),
                                    ),
                                  ));
                                },
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                title: Text(
                                  '用户名',
                                  style: TextStyle(fontSize: 18),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      '${mUserInfoProvide.userEntity.username}',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Icon(Icons.keyboard_arrow_right)
                                  ],
                                ),
                              ),
                              Divider(height: 1),
                              ListTile(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => TextInputPage(
                                      title: '设置密码',
                                      hintText: '2-20 个中英文字符',
                                      initialValue:
                                          mUserInfoProvide.userEntity.password,
                                      validator: (value) {
                                        if (value.length < 2 ||
                                            value.length > 20) {
                                          return '长度不符合要求';
                                        }
                                        return null;
                                      },
                                      onSubmit: (
                                              {String value,
                                              Function() onSuccess,
                                              Function() onFailed}) =>
                                          _modifyUser(
                                              UserEntity(password: value),
                                              onSuccess,
                                              onFailed),
                                    ),
                                  ));
                                },
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                title: Text(
                                  '密码',
                                  style: TextStyle(fontSize: 18),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      '${mUserInfoProvide.userEntity.password}',
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
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

/*{
  TabController tabController;


  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: 2);
  }

  void _modifyUser(
      UserEntity form, Function() onSuccess, Function() onFailed) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      Provider.of<UserInfoProvide>(context, listen: false)
          .updateUserInfo(username: form.username, password: form.password);

      print("yangrui${context.read<UserInfoProvide>().userEntity.toJson()}");

      _prefs
          .setString(FlagKey.USER,
              json.encode(context.read<UserInfoProvide>().userEntity.toJson()))
          .then((value) {
        onSuccess();
      });
    } catch (e) {
      print(e);
      onFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserInfoProvide>.value(
      value: Provider.of<UserInfoProvide>(context, listen: false),
      child: Consumer<UserInfoProvide>(
        builder: (BuildContext context, UserInfoProvide mUserInfoProvide,
            Widget child) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  child: SliverAppBar(
                    automaticallyImplyLeading: false,
                    forceElevated: innerBoxIsScrolled,
                    bottom: PreferredSize(
                        child: Container(),
                        preferredSize: Size.fromHeight(200)),
                    flexibleSpace: Column(
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              color: Colors.cyanAccent,
                              height: 200,
                            ),CircleAvatar(
                              //头像半径
                              radius: 40,
                              //头像图片
                              backgroundImage: NetworkImage(mUserInfoProvide.userEntity.avatar),
                            ),

                          ],
                        )

                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: StickyTabBarDelegate(child:TabBar(
                    labelColor: Colors.black,
                    controller: this.tabController,
                    tabs: <Widget>[
                      Tab(text: 'Home'),
                      Tab(text: 'Profile'),
                    ],
                  ),),
                  pinned: true,
                ),
              ];
            },
            body: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                builder: (context) => TextInputPage(
                                  title: '设置用户名',
                                  hintText: '2-20 个中英文字符',
                                  initialValue: mUserInfoProvide
                                      .userEntity.username,
                                  validator: (value) {
                                    if (value.length < 2 ||
                                        value.length > 20) {
                                      return '长度不符合要求';
                                    }
                                    return null;
                                  },
                                  onSubmit: (
                                      {String value,
                                        Function() onSuccess,
                                        Function() onFailed}) =>
                                      _modifyUser(
                                          UserEntity(username: value),
                                          onSuccess,
                                          onFailed),
                                ),
                              ));
                            },
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 10),
                            title: Text(
                              '用户名',
                              style: TextStyle(fontSize: 18),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  '${mUserInfoProvide.userEntity.username}',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Icon(Icons.keyboard_arrow_right)
                              ],
                            ),
                          ),
                          Divider(height: 1),
                          ListTile(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                builder: (context) => TextInputPage(
                                  title: '设置密码',
                                  hintText: '2-20 个中英文字符',
                                  initialValue: mUserInfoProvide
                                      .userEntity.password,
                                  validator: (value) {
                                    if (value.length < 2 ||
                                        value.length > 20) {
                                      return '长度不符合要求';
                                    }
                                    return null;
                                  },
                                  onSubmit: (
                                      {String value,
                                        Function() onSuccess,
                                        Function() onFailed}) =>
                                      _modifyUser(
                                          UserEntity(password: value),
                                          onSuccess,
                                          onFailed),
                                ),
                              ));
                            },
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 10),
                            title: Text(
                              '密码',
                              style: TextStyle(fontSize: 18),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  '${mUserInfoProvide.userEntity.password}',
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
            ),
          )


        */ /*   Scaffold(
            appBar: AppBar(
              title: Text('个人资料'),
            ),
            body: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          color: Colors.cyanAccent,
                          height: 200,
                        ),CircleAvatar(
                          //头像半径
                          radius: 40,
                          //头像图片
                          backgroundImage: NetworkImage(mUserInfoProvide.userEntity.avatar),
                        ),

                      ],
                    ),
                    Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Card(
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => TextInputPage(
                                          title: '设置用户名',
                                          hintText: '2-20 个中英文字符',
                                          initialValue: mUserInfoProvide
                                              .userEntity.username,
                                          validator: (value) {
                                            if (value.length < 2 ||
                                                value.length > 20) {
                                              return '长度不符合要求';
                                            }
                                            return null;
                                          },
                                          onSubmit: (
                                                  {String value,
                                                  Function() onSuccess,
                                                  Function() onFailed}) =>
                                              _modifyUser(
                                                  UserEntity(username: value),
                                                  onSuccess,
                                                  onFailed),
                                        ),
                                      ));
                                    },
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    title: Text(
                                      '用户名',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          '${mUserInfoProvide.userEntity.username}',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Icon(Icons.keyboard_arrow_right)
                                      ],
                                    ),
                                  ),
                                  Divider(height: 1),
                                  ListTile(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => TextInputPage(
                                          title: '设置密码',
                                          hintText: '2-20 个中英文字符',
                                          initialValue: mUserInfoProvide
                                              .userEntity.password,
                                          validator: (value) {
                                            if (value.length < 2 ||
                                                value.length > 20) {
                                              return '长度不符合要求';
                                            }
                                            return null;
                                          },
                                          onSubmit: (
                                                  {String value,
                                                  Function() onSuccess,
                                                  Function() onFailed}) =>
                                              _modifyUser(
                                                  UserEntity(password: value),
                                                  onSuccess,
                                                  onFailed),
                                        ),
                                      ));
                                    },
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    title: Text(
                                      '密码',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          '${mUserInfoProvide.userEntity.password}',
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
                    )
                  ],
                )
              ],
            ),
          )*/ /*;
        },
      ),
    );
  }
}
class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
*/
