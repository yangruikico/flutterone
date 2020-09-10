import 'package:TATO/base_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardSpecial extends BaseCard {
  @override
  _CardSpecialState createState() => _CardSpecialState();
}

class _CardSpecialState extends BaseCardState {
  @override
  void initState() {
    bottomTitleColor = Colors.blue;
    super.initState();
  }

  @override
  topContent() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 66, right: 66, top: 36, bottom: 36),
          decoration: BoxDecoration(color: Color(0Xfffffcf7)),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.grey, blurRadius: 20, offset: Offset(0, 10))
            ]),
            child: Image.network(
                "http://www.devio.org/io/flutter_beauty/changan_book.jpg"),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, top: 15, right: 20, bottom: 15),
          decoration: BoxDecoration(color: Color(0xfff7f3ea)),
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "长安十二时辰...",
                    style: TextStyle(fontSize: 18, color: Color(0xff473b25)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      '马伯庸',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13, color: Color(0xff473b25)),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 25),
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        colors: [Color(0xffd9bc82), Color(0xffecd9ae)])),
                child: Text(
                  '分享免费领取',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  bottomContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, //水平撑开
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  'http://www.devio.org/io/flutter_beauty/double_quotes.jpg',
                  width: 26,
                  height: 26,
                ),
                Text('揭露历史真相')
              ],
            ),
          ),
          bottomTitle("更多领取方式")
        ],
      ),
    );
  }
}
