import 'package:flutter/material.dart';
import 'package:menu_swipe_helpers/actions/actions.dart';
import 'package:redux/redux.dart';


/// drawer reducer
final drawerReducer = combineTypedReducers<Widget>([
  new ReducerBinding<Widget, UpdateDrawerAction>(_activeDrawerReducer),
]);

Widget _activeDrawerReducer(Widget activeDrawer, UpdateDrawerAction action) {
  return action.newDrawer;
}
