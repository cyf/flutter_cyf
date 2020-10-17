import 'package:flutter/material.dart' hide ThemeMode;

import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter_cyf/common/utils/dark_mode_util.dart';
import 'package:flutter_cyf/common/model/app_state.dart';
import 'package:flutter_cyf/common/enum/theme_mode.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function navigation;

  const SettingsItem({
    Key key,
    this.title,
    this.icon = Icons.arrow_forward_ios,
    this.navigation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        if (navigation != null) {navigation(context, title)}
      },
      child: StoreConnector<AppState, FThemeMode>(
        converter: (store) => store.state.darkMode,
        builder: (context, darkMode) => Container(
          height: 42,
          padding: EdgeInsets.only(top: 6, bottom: 6),
          decoration: BoxDecoration(
              color: DarkModeUtil.isDarkMode(context, darkMode)
                  ? Colors.black87
                  : Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 6, bottom: 4),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: DarkModeUtil.isDarkMode(context, darkMode)
                        ? Colors.white70
                        : Colors.black87,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 4),
                child: Icon(
                  icon,
                  size: 20,
                  color: DarkModeUtil.isDarkMode(context, darkMode)
                      ? Colors.white30
                      : Colors.black38,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
