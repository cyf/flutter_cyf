import 'package:redux/redux.dart';

import 'package:flutter_cyf/ui/store/actions/actions.dart';

final appIntroReducer = combineReducers<bool>([
  TypedReducer<bool, AppIntroAction>(_setLoaded),
]);

bool _setLoaded(bool showAppIntro, AppIntroAction action) {
  return action.showAppIntro;
}