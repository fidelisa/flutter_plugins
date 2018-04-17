import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:menu_swipe_helpers/drawer_definition.dart';
import 'package:menu_swipe_helpers/drawer_state.dart';
import 'package:redux/redux.dart';

/// Active Page
class ActivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<DrawerState, DrawerDefinition>(
      distinct: true,
      converter: (Store<DrawerState> store) => store.state.activePage,
      builder: (context, page) => page.builder(context),
    );
  }
}
