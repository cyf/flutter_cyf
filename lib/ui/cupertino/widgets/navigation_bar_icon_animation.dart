import 'package:flutter/cupertino.dart';

/// AnimatedRectPage
class NavigationBarIconAnimation extends StatefulWidget {
  final IconData icon;
  final Color color;
  final double begin;
  final double end;
  final Duration duration;

  const NavigationBarIconAnimation({
    Key key,
    this.icon,
    this.color,
    this.begin = 14,
    this.end = 22,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  _NavigationBarIconAnimationState createState() =>
      _NavigationBarIconAnimationState();
}

class _NavigationBarIconAnimationState extends State<NavigationBarIconAnimation>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  bool reversed = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: widget.duration);
    animation =
        Tween<double>(begin: widget.begin, end: widget.end).animate(controller)
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
      child: AnimatedRect(
        animation: animation,
        iconData: widget.icon,
        iconColor: widget.color,
      ),
    );
  }

  void play() {
    setState(() {
      reversed = false;
    });
    controller.forward();
  }
}

class AnimatedRect extends AnimatedWidget {
  AnimatedRect({
    Key key,
    Animation<double> animation,
    IconData iconData,
    Color iconColor,
  }) : super(key: key, listenable: animation);

  IconData iconData;
  Color iconColor;

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Icon(
      iconData,
      color: iconColor,
      size: animation.value,
    );
  }
}
