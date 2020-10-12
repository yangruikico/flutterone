import 'package:TATO/moudle/kmon.dart';
import 'package:TATO/page/face_control.dart';
import 'package:TATO/view/select/my_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 使用该库中的 rootBundle 对象来读取 perosn.json 文件
import 'package:flutter/services.dart';

// json
import 'dart:convert';

// 异步 Future
import 'dart:async';

import 'RoundSliderTrackShape.dart';

class AlignPage extends StatefulWidget {
  @override
  _AlignPageState createState() => _AlignPageState();
}

class _AlignPageState extends State<AlignPage> {
  static const platform = const MethodChannel('samples.flutter.io/battery');
  double _sliderValue = 0;
  String _batteryLevel = 'Unknown battery level.';

  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
      print(_batteryLevel);
    });
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final  textStyle=TextStyle(
        color: Colors.red
    );
    final iconList=DefaultTextStyle.merge(child: Container(),style:textStyle);

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              width: width,
              height: 200,
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  image: DecorationImage(
                      image: AssetImage('images/login_head_bg.png'),
                      fit: BoxFit.fill)),
            ),
            Container(
              width: width,
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 35),
              decoration: BoxDecoration(
                  //beta
                  border: Border.all(
                      color: Colors.grey.shade50,
                      style: BorderStyle.solid,
                      width: 3),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: Column(
                children: <Widget>[
                  /* TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      border: InputBorder.none,
                      hintText: "手机号 用户名 邮箱",
                      hintStyle:
                      TextStyle(color: Colors.grey, fontSize: 16)),
                )*/

                  Row(
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            '账户',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                decoration: TextDecoration.none),
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              border: InputBorder.none,
                              hintText: "手机号 用户名 邮箱",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 16)),
                        ),
                      )
                    ],
                  ),
                  Container(
                      color: Colors.grey,
                      margin: EdgeInsets.only(bottom: 20),
                      child: SizedBox(
                        width: 320,
                        height: 1,
                      )),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            '密码',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                decoration: TextDecoration.none),
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              border: InputBorder.none,
                              hintText: "请输入密码",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 16)),
                        ),
                      )
                    ],
                  ),
                  Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(bottom: 10),
                      child:SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.pink, //进度条滑块左边颜色
                            inactiveTrackColor: Colors.blue, //进度条滑块右边颜色
                            trackShape: RoundSliderTrackShape(radius: 10),//进度条形状,这边自定义两头显示圆角
                            thumbColor: Colors.yellow, //滑块颜色
                            overlayColor: Colors.green, //滑块拖拽时外圈的颜色
                            overlayShape: RoundSliderOverlayShape(//可继承SliderComponentShape自定义形状
                              overlayRadius: 25, //滑块外圈大小
                            ),
                            thumbShape: RoundSliderThumbShape(//可继承SliderComponentShape自定义形状
                              disabledThumbRadius: 15, //禁用是滑块大小
                              enabledThumbRadius: 15, //滑块大小
                            ),
                            inactiveTickMarkColor: Colors.black,
                            tickMarkShape: RoundSliderTickMarkShape(//继承SliderTickMarkShape可自定义刻度形状
                              tickMarkRadius: 4.0,//刻度大小
                            ),
                            showValueIndicator: ShowValueIndicator.onlyForDiscrete,//气泡显示的形式
                            valueIndicatorColor: Colors.red,//气泡颜色
                            valueIndicatorShape: PaddleSliderValueIndicatorShape(),//气泡形状
                            valueIndicatorTextStyle: TextStyle(color: Colors.black),//气泡里值的风格
                            trackHeight: 6 //进度条宽度

                        ),
                        child: MySlider(
                          value: _sliderValue,
                          onChanged: (v) {
                            setState(() {
                              _sliderValue = v;
                            });
                          },
                          min: 0,
                          max: 100,
                          label: '$_sliderValue',
                          divisions: 20,
                          activeColor: Colors.orange,
                          inactiveColor: Colors.blue,
                        ),
                      )),
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                      child: RaisedButton(
                        onPressed: () {
                          //登录
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => FaceControl()),
                          );
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        padding: EdgeInsets.only(top: 10, bottom: 12),
                        color: Color.fromARGB(254, 96, 187, 160),
                        child: Text(
                          '登录',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10, bottom: 15),
                      child: Text(
                        '忘记密码',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            decoration: TextDecoration.none),
                      ))
                ],
              ),
            ),
            FractionallySizedBox(
              widthFactor: 1,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    width: double.infinity,
                    height: 1.0,
                    color: Color(0xFFBDBDBD),
                  ),
                  Container(
                      width: 90,
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          '第三方登录',
                          style: TextStyle(
                              fontSize: 14,
                              background: Paint()..color = Colors.white),
                        ),
                      )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  Expanded(flex: 1, child: Image.asset('images/qq.png')),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        _getBatteryLevel();
                      },
                      child: Image.asset('images/weichart.png'),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Image.asset('images/weibo.png'),
                  ), //默认是黑色,

                  //默认是黑色,
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: Text('新用户注册,登录${_batteryLevel}'),
            )
          ],
        ),
      ),
    );
  }
}

Future<String> _loadKmonBean() async {
  return await rootBundle.loadString('assets/kmon.json');
}

// 将 json 字符串解析为 Person 对象
Future<Kmon> decodePerson() async {
// 获取本地的 json 字符串
  String personJson = await _loadKmonBean();

  // 解析 json 字符串，返回的是 Map<String, dynamic> 类型
  final jsonMap = json.decode(personJson);

  Kmon person = Kmon.fromMap(jsonMap);
  print(
      'person name is ${person.status}, age is ${person.ts}, height is ${person.ch}');
  return person;
}
