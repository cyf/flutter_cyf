import 'package:flutter_cyf/common/app_manager.dart';
import 'package:flutter/cupertino.dart';

/// AnimatedRectPage
class AnimatedRectPage extends StatefulWidget {
  @override
  _AnimatedRectPageState createState() => _AnimatedRectPageState();
}

class _AnimatedRectPageState extends State<AnimatedRectPage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  bool reversed = false;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween<double>(begin: 14, end: 300).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (!reversed) {
            setState(() {
              reversed = true;
            });
            controller.reverse();
          }
        } else if (status == AnimationStatus.dismissed) {
          controller.stop();
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('AnimatedRectPage'),
      ),
      child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 44,
            bottom: AppManager().kBottomNavigationBarHeight + 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CupertinoButton(
                  child: Icon(
                    CupertinoIcons.play_arrow_solid,
                    color: CupertinoColors.systemBlue,
                  ),
                  onPressed: () {
                    setState(() {
                      reversed = false;
                    });
                    controller.forward();
                  }),
              AnimatedRect(
                animation: animation,
              )
            ],
          )),
    );
  }
}

class AnimatedRect extends AnimatedWidget {
  AnimatedRect({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Container(
        color: CupertinoColors.systemBlue,
        height: animation.value,
        width: animation.value,
      ),
    );
  }
}
