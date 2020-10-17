import 'package:redux/redux.dart';

import 'package:flutter_cyf/ui/store/actions/actions.dart';

final bottomTabsReducer = combineReducers<List<Map<String, dynamic>>>([
  TypedReducer<List<Map<String, dynamic>>, BottomTabAction>(_setLoaded),
]);

List<Map<String, dynamic>> _setLoaded(List<Map<String, dynamic>> bottomTabs, BottomTabAction action) {
  return action.bottomTabs;
}