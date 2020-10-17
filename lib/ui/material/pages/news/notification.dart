import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  final String headerTitle;

  const NotificationPage({Key key, this.headerTitle}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.headerTitle ?? "NotificationPage"),
      ),
      body: Container(
        child: Text("NotificationPage"),
      ),
    );
  }

}
