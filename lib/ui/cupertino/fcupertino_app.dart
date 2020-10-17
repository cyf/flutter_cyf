import 'package:flutter/cupertino.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

import 'package:flutter_cyf/common/model/app_state.dart';
import 'package:flutter_cyf/common/enum/theme_mode.dart';
import 'package:flutter_cyf/l10n/flutter_demo_localizations.dart';
import 'package:flutter_cyf/ui/cupertino/pages/tab_navigator.dart';
import 'package:flutter_cyf/ui/cupertino/pages/app_intro_screen.dart';

class FCupertinoApp extends StatefulWidget {
  final Store<AppState> store;

  FCupertinoApp({Key key, this.store}) : super(key: key);

  @override
  _FCupertinoAppState createState() => _FCupertinoAppState();
}

class _FCupertinoAppState extends State<FCupertinoApp> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: StoreConnector<AppState, FThemeMode>(
        converter: (store) => store.state.darkMode,
        builder: (context, darkMode) => StoreConnector<AppState, String>(
          converter: (store) => store.state.localeName,
          builder: (context, localeName) => StoreConnector<AppState, bool>(
            converter: (store) => store.state.showAppIntro,
            builder: (context, showAppIntro) => CupertinoApp(
              localizationsDelegates: [
                ...FlutterDemoLocalizations.localizationsDelegates,
                LocaleNamesLocalizationsDelegate()
              ],
              supportedLocales: FlutterDemoLocalizations.supportedLocales,
              theme: darkMode == FThemeMode.system
                  ? CupertinoTheme.of(context)
                  : darkMode == FThemeMode.dark
                  ? CupertinoTheme.of(context).copyWith(brightness: Brightness.dark)
                  : CupertinoTheme.of(context).copyWith(brightness: Brightness.light),
              locale: localeName.isEmpty ? null : Locale(localeName),
              onGenerateTitle: (BuildContext context) =>
              FlutterDemoLocalizations.of(context).title,
              home: showAppIntro ? AppIntroScreen() : TabNavigator(),
              debugShowCheckedModeBanner: false,
            ),
          ),
        ),
      ),
    );
  }
}