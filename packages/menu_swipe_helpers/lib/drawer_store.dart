import 'package:flutter/material.dart';
import 'package:menu_swipe_helpers/drawer_definition.dart';
import 'package:menu_swipe_helpers/drawer_helper.dart';
import 'package:menu_swipe_helpers/drawer_state.dart';
import 'package:menu_swipe_helpers/middlewares/drawer_middleware.dart';
import 'package:redux/redux.dart';

createDrawerStore(DrawerHelper drawerHelper,
        {Widget activeDrawer, DrawerDefinition activePage}) =>
    new Store<DrawerState>(drawerAppReducer,
        initialState: new DrawerState(
            activeDrawer: activeDrawer ?? drawerHelper,
            activePage: activePage ?? drawerHelper.drawerContents.first),
        middleware: createDrawerMiddleware());
