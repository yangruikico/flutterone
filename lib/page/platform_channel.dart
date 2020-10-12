// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:convert';
import 'dart:async';

import 'package:TATO/page/womai_channel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'animals_root.dart';


class PlatformChannel extends StatefulWidget {


  @override
  _PlatformChannelState createState() => _PlatformChannelState();
}



class _PlatformChannelState extends State<PlatformChannel> {







  static const EventChannel eventChannel =
      EventChannel(FlutterChannel.CHANNEL_RECEIVE_DATA);





  var _receive_data = '';


  @override
  void initState() {
    super.initState();

    eventChannel.receiveBroadcastStream(['arg1', 'arg2']).listen(_onEvent,
        onError: _onError);


  }

  void _onEvent(Object event) {
    var animal = json.decode(event);
    print(AnimalsRoot.fromJson(animal).animals.cat.name);
    setState(() {
      _receive_data = '$event';
    });
  }

  void _onError(Object error) {
    setState(() {
      _receive_data = 'Receive  failed';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RaisedButton(
                  child: const Text('Fetch Data'),
                  onPressed: (){

                  },
                ),
              ),
            ],
          ),
          Text(_receive_data),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: PlatformChannel()));
}
