import 'package:agroa_video_demo/call_video_widget.dart';
import 'package:agroa_video_demo/main.dart';
import 'package:flutter/material.dart';

/// 全局获取 context
getGlobalContext() {
  // Future.delayed(Duration(seconds: 0)).then((onValue) {

  // });
  BuildContext context = navigatorKey.currentState.overlay.context;
  return context;
}
class OverLayWidget{
  Offset offset = Offset(0, 0);
  final double height = 80;
  bool isShowBigWidget =false;
  ///显示悬浮控件
  showFloating(BuildContext context) {
    var overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;
    overlayEntry = new OverlayEntry(builder: (context) {
      return Stack(
        children: <Widget>[
          new Positioned(
            left: isShowBigWidget?offset.dx:0,
            top: isShowBigWidget?offset.dy:0,
            child: _buildFloating(overlayEntry),
          ),
        ],
      );
    });
    ///插入全局悬浮控件
    overlayState.insert(overlayEntry);
  }

  ///绘制悬浮控件
  _buildFloating(OverlayEntry overlayEntry) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onPanDown: (details) {
        if (isShowBigWidget) { offset = details.globalPosition - Offset(height / 2, height / 2);
        overlayEntry.markNeedsBuild(); }
      },
      onPanUpdate: (DragUpdateDetails details) {
        if (isShowBigWidget) {
          ///根据触摸修改悬浮控件偏移
          offset = offset + details.delta;
          overlayEntry.markNeedsBuild();
        }
      },
      onLongPress: () {
        overlayEntry.remove();
      },
      child:
        Material(
        color: Colors.blue,
        child: CustomCallVideoWidget(),
      ),
    );
  }
}

