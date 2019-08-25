import 'package:flutter/material.dart';

class LoadingWidgetFul extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoadingWidget();
}

class _LoadingWidget extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Loading'),
          new CircularProgressIndicator(),
        ],
      ),
    ));
  }
}
