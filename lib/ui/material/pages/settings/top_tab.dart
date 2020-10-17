import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:reorderables/reorderables.dart';

import 'package:flutter_cyf/l10n/flutter_demo_localizations.dart';
import 'package:flutter_cyf/common/model/app_state.dart';
import 'package:flutter_cyf/ui/store/actions/actions.dart';
import 'package:flutter_cyf/ui/material/widgets/settings_item.dart';

class TopTab extends StatefulWidget {
  final String headerTitle;

  const TopTab({Key key, this.headerTitle}) : super(key: key);

  @override
  _TopTabState createState() => _TopTabState();
}

class _TopTabState extends State<TopTab> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.headerTitle ?? "TopTab"),
      ),
      body: Container(
        child: StoreConnector<AppState, List<Map<String, dynamic>>>(
          converter: (store) => store.state.bottomTabs,
          builder: (context, bottomTabs) {
            List<Widget> _rows = List<Widget>.generate(
              bottomTabs.length,
                  (int index) =>
                  Container(
                    key: ValueKey(bottomTabs[index]['title']),
                    padding: EdgeInsets.fromLTRB(8, 6, 8, 6),
                    child: SettingsItem(
                      title: _getTitle(bottomTabs[index]['title']),
                      icon: Icons.format_line_spacing,
                    ),
                  ),
            );
            return ReorderableColumn(
              children: _rows,
              onReorder: (int oldIndex, int newIndex) {
                Map<String, dynamic> row = bottomTabs[oldIndex];
                List<Map<String, dynamic>> _bottomTabs = [];
                bottomTabs.asMap().forEach((int index, Map<String, dynamic> item) {
                  if(index != oldIndex) {
                    _bottomTabs.add(item);
                  }
                });
                _bottomTabs.insert(newIndex, row);
                StoreProvider.of<AppState>(context)
                    .dispatch(BottomTabAction(bottomTabs: _bottomTabs));
              },
            );
          },
        ),
      ),
    );
  }

  String _getTitle(String title) {
    FlutterDemoLocalizations _localizations = FlutterDemoLocalizations.of(context);
    switch(title) {
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
