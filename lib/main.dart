import 'dart:convert';

import 'package:TATO/config/flag_key.dart';
import 'package:TATO/page/device_uuid_util.dart';
import 'package:TATO/page/home.dart';
import 'package:TATO/user_info_provide.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login/login.dart';
import 'moudle/entity/user_entity.dart';

/*void main() async {

  ChangeNotifierProvider<UserInfoProvide>(
    create: (context) => UserInfoProvide(),
  );

  runApp(MyApp());

}*/

main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(ChangeNotifierProvider<UserInfoProvide>.value(
    value: UserInfoProvide(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //页面初始化状态的方法
  @override
  void initState() {
    super.initState();
    //开启倒计时
    initUser();
    countDown();
  }

  void countDown() {
    //设置倒计时三秒后执行跳转方法

    DeviceUtil.getDeviceInfo().then((value) {
      print('yangrui affte2r' + value);
    });

    var duration = new Duration(seconds: 1);
    new Future.delayed(duration, goToHomePage);
  }

  void goToHomePage() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var bool = _prefs.getBool(FlagKey.ISLOGIN);
    if (bool!=null&&bool) {//bool!=null&&bool
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomePage();
      }));
    } else {

      Navigator.pushAndRemoveUntil(
        context,
        new MaterialPageRoute(builder: (context) => new LoginPage()),
            (route) => route == null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/splash_bg.GIF",
              fit: BoxFit.cover,
              width: 350,
              height: 700,
            ),
          ],
        ),
      ),
    );
  }


  void initUser() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String user  = _prefs.getString(FlagKey.USER);
    var bool = _prefs.getBool(FlagKey.ISLOGIN);
    if (bool!=null&&bool) {
      UserEntity mUserEntity=UserEntity.fromMap(json.decode(user));
      Provider.of<UserInfoProvide>(context, listen: false).userEntity = mUserEntity;
      print("yangrui::${mUserEntity.username}");
    }



    }

}
