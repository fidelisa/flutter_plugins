import 'package:flutter/material.dart';
import 'package:menu_swipe_helpers/drawer_definition.dart';

/// Update drawer action
class UpdateDrawerAction {
  final Widget newDrawer;

  UpdateDrawerAction(this.newDrawer);
}

/// Change page action
class ChangePageAction {
  final DrawerDefinition newPage;

  ChangePageAction(this.newPage);
}
