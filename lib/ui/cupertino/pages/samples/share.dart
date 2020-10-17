import 'package:flutter/material.dart';

class Share extends StatefulWidget {
  final String headerTitle;

  const Share({Key key, this.headerTitle}) : super(key: key);

  @override
  _ShareState createState() => _ShareState();
}

class _ShareState extends State<Share> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.headerTitle ?? "Share"),
      ),
      body: Container(
        child: Text("Share"),
      ),
    );
  }

}
