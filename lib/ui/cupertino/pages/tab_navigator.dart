import 'package:flutter/cupertino.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter_cyf/common/model/app_state.dart';
import 'package:flutter_cyf/common/app_manager.dart';
import 'package:flutter_cyf/common/mock/cupertino/tabs_with_widget.dart';
import 'package:flutter_cyf/l10n/flutter_demo_localizations.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  int _currentIndex = 0;
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final CupertinoThemeData _theme = CupertinoTheme.of(context);
    AppState _appState = StoreProvider.of<AppState>(context).state;
    List<Map<String, dynamic>> _bottomTabs = _appState.bottomTabs;

    List<BottomNavigationBarItem> _items = [];
    _bottomTabs.asMap().forEach((index, item) {
      Map<String, dynamic> element = tabsWithWidget.firstWhere(
          (Map<String, dynamic> ele) => ele['title'] == item['title']);
      _items.add(BottomNavigationBarItem(
        title: Text(
          _getTitle(item["title"]),
          style: TextStyle(
              color: _currentIndex == index
                  ? _theme.primaryColor
                  : CupertinoColors.systemGrey),
        ),
        icon: Icon(
          element["icon"],
          color: CupertinoColors.systemGrey,
        ),
        activeIcon: Icon(
          element["activeIcon"],
          color: _theme.primaryColor,
        ),
      ));
    });

    return StoreConnector<AppState, List<Map<String, dynamic>>>(
      converter: (store) => store.state.bottomTabs,
      builder: (context, bottomTabs) {
        return CupertinoTabScaffold(
          tabBuilder: (BuildContext context, int index) => CupertinoTabView(
            builder: (BuildContext context) {
              Map<String, dynamic> item = _bottomTabs[index];
              Map<String, dynamic> element = tabsWithWidget.firstWhere(
                  (Map<String, dynamic> ele) => ele['title'] == item['title']);
              return (element["widget"]
                  as Function)(_getTitle(element["title"]));
            },
          ),
          tabBar: CupertinoTabBar(
            key: _key,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
              AppManager()
                ..kBottomNavigationBarHeight = _key.currentContext.size.height;
            },
            items: _items,
          ),
        );
      },
    );
  }

  String _getTitle(String title) {
    FlutterDemoLocalizations _localizations =
        FlutterDemoLocalizations.of(context);
    switch (title) {
      case 'tabNewsTitle':
        return _localizations.tabNewsTitle;
      case 'tabPhotosTitle':
        return _localizations.tabPhotosTitle;
      case 'tabVideoTitle':
        return _localizations.tabVideoTitle;
      case 'tabWebViewTitle':
        return _localizations.tabWebViewTitle;
      case 'tabSettingsTitle':
        return _localizations.tabSettingsTitle;
    }
  }
}
