import 'package:flutter/cupertino.dart';

import 'package:flutter_cyf/common/mock/cupertino/settings.dart';
import 'package:flutter_cyf/ui/cupertino/widgets/settings_item.dart';

class SettingsPage extends StatefulWidget {
  final String headerTitle;

  const SettingsPage({Key key, this.headerTitle}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.headerTitle ?? "Settings"),
      ),
      child: Container(
        margin: EdgeInsets.all(6),
        child: ListView.separated(
          itemCount: settings.length,
          itemBuilder: (context, index) => SettingsItem(
            title: settings[index]["title"],
            navigation: (settings[index]["navigation"] as Function),
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
