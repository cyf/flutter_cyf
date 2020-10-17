import 'package:flutter/material.dart';

import 'package:flutter_cyf/common/mock/material/settings.dart';
import 'package:flutter_cyf/ui/material/widgets/settings_item.dart';

class SettingsPage extends StatefulWidget {
  final String headerTitle;

  const SettingsPage({Key key, this.headerTitle}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.headerTitle ?? "Settings"),
      ),
      body: Container(
        margin: EdgeInsets.all(6),
        child: ListView.separated(
          itemCount: settings.length,
          itemBuilder: (context, index) => SettingsItem(
            title: settings[index]["title"],
            navigation: (settings[index]["navigation"] as Function),
          ),
          separatorBuilder: (context, index) => Container(
            height: 10,
          ),
        ),
      ),
    );
  }
}
