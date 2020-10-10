
import 'package:flutter/material.dart';

import 'base_card.dart';

class CardShare extends BaseCard{
  @override
  _CardShareState createState()=>_CardShareState();
}

class _CardShareState extends BaseCardState{


  @override
  void initState() {
    bottomTitleColor=Colors.blue;
    super.initState();
  }

@override
  topTitle(String title) {
    return super.topTitle("分享得联名卡");
  }

  @override
  subTitle(String title) {
    return super.subTitle("12天会员");
  }

 @override
  bottomContent() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(color: Color(0xfff6f7f9)),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Image.network("http://www.devio.org/io/flutter_beauty/card_list.png"),
              ),
            )



            ,Container(
              alignment: AlignmentDirectional.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: bottomTitle("1995人,参与"),
              ),
            ),
          ],

        ),
      ),

    );
  }
@override
  topTitle2() {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Text(
        '/第19期',
        style: TextStyle(fontSize: 10,),
      ),
    );
  }





}