import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:popup_window/popup_window.dart';

class FaceControl extends StatefulWidget {
  @override
  _FaceControlState createState() => _FaceControlState();
}

class _FaceControlState extends State<FaceControl> {
  var controller;
  var tabs = <Tab>[
    Tab(
      child: Text("我创建的"),
    ),
    Tab(
      child: Text("邀请我的"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    //
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          primary: true,
          //为false的时候会影响leading，actions、titile组件，导致向上偏移
          textTheme: TextTheme(//设置AppBar上面各种字体主题色
//            title: TextStyle(color: Colors.red),
              ),
          actionsIconTheme: IconThemeData(color: Colors.white, opacity: 1),
          //设置导航右边图标的主题色，此时iconTheme对于右边图标颜色会失效
          iconTheme: IconThemeData(color: Colors.white, opacity: 1),
          //设置AppBar上面Icon的主题颜色
          brightness: Brightness.light,
          //设置导航条上面的状态栏显示字体颜色
          backgroundColor: Colors.blue,
          elevation: 0,
          //设置背景颜色
//          shape: CircleBorder(side: BorderSide(color: Colors.red, width: 5, style: BorderStyle.solid)),//设置appbar形状
//          automaticallyImplyLeading: true,//在leading为null的时候失效

//          bottom: PreferredSize(child: Text('data'), preferredSize: Size(30, 30)),//出现在导航条底部的按钮

          centerTitle: true,
          title: Text('布控任务'),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                print('add click....');
              }),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  print('search....');
                }),
          ],
        ),
        body: DefaultTabController(
          length: tabs.length,
          child: Scaffold(

            appBar: AppBar(
              primary: true,
              //为false的时候会影响leading，actions、titile组件，导致向上偏移
              textTheme: TextTheme(//设置AppBar上面各种字体主题色
//            title: TextStyle(color: Colors.red),
                  ),
              actionsIconTheme: IconThemeData(color: Colors.white, opacity: 1),
              //设置导航右边图标的主题色，此时iconTheme对于右边图标颜色会失效
              iconTheme: IconThemeData(color: Colors.white, opacity: 1),
              //设置AppBar上面Icon的主题颜色
              brightness: Brightness.dark,
              //设置导航条上面的状态栏显示字体颜色
              elevation: 0,
              backgroundColor: Colors.blue,
              //设置背景颜色
//          shape: CircleBorder(side: BorderSide(color: Colors.red, width: 5, style: BorderStyle.solid)),//设置appbar形状
//          automaticallyImplyLeading: true,//在leading为null的时候失效

//          bottom: PreferredSize(child: Text('data'), preferredSize: Size(30, 30)),//出现在导航条底部的按钮
              centerTitle: true,
              title: TabBar(
                  isScrollable: true,
                  onTap: (int index) {
                    print('Selected......$index');
                  },
                  unselectedLabelColor: Color(0xffcccccc),
                  //设置未选中时的字体颜色，tabs里面的字体样式优先级最高
                  unselectedLabelStyle: TextStyle(fontSize: 16),
                  //设置未选中时的字体样式，tabs里面的字体样式优先级最高
                  labelColor: Colors.white,
                  //设置选中时的字体颜色，tabs里面的字体样式优先级最高
                  labelStyle: TextStyle(fontSize: 16),
                  //设置选中时的字体样式，tabs里面的字体样式优先级最高

                  indicatorColor: Colors.white,
                  //选中下划线的颜色
                  indicatorSize: TabBarIndicatorSize.label,
                  //选中下划线的长度，label时跟文字内容长度一样，tab时跟一个Tab的长度一样
                  indicatorWeight: 4.0,
                  //选中下划线的高度，值越大高度越高，默认为2。0
//                indicator: BoxDecoration(),//用于设定选中状态下的展示样式
                  tabs: List.generate(tabs.length, (index) => tabs[index])),

              leading:PopupWindowButton(
                offset: Offset(0, 500),
                child: Icon(Icons.sort),
                window: Container(
                  padding: EdgeInsets.all(50),
                  color: Color.fromARGB(10, 146, 147, 151),
                  height: 150,
                  child: Container(
                    color: Colors.white,
                    height: 50,
                  ) ,
                ),
              ),
            ),
            body: TabBarView(
              children: tabs
                  .map((e) => ListView.builder(
                      itemBuilder: (context, int) => Column(
                            children: <Widget>[


                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.grey[300],
                                      ),
                                    ]),
                                height: 85,
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.pink,
                                                  width: 1.0),
                                              borderRadius:
                                                  BorderRadius.circular(60)),
                                          child: ClipOval(
                                            child: Image.network(
                                              'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598959319835&di=cb0ec0e548ae2e0cc6e328644ef61c40&imgtype=0&src=http%3A%2F%2Ft8.baidu.com%2Fit%2Fu%3D3571592872%2C3353494284%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1200%26h%3D1290',
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          )),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 17, bottom: 17),
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: Text('汉口火车站重点防控人员',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black)),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "汉口火车站重点防控人员,在军运会期间严格检查人员的身份",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Expanded(
                                        flex: 1,
                                        child: Text('03-01'),
                                      ),
                                    ),
                                  ],
                                ),
                              )


                            ],
                          ), //Text('${int}')
                      itemCount: (20)))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _statusBar();
    super.initState();
  }
}

_statusBar() {
  SystemUiOverlayStyle uiOverlayStyle = SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFF000000),
    systemNavigationBarDividerColor: null,
    statusBarColor: null,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  );

  SystemChrome.setSystemUIOverlayStyle(uiOverlayStyle);
}
