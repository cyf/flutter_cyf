import 'package:flutter_cyf/common/model/app_state.dart';
import 'package:flutter_cyf/ui/store/reducers/app_intro_reducer.dart';
import 'package:flutter_cyf/ui/store/reducers/bottom_tabs_reducer.dart';
import 'package:flutter_cyf/ui/store/reducers/counter_reducer.dart';
import 'package:flutter_cyf/ui/store/reducers/dark_mode_reducer.dart';
import 'package:flutter_cyf/ui/store/reducers/l10n_reducer.dart';

// We create the State reducer by combining many smaller reducers into one!
AppState appReducer(AppState state, action) {
  return AppState(
    counter: counterReducer(state.counter, action),
    darkMode: darkModeReducer(state.darkMode, action),
    bottomTabs: bottomTabsReducer(state.bottomTabs, action),
    localeName: l10nReducer(state.localeName, action),
    showAppIntro: appIntroReducer(state.showAppIntro, action),
  );
}