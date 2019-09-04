import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
void main() => runApp(MyApp(initParams: window.defaultRouteName));

class MyApp extends StatelessWidget {

  final String initParams;
  // This widget is the root of your application.

  const MyApp({Key key, this.initParams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 混合开发',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Flutter 混合开发', initParams: initParams),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.initParams}) : super(key: key);

  final String title;
  final String initParams;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const EventChannel _eventChannelPlugin =
      EventChannel('eventChannelPlugin');
  static const MethodChannel _methodChannelPlugin =
      MethodChannel('methodChannelPlugin');
  static const BasicMessageChannel<String> _basicMessageChannel =
      const BasicMessageChannel('BasicMessageChannelPlugin', StringCodec());
  String showMessage = '';
  StreamSubscription _streamSubscription;
  bool _isMethodPlugin = false;
  @override
  void initState() {
      _streamSubscription = _eventChannelPlugin
          .receiveBroadcastStream('123')
          .listen(_onToDart, onError: _onDartError);
      super.initState();
      _basicMessageChannel.setMessageHandler((String message) => Future<String>(() {
          setState(() {
              showMessage = '_basicMessageChannel: $message';
          });
          return '收到Native的消息：' + message;
      }));
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
  void _onToDart(message) {
    setState(() {
      showMessage = message;
    });
  }

  void _onDartError(err) {
    print('err is $err');
  }

  void _onChannelChange(bool value) => setState(() => _isMethodPlugin = value );

  void _onTextChanged(value) async {
    String response;
    try{
      if(_isMethodPlugin) {
        response = await _methodChannelPlugin.invokeMethod('send', value);
      }else {
        response = await _basicMessageChannel.send(value);
      }
    } on PlatformException catch(e){
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(color: Colors.lightBlue),
        margin: EdgeInsets.only(top: 70.0),
        child: Column(
          children: <Widget>[
            SwitchListTile(
              value: _isMethodPlugin,
              onChanged: _onChannelChange,
              title: Text(_isMethodPlugin
                  ? 'MethodChannelPlugin'
                  : 'BasicMessageChannelPlugin'
              )
            ),
            TextField(
              onChanged: _onTextChanged,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)
                )
              ),
            ),
            Text(
              '收到初始化参数：${widget.initParams}'
            ),
            Text(
              'Native传的消息：' + showMessage
            )
          ],
        ),
      )
    );
  }
}
