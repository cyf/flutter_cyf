import 'package:redux/redux.dart';

import 'package:flutter_cyf/ui/store/actions/actions.dart';

final l10nReducer = combineReducers<String>([
  TypedReducer<String, L10nAction>(_setLoaded),
]);

String _setLoaded(String name, L10nAction action) {
  return action.localeName;
}