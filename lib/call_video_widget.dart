import 'package:flutter/material.dart';

class CustomCallVideoWidget extends StatefulWidget {
  CustomCallVideoWidget({Key key}) : super(key: key);

  @override
  _CustomCallVideoWidgetState createState() => _CustomCallVideoWidgetState();
}

class _CustomCallVideoWidgetState extends State<CustomCallVideoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
          height: 300,
          width: 300,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.all(Radius.circular(100 / 2))),
          child: new Text(
            "长按\n移除",
            style: TextStyle(color: Colors.white),
          ),
        
    );
  }
}
