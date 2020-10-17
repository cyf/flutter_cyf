import 'package:flutter/cupertino.dart';

import 'package:flutter_cyf/common/utils/navigator_util.dart';
import 'package:flutter_cyf/ui/cupertino/widgets/settings_item.dart';
import 'package:flutter_cyf/ui/cupertino/pages/samples/animations/animated_builder_page.dart';
import 'package:flutter_cyf/ui/cupertino/pages/samples/animations/animated_rect_page.dart';
import 'package:flutter_cyf/ui/cupertino/pages/samples/animations/basic_hero_animation.dart';
import 'package:flutter_cyf/ui/cupertino/pages/samples/animations/basic_radial_hero_animation.dart';
import 'package:flutter_cyf/ui/cupertino/pages/samples/animations/hero_animation.dart';
import 'package:flutter_cyf/ui/cupertino/pages/samples/animations/tween_animation_page.dart';

List<Map<String, Object>> animations = [
  {
    "title": "Tween动画",
    "icon": "",
    "navigation": (BuildContext context, String title) => NavigatorUtil.push(
          context,
          TweenAnimationPage(),
        )
  },
  {
    "title": "AnimatedWidget动画",
    "icon": "",
    "navigation": (BuildContext context, String title) => NavigatorUtil.push(
          context,
          AnimatedRectPage(),
        )
  },
  {
    "title": "AnimatedBuilder动画",
    "icon": "",
    "navigation": (BuildContext context, String title) => NavigatorUtil.push(
          context,
          AnimatedBuilderPage(),
        )
  },
  {
    "title": "Basic Hero Animation",
    "icon": "",
    "navigation": (BuildContext context, String title) => NavigatorUtil.push(
          context,
          BasicHeroAnimation(),
        )
  },
  {
    "title": "Hero Animation",
    "icon": "",
    "navigation": (BuildContext context, String title) => NavigatorUtil.push(
          context,
          HeroAnimation(),
        )
  },
  {
    "title": "Basic Radial Animation",
    "icon": "",
    "navigation": (BuildContext context, String title) => NavigatorUtil.push(
      context,
      BasicRadialHeroAnimation(),
    )
  },
];

/// AnimationPage
class AnimationPage extends StatefulWidget {
  final String headerTitle;

  const AnimationPage({Key key, this.headerTitle}) : super(key: key);

  _AnimationPage createState() => _AnimationPage();
}

class _AnimationPage extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.headerTitle ?? 'Animation'),
      ),
      child: Container(
        margin: EdgeInsets.all(6),
        child: ListView.separated(
          itemCount: animations.length,
          itemBuilder: (context, index) => SettingsItem(
            title: animations[index]["title"],
            navigation: (animations[index]["navigation"] as Function),
          ),
          separatorBuilder: (context, index) => Container(
            height: 1,
            color: CupertinoColors.systemGrey.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}
