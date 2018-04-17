import 'package:flutter/material.dart';
import 'package:menu_swipe_helpers/drawer_definition.dart';
import 'package:menu_swipe_helpers/reducers/drawer_reducer.dart';
import 'package:menu_swipe_helpers/reducers/page_reducer.dart';

/// Create a Store with DrawerStoreMixin interface
class DrawerState {
  final Widget activeDrawer;
  final DrawerDefinition activePage;

  DrawerState({this.activeDrawer, this.activePage}); //, this.hideDrawer});

}

DrawerState drawerAppReducer(DrawerState state, action) {
  return new DrawerState(
      activeDrawer: drawerReducer(state.activeDrawer, action),
      activePage: pageReducer(state.activePage, action));
}
