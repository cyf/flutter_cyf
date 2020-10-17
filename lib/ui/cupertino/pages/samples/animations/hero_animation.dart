import 'package:flutter/cupertino.dart';

/// HeroAnimation
class HeroAnimation extends StatelessWidget {
  Widget build(BuildContext context) {
    double timeDilation = 10.0; // 1.0 means normal animation speed.

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Hero Animation'),
      ),
      child: Center(
        child: PhotoHero(
          photo: 'assets/images/flippers-alpha.png',
          width: 300.0,
          onPressed: () {
            Navigator.of(context)
                .push(CupertinoPageRoute<void>(builder: (BuildContext context) {
              double top = MediaQuery.of(context).padding.top;
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: const Text('Flippers Page'),
                ),
                child: Container(
                  // Set background to blue to emphasize that it's a new route.
                  padding: EdgeInsets.only(top: top + 44 + 16.0),
                  alignment: Alignment.topLeft,
                  child: PhotoHero(
                    photo: 'assets/images/flippers-alpha.png',
                    width: 100.0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              );
            }));
          },
        ),
      ),
    );
  }
}

class PhotoHero extends StatelessWidget {
  const PhotoHero({Key key, this.photo, this.onPressed, this.width})
      : super(key: key);

  final String photo;
  final VoidCallback onPressed;
  final double width;

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: CupertinoButton(
          onPressed: onPressed,
          child: Image.asset(
            photo,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}