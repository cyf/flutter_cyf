import 'package:flutter/cupertino.dart';

/// AnimatedBuilder
class AnimatedBuilderPage extends StatefulWidget {
  @override
  _AnimatedBuilderPageState createState() => _AnimatedBuilderPageState();
}

class _AnimatedBuilderPageState extends State<AnimatedBuilderPage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
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
        middle: Text('AnimatedBuilder动画'),
      ),
      child: AnimatedBuilderRectTransition(
        animation: animation,
        child: AnimatedBuilderRect(),
      ),
    );
  }
}

class AnimatedBuilderRectTransition extends StatelessWidget {
  final Animation animation;
  final Widget child;

  const AnimatedBuilderRectTransition({Key key, this.animation, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child) => Center(
        child: Container(
          width: animation.value,
          height: animation.value,
          child: child,
        ),
      ),
      child: child,
    );
  }
}

class AnimatedBuilderRect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: CupertinoColors.systemBlue,
      ),
    );
  }
}