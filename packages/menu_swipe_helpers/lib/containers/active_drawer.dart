import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:menu_swipe_helpers/drawer_store.dart';
import 'package:redux/redux.dart';

/// Active Drawer
class ActiveDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<DrawerStore, Widget>(
      distinct: true,
      converter: (Store<DrawerStore> store) => store.state.activeDrawer,
      builder: (context, drawer) => drawer,
    );
  }
}
