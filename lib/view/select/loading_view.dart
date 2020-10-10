import 'package:flutter/material.dart';

enum ViewState { loading, error, empty }

class StateView extends StatelessWidget {

  ViewState weatherState;

  StateView({Key key, this.weatherState = ViewState.loading}) : super(key: key);

  String _getDesc() {
    if (weatherState == ViewState.empty) {
      return "暂无数据";
    } else if (weatherState == ViewState.error) {
      return "请求失败";
    } else {
      return "正在加载中";
    }
  }

  Widget _getWidget() {
    if (weatherState == ViewState.empty) {
      return Image.asset(
        "images/hb_face_check_ok.png",
        width: 260,
        height: 260,
      );
    } else if (weatherState == ViewState.error) {
      return Image.asset(
        "images/icon_transaction.png",
        width: 260,
        height: 260,
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      type: MaterialType.transparency,
      child: new Center(
        child: new SizedBox(
          width: 360.0,
          height: 360.0,
          child: new Container(
            width: 360.0,
            height: 360.0,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    weatherState = ViewState.loading;
                    Scaffold.of(context).setState(() { });
                  },
                  child: _getWidget(),
                ),
                new Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: new Text(
                    _getDesc(),
                    style: TextStyle(
                      color: Color(0xfff00fff),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
