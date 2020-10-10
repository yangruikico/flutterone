import 'package:TATO/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyBoxApp());
}

class MyBoxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "e",
      theme: ThemeData(
          primaryColor: Color(0xff4fffff),
          visualDensity: VisualDensity.adaptivePlatformDensity),

      home: MyBoxAppPage(title: 'Flutter Demo Home Page'),

    );
  }
}

class MyBoxAppPage extends StatelessWidget {


  final String title;
  Widget redBox = DecoratedBox(
    decoration: BoxDecoration(color: Colors.blue),

  );


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 50,
        minHeight: 50.0
      ),

      child:redBox
    );
  }

  MyBoxAppPage({Key key, this.title}) : super(key: key);
}
