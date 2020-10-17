import 'package:flutter/material.dart';
import 'package:flutter_cyf/l10n/flutter_demo_localizations.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter_cyf/common/mock/dark_modes.dart';
import 'package:flutter_cyf/common/model/app_state.dart';
import 'package:flutter_cyf/ui/store/actions/actions.dart';

class FL10n extends StatefulWidget {
  final String headerTitle;

  const FL10n({Key key, this.headerTitle}) : super(key: key);

  @override
  _FL10nState createState() => _FL10nState();
}

class _FL10nState extends State<FL10n> {
  @override
  Widget build(BuildContext context) {
    List<String> localeNames = FlutterDemoLocalizations.supportedLocales
        .map((locale) => locale.toString())
        .toList();
    localeNames.insert(0, '');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.headerTitle ?? "FL10n"),
      ),
      body: StoreConnector<AppState, String>(
        converter: (store) => store.state.localeName,
        builder: (context, localeName) => Container(
          margin: EdgeInsets.only(left: 6, right: 6),
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) =>
                RadioListTile<String>(
              groupValue: localeName,
              title: Text(localeNames[index].isEmpty
                  ? '跟随系统'
                  : localeNames[index] == 'zh' ? '简体中文' : '英语'),
              value: localeNames[index],
              onChanged: (value) {
                StoreProvider.of<AppState>(context)
                    .dispatch(L10nAction(localeName: value));
              },
            ),
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: localeNames.length,
          ),
        ),
      ),
    );
  }
}
