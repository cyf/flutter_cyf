import 'package:redux/redux.dart';

import 'package:flutter_cyf/common/enum/theme_mode.dart';
import 'package:flutter_cyf/ui/store/actions/actions.dart';

final darkModeReducer = combineReducers<FThemeMode>([
  TypedReducer<FThemeMode, DarkModeAction>(_setLoaded),
]);

FThemeMode _setLoaded(FThemeMode darkMode, DarkModeAction action) {
  return action.darkMode;
}