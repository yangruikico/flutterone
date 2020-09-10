import 'package:TATO/base_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


//本周推荐
class CardRecommend extends BaseCard{


  @override
  _CardRecommendState createState()=>_CardRecommendState();
}

class _CardRecommendState extends BaseCardState{


  @override
  void initState() {
    subTitleColor=Colors.red;
    super.initState();
  }



  @override
  topTitle(String title) {
    return super.topTitle('本周推荐');
  }

  @override
  Widget subTitle(String title) {
    return super.subTitle('送你一天无限卡·全场书籍免费读 >');
  }

  @override
  bottomContent() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: Image.network("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598959319835&di=cb0ec0e548ae2e0cc6e328644ef61c40&imgtype=0&src=http%3A%2F%2Ft8.baidu.com%2Fit%2Fu%3D3571592872%2C3353494284%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1200%26h%3D1290",fit: BoxFit.cover),
      ),
    );
  }
}
