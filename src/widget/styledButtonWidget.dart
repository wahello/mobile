import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class StyledButtonWidget extends StatelessWidget {
  final String route;
  final String hint;
  @required
  final VoidCallback onPressed;

  StyledButtonWidget({this.onPressed, route, hint})
      : route = route ?? '',
        hint = hint ?? '';

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.symmetric(vertical: 16.0),
      child: new RaisedButton(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(24),
        ),
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          }
        },
        padding: new EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text(hint, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
