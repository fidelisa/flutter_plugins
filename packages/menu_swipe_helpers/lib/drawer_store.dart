import 'package:flutter/material.dart';
import 'package:menu_swipe_helpers/drawer_definition.dart';
import 'package:menu_swipe_helpers/drawer_helper.dart';
import 'package:menu_swipe_helpers/drawer_state.dart';
import 'package:redux/redux.dart';

/// Store interface
abstract class DrawerStore {
  Widget get activeDrawer;
  DrawerDefinition get activePage;
}

createDrawerStore(DrawerHelper drawerHelper) => new Store<DrawerState>(
      drawerAppReducer,
      initialState: new DrawerState(
          activeDrawer: drawerHelper,
          activePage: drawerHelper.drawerContents.first),
    );
