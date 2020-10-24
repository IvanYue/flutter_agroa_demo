import 'package:agroa_video_demo/agora_rtm_utils.dart';
import 'package:agroa_video_demo/overlay_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(onPressed: () {}, child: Icon(Icons.phone)),
            Row(
              children: [
                FlatButton(
                    onPressed: () {
                      AgoraRtmUtils().loginAgoraRtm('1');
                    },
                    child: Text('伞兵一号准备就绪')),
                FlatButton(
                    onPressed: () {
                      AgoraRtmUtils.sendVideoCallMsg(context, '2');
                    },
                    child: Text('伞兵一号給二號發消息')),
              ],
            ),
            Row(
              children: [
                FlatButton(
                    onPressed: () {
                      AgoraRtmUtils().loginAgoraRtm('2');
                    },
                    child: Text('伞兵二号准备就绪')),
                FlatButton(
                    onPressed: () {
                      AgoraRtmUtils.sendVideoCallMsg(context, '1');
                    },
                    child: Text('伞兵2号給1號發消息')),
              ],
            ),
            FlatButton(
                onPressed: () {
                  OverLayWidget().showFloating(context);
                },
                child: Text('显示悬浮控件'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AgoraRtmUtils().logoutAgoraRtm();
        },
        tooltip: '退出',
        child: Text('退出'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
