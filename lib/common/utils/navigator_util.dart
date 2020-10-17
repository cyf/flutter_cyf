import 'package:flutter/material.dart';

///
class NavigatorUtil {
  static push(BuildContext context, Widget widget) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => widget));
  }

  static pop(BuildContext context) {
    Navigator.pop(context);
  }
}
