import 'package:redux/redux.dart';

import 'package:flutter_cyf/ui/store/actions/actions.dart';

final counterReducer = combineReducers<int>([
  TypedReducer<int, IncreaseAction>(_increaseAction),
  TypedReducer<int, DecreaseAction>(_decreaseAction),
]);

int _increaseAction(int counter, IncreaseAction action) {
  return counter + action.count;
}

int _decreaseAction(int counter, DecreaseAction action) {
  return counter - action.count;
}