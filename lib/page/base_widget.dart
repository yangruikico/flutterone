import 'package:TATO/view/select/loading_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseWidget extends StatefulWidget {
  @override
  BaseWidgetState createState() => BaseWidgetState();
}

class BaseWidgetState extends State<BaseWidget> {
  String title = "";

  bool pageState = false;

  var loading = StateView();

  @override
  Widget build(BuildContext context) {
    pageState = true;
    loading.weatherState = ViewState.loading;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Container(
              width: 40,
              height: 40,
              child: Image.asset('images/hb_copy.png'),
            ),
            onPressed: () {
              topRightPress();
            },
          )
        ],
      ),
      body: pageState ? body() : loading,
      //body: body(),
    );
  }

  body() {
    return Container();
  }

  showLoading() {
    pageState = false;
    loading.weatherState = ViewState.loading;
    setState(() {});
  }

  showEmpty() {
    pageState = false;
    loading.weatherState = ViewState.empty;
    setState(() {});
  }

  showError() {
    pageState = false;
    loading.weatherState = ViewState.error;
    setState(() {});
  }

  showContainer() {
    pageState = true;
    loading.weatherState = ViewState.loading;
    setState(() {});
  }

  void topRightPress() {
    showContainer();
  }
}
