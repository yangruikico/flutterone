import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FaceControl extends StatefulWidget {
  @override
  _FaceControlState createState() => _FaceControlState();
}

class _FaceControlState extends State<FaceControl> {

  var controller;
  var tabs=<Tab>[
    Tab(child: Text("我创建的"),),
    Tab(child: Text("邀请我的"),),

  ];


  @override
  Widget build(BuildContext context) {
    //
    return MaterialApp(
      home: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(

            primary: true,//为false的时候会影响leading，actions、titile组件，导致向上偏移
            textTheme: TextTheme(//设置AppBar上面各种字体主题色
//            title: TextStyle(color: Colors.red),
            ),
            actionsIconTheme: IconThemeData(color: Colors.white,opacity: 1),//设置导航右边图标的主题色，此时iconTheme对于右边图标颜色会失效
            iconTheme: IconThemeData(color: Colors.white,opacity: 1),//设置AppBar上面Icon的主题颜色
            brightness: Brightness.dark,//设置导航条上面的状态栏显示字体颜色
            backgroundColor: Colors.blue,//设置背景颜色
//          shape: CircleBorder(side: BorderSide(color: Colors.red, width: 5, style: BorderStyle.solid)),//设置appbar形状
//          automaticallyImplyLeading: true,//在leading为null的时候失效

//          bottom: PreferredSize(child: Text('data'), preferredSize: Size(30, 30)),//出现在导航条底部的按钮
            bottom: TabBar(
                onTap: (int index){
                  print('Selected......$index');
                },
                unselectedLabelColor: Color(0xffcccccc),//设置未选中时的字体颜色，tabs里面的字体样式优先级最高
                unselectedLabelStyle: TextStyle(fontSize:16),//设置未选中时的字体样式，tabs里面的字体样式优先级最高
                labelColor: Colors.white,//设置选中时的字体颜色，tabs里面的字体样式优先级最高
                labelStyle: TextStyle(fontSize: 16),//设置选中时的字体样式，tabs里面的字体样式优先级最高

                indicatorColor: Colors.white,//选中下划线的颜色
                indicatorSize: TabBarIndicatorSize.label,//选中下划线的长度，label时跟文字内容长度一样，tab时跟一个Tab的长度一样
                indicatorWeight: 4.0,//选中下划线的高度，值越大高度越高，默认为2。0
//                indicator: BoxDecoration(),//用于设定选中状态下的展示样式
                tabs: tabs
            ),
            centerTitle: true,
            title: Text('布控任务'),
            leading: IconButton(
                icon: Icon(Icons.arrow_back,color: Colors.white,),
                onPressed: (){
                  print('add click....');
                }
            ),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.search,color: Colors.white,size: 30,), onPressed: (){print('search....');}),
            ],
          ),
          body: TabBarView(
              children:tabs
          ),
        ),
      ),
    );;
  }

  @override
  void initState() {
    _statusBar();
    super.initState();
  }

}


_statusBar() {
  SystemUiOverlayStyle uiOverlayStyle=SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFF000000),
    systemNavigationBarDividerColor: null,
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );

  SystemChrome.setSystemUIOverlayStyle(uiOverlayStyle);
}
