import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'ContentPage.dart';
import 'align_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _defaultColor = Color(0xff000000);
  final _activeColor = Color(0xFF42A5F5);
  int _currentIndex = 0;

  final ContentPagerController _contentPagerController =
      ContentPagerController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    //    // by the _incrementCounter method above.
    //    //
    //    // The Flutter framework has been optimized to make rerunning build methods
    //    // fast, so that you can just rebuild anything that needs updating rather
    //    // than having to individually change instances of widgets.
    return new Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xffedeef0),
            Color(0xffe6e7e9),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Stack(
          children: <Widget>[
            ContentPage(
              contentPagerController: _contentPagerController,
              onPageChange: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            Container(
                width: 200,
                height: 180,
                alignment: Alignment.centerLeft,
                color: Colors.transparent,
                child:Visibility(
                  visible: false,
                  child: GestureDetector(
                    child: Align(
                      alignment: Alignment.centerRight,

                      child: Text(
                        "进入",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(builder: (context) => AlignPage()),
                      );
                    },
                  ),
                ) )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _contentPagerController.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          _bottomItem('本周', Icons.folder, 0),
          _bottomItem('分享', Icons.explore, 1),
          _bottomItem('免费', Icons.donut_small, 2),
          _bottomItem('动态', Icons.explore, 3),
          _bottomItem('我的', Icons.person, 4),
        ],
      ),
    );
  }

  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
        icon: Icon(icon, color: _defaultColor),
        activeIcon: Icon(icon, color: _activeColor),
        title: Text(
          title,
          style: TextStyle(
              color: _currentIndex != index ? _defaultColor : _activeColor),
        ));
  }
}
