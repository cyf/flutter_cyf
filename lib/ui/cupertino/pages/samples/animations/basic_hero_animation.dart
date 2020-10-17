import 'package:flutter/cupertino.dart';

/// BasicHeroAnimation
class BasicHeroAnimation extends StatelessWidget {
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Basic Hero Animation'),
      ),
      child: Center(
        child: CupertinoButton(
          onPressed: () {
            Navigator.of(context).push(
              CupertinoPageRoute<void>(
                builder: (BuildContext context) {
                  double top = MediaQuery.of(context).padding.top;
                  return CupertinoPageScaffold(
                    navigationBar: CupertinoNavigationBar(
                      middle: const Text('Flippers Page'),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(top: top + 44 + 8.0),
                      alignment: Alignment.topLeft,
                      // Use background color to emphasize that it's a new route.
                      child: Hero(
                        tag: 'flippers',
                        child: SizedBox(
                          width: 100.0,
                          child: Image.asset(
                            'assets/images/flippers-alpha.png',
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          // Main route
          child: Hero(
            tag: 'flippers',
            child: Image.asset(
              'assets/images/flippers-alpha.png',
            ),
          ),
        ),
      ),
    );
  }
}