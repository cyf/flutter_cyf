import 'package:flutter/cupertino.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter_cyf/common/utils/dark_mode_util.dart';
import 'package:flutter_cyf/common/enum/theme_mode.dart';
import 'package:flutter_cyf/common/model/app_state.dart';

class SamplesItem extends StatelessWidget {
  final String title;
  final String description;
  final Function navigation;

  const SamplesItem({Key key, this.title, this.description, this.navigation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        if (navigation != null) {navigation(context, title)}
      },
      child: StoreConnector<AppState, FThemeMode>(
        converter: (store) => store.state.darkMode,
        builder: (context, darkMode) => Container(
          height: 66,
          padding: EdgeInsets.only(top: 6, bottom: 6),
          decoration: BoxDecoration(
              color: DarkModeUtil.isDarkMode(context, darkMode)
                  ? CupertinoColors.black
                  : CupertinoColors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 8, bottom: 4),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        color: DarkModeUtil.isDarkMode(context, darkMode)
                            ? CupertinoColors.white
                            : CupertinoColors.black,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 8,
                    ),
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: DarkModeUtil.isDarkMode(context, darkMode)
                            ? CupertinoColors.white.withOpacity(0.45)
                            : CupertinoColors.black.withOpacity(0.45),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(right: 4),
                child: Icon(
                  CupertinoIcons.forward,
                  size: 20,
                  color: DarkModeUtil.isDarkMode(context, darkMode)
                      ? CupertinoColors.white.withOpacity(0.3)
                      : CupertinoColors.black.withOpacity(0.3),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
