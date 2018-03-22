import 'package:flutter/material.dart';

/// Interface that provides the basic elements of a menu
class DrawerDefinition  {

  /// The title of the menu
  String title;

  /// The icon of the menu
  IconData iconData;

  Icon get icon => new Icon(iconData);

  /// The subtitle of the menu
  String subtitle;

  /// The builder of the page linked to the menu
  WidgetBuilder widgetBuilder;

  /// Must we hide the drawer ?
  bool hideDrawer;

  /// The builder of the page linked to the menu
  Widget builder(BuildContext context) => widgetBuilder(context);

  DrawerDefinition(this.title, this.iconData, this.widgetBuilder,
      {this.subtitle, this.hideDrawer = false});
}
