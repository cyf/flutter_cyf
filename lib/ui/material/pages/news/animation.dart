import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  final String headerTitle;

  const AnimationPage({Key key, this.headerTitle}) : super(key: key);

  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.headerTitle ?? "AnimationPage"),
      ),
      body: Container(
        child: Text("AnimationPage"),
      ),
    );
  }

}
