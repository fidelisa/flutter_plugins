import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:menu_swipe_helpers/drawer_state.dart';
import 'package:redux/redux.dart';

/// Active Drawer
class ActiveDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<DrawerState, Widget>(
      distinct: true,
      converter: (Store<DrawerState> store) => store.state.activeDrawer,
      builder: (context, drawer) => drawer,
    );
  }
}
