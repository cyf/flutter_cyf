import 'package:flutter/material.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

import 'package:flutter_cyf/common/model/app_state.dart';
import 'package:flutter_cyf/common/enum/theme_mode.dart';
import 'package:flutter_cyf/l10n/flutter_demo_localizations.dart';
import 'package:flutter_cyf/ui/material/pages/app_intro_screen.dart';

class FMaterialApp extends StatefulWidget {
  final Store<AppState> store;

  FMaterialApp({Key key, this.store}) : super(key: key);

  @override
  _FMaterialAppState createState() => _FMaterialAppState();
}

class _FMaterialAppState extends State<FMaterialApp> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: StoreConnector<AppState, FThemeMode>(
        converter: (store) => store.state.darkMode,
        builder: (context, darkMode) => StoreConnector<AppState, String>(
          converter: (store) => store.state.localeName,
          builder: (context, localeName) => MaterialApp(
            localizationsDelegates: [
              ...FlutterDemoLocalizations.localizationsDelegates,
              LocaleNamesLocalizationsDelegate()
            ],
            supportedLocales: FlutterDemoLocalizations.supportedLocales,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: darkMode == FThemeMode.system
                ? ThemeMode.system
                : darkMode == FThemeMode.dark
                    ? ThemeMode.dark
                    : ThemeMode.light,
            locale: localeName.isEmpty ? null : Locale(localeName),
            onGenerateTitle: (BuildContext context) =>
                FlutterDemoLocalizations.of(context).title,
            home: AppIntroScreen(),
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}
