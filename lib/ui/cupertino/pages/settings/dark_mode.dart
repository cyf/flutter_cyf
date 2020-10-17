import 'package:flutter/cupertino.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter_cyf/common/mock/dark_modes.dart';
import 'package:flutter_cyf/common/model/app_state.dart';
import 'package:flutter_cyf/common/enum/theme_mode.dart';
import 'package:flutter_cyf/common/utils/dark_mode_util.dart';
import 'package:flutter_cyf/ui/store/actions/actions.dart';

class DarkMode extends StatefulWidget {
  final String headerTitle;

  const DarkMode({Key key, this.headerTitle}) : super(key: key);

  @override
  _DarkModeState createState() => _DarkModeState();
}

class _DarkModeState extends State<DarkMode> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.headerTitle ?? "DarkMode"),
      ),
      child: StoreConnector<AppState, FThemeMode>(
        converter: (store) => store.state.darkMode,
        builder: (context, darkMode) => Container(
          margin: EdgeInsets.only(left: 6, right: 6),
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: () {
                StoreProvider.of<AppState>(context).dispatch(
                    DarkModeAction(darkMode: darkModes[index]["mode"]));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 48,
                child: Row(
                  children: <Widget>[
                    Text(
                      darkModes[index]["title"],
                      style: TextStyle(
                        color: DarkModeUtil.isDarkMode(context, darkMode)
                            ? CupertinoColors.white
                            : CupertinoColors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
            separatorBuilder: (context, index) => Container(
              height: 1,
              color: CupertinoColors.systemGrey.withOpacity(0.3),
            ),
            itemCount: darkModes.length,
          ),
        ),
      ),
    );
  }
}
