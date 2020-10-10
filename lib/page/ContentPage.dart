import 'package:TATO/page/profile/profile_page.dart';

import 'card_free.dart';
import 'card_share.dart';
import 'card_special.dart';
import 'file:///D:/code/flutter_app/lib/page/card_recommend.dart';
import 'package:TATO/tab/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class ContentPage extends StatefulWidget {
  final ValueChanged<int> onPageChange;
  final ContentPagerController contentPagerController;

  //构造方法 可选参数
  const ContentPage({Key key, this.onPageChange, this.contentPagerController})
      : super(key: key);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  static List<Color> _colors = [
    Colors.blue,
    Colors.red,
    Colors.grey,
    Colors.orange,
  ];

  PageController _pageController = PageController(viewportFraction: 1.0);

  @override
  void initState() {
    if (widget.contentPagerController != null) {
      widget.contentPagerController._pageController = _pageController;
    }
    _statusBar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //appbar
        Visibility(
          visible: false,
          child: CustomAppbar(),
        ),
        Expanded(
          //撑开高度
            child: PageView(
              onPageChanged: widget.onPageChange,
              controller: _pageController,
              children: <Widget>[
                _warpItem(CardRecommend()),
                _warpItem(CardShare()),
                _warpItem(CardFree()),
                _warpItem(ProfilePage()),//ListPage(items: new List<String>.generate(100, (index) => "item$index") )
              ],
            )),
      ],
    );
  }

  Widget _warpItem(Widget widget) {
    return Padding(
      padding: EdgeInsets.only(left: 15,top: 20,right: 15,bottom: 20),
      child:widget,
    );
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
}

//内容区控制器
class ContentPagerController {
  PageController _pageController;

  void jumpToPage(int page) {
    _pageController?.jumpToPage(page);
  }
}
