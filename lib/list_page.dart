import 'package:TATO/align_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  final List<String> items;

  ListPage({Key key, this.items});

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("list widget"),
        ),
        body: Center(
          child: Container(
            height: 200,
            child: ListView.builder(
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {



                    },
                    title: Text('${widget.items[index]}'),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Container(
          width: 180,
          color: Colors.lightBlue,

        ),
        Container(
          width: 180,
          color: Colors.black,
        ),
        Container(
          width: 180,
          color: Colors.amber,
        ),
        Container(
          width: 180,
          color: Colors.blueGrey,
        ),
        Container(
          width: 180,
          color: Colors.deepOrange,
          child: RaisedButton(
            onPressed: (){

            },
          ),
        ),
      ],
    );
  }
}
