import 'package:TATO/config/theme_color.dart';
import 'package:flutter/material.dart';

class MyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: ThemeColors.hbBtnGradientFirstColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyBody());

  }
}

List listData = [
  {
    "title": "标题1",
    "subTitle": "副标题",
    "iamge":
        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586769048019&di=cf952359b63fd6a90ab57c7662c875a0&imgtype=0&src=http%3A%2F%2Fpic1.zhimg.com%2F50%2Fv2-2f3dfd6f7da18983fd5a4e48747d7ee3_hd.jpg"
  },
  {
    "title": "标题2",
    "subTitle": "副标题",
    "iamge":
        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586769048019&di=cf952359b63fd6a90ab57c7662c875a0&imgtype=0&src=http%3A%2F%2Fpic1.zhimg.com%2F50%2Fv2-2f3dfd6f7da18983fd5a4e48747d7ee3_hd.jpg"
  },
  {
    "title": "标题3",
    "subTitle": "副标题",
    "iamge":
        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586769048019&di=cf952359b63fd6a90ab57c7662c875a0&imgtype=0&src=http%3A%2F%2Fpic1.zhimg.com%2F50%2Fv2-2f3dfd6f7da18983fd5a4e48747d7ee3_hd.jpg"
  }
];

class MyBody extends StatelessWidget {
  List<Widget> _MyBody() {
    var list = listData.map((value) {
      return ListTile(
          title: Text(value["title"]),
          subtitle: Text(
            value["subTitle"],
            style: (TextStyle(color: ThemeColors.passwordWeak, fontSize: 30)),
          ),
          leading: Image.network(
            value["iamge"],
            color: ThemeColors.balance_coin_gradie,
            height: 200,
            width: 300,
            fit: BoxFit.fill,
          ));
    });
    return list.toList();
  }







  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://img.zcool.cn/community/0372d195ac1cd55a8012062e3b16810.jpg'),
              fit: BoxFit.none,
            )
        ),
        child:Scaffold(

          backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
          appBar: AppBar(
            backgroundColor: ThemeColors.marketPriceUpColor, //把appbar的背景色改成透明
            // elevation: 0,//appbar的阴影
            title: Text("widget.title"),
          ),
          body:  Stack(
            alignment:Alignment.centerLeft , //指定未定位或部分定位widget的对齐方式
            children: <Widget>[

              ListView(
                children: this._MyBody(),
              )
              ,Text(
                '文本测试',
                style: TextStyle(color:Color(0xffc8c8c8)),
              ),




            ],
          ),
        ));
  }
}
