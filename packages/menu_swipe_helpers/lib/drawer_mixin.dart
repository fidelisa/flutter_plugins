import 'package:flutter/material.dart';
import 'package:menu_swipe_helpers/drawer_provider.dart';

/// Provides the scaffold of the page linked to a menu
///
abstract class DrawerStateMixin<T extends StatefulWidget> extends State<T> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  factory DrawerStateMixin._() => null;

  /// Returns the title of this page
  String get title => "Titre";

  /// Returns if the drawer is hidden
  bool get hideDrawer => false;

  /// Builds the default scaffold
  ///
  /// Override this method to provide your own.
  /// By default if wrap the drawer with mechanisms to diffuse and update it.
  /// See also:
  /// [buildAppBar], [buildBody], [buildPersistentFooterButtons], [buildFloatingButton]
  /// methods to personalize your page.
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      drawer: hideDrawer ? null : DrawerProvider.drawerOf(context),
      appBar: buildAppBar(),
      body: buildBody(),
      persistentFooterButtons: buildPersistentFooterButtons(),
      floatingActionButton: buildFloatingButton(),
    );
  }

  /// Builds the body
  ///
  /// By default it build a page with the title in the center.
  /// Override this method to create your own page.
  Widget buildBody() => new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: new Text(
                title,
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
          ],
        ),
      );

  /// Builds the [AppBar]
  ///
  /// By default it create an appBar with a menu icon and the title centered.
  /// It use method [buildActions] to add actions to the bar.
  Widget buildAppBar() => new AppBar(
        actions: buildActions(),
        title: new Text(title),
      );

  /// Build actions adding to the app bar.
  ///
  /// Empty by default
  List<Widget> buildActions() => null;

  /// Build persistent footer buttons adding to the scaffold.
  ///
  /// Empty by default
  List<Widget> buildPersistentFooterButtons() => null;

  /// Build floating button adding to the scaffold.
  ///
  /// Empty by default
  Widget buildFloatingButton() => null;
}
