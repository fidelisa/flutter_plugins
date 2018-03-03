library menu_swipe_helpers;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

/// Store interface
abstract class DrawerStore {
  Widget get activeDrawer;
  DrawerDefinition get activePage;
}

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

/// Active Page
class ActivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<DrawerStore, DrawerDefinition>(
      distinct: true,
      converter: (Store<DrawerStore> store) => store.state.activePage,
      builder: (context, page) => page.builder(context),
    );
  }
}

/// Update drawer action
class UpdateDrawerAction {
  final Widget newDrawer;

  UpdateDrawerAction(this.newDrawer);
}

/// drawer reducer
final drawerReducer = combineTypedReducers<Widget>([
  new ReducerBinding<Widget, UpdateDrawerAction>(_activeDrawerReducer),
]);

Widget _activeDrawerReducer(Widget activeDrawer, UpdateDrawerAction action) {
  return action.newDrawer;
}

/// Change page action
class ChangePageAction {
  final DrawerDefinition newPage;

  ChangePageAction(this.newPage);
}

/// page reducer
final pageReducer = combineTypedReducers<DrawerDefinition>([
  new ReducerBinding<DrawerDefinition, ChangePageAction>(_activePageReducer),
]);

DrawerDefinition _activePageReducer(
    DrawerDefinition activeDrawer, ChangePageAction action) {
  return action.newPage;
}

/// Interface that provides the basic elements of a menu
abstract class DrawerDefinition {
  /// The title of the menu
  String get title;

  /// The icon of the menu
  Icon get icon;

  /// The subtitle of the menu
  String get subtitle;

  /// The builder of the page linked to the menu
  Widget builder(BuildContext context);
}

/// Provides the scaffold of the page linked to a menu
///
abstract class DrawerStateMixin<T extends StatefulWidget> extends State<T> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  factory DrawerStateMixin._() => null;

  /// Returns the title of this page
  String get title => "Titre";

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
      drawer: new ActiveDrawer(),
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
        leading: new IconButton(
          icon: const Icon(Icons.menu),
          alignment: Alignment.centerLeft,
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
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
  List<Widget> buildPersistentFooterButtons() => [];

  /// Build floating button adding to the scaffold.
  ///
  /// Empty by default
  Widget buildFloatingButton() => null;
}

/// Drawer helper
///
/// Provide a [list] of [DrawerDefinition] and the helper will create a menu
/// with all entries.
class DrawerHelper extends StatefulWidget {
  final List<DrawerDefinition> drawerContents;
  final WidgetBuilder userAccountsDrawerHeader;
  final bool changePageWithNavigator;

  /// Creates the drawer with a [list] of [DrawerDefinition] that content all
  /// the entries. A [WidgetBuilder] can be provided to user account header to
  /// the drawer.
  DrawerHelper(
      {Key key,
      this.drawerContents,
      this.userAccountsDrawerHeader,
      this.changePageWithNavigator = false})
      : super(key: key);

  @override
  _DrawerHelperState createState() => new _DrawerHelperState();
}

class _DrawerHelperState extends State<DrawerHelper>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _drawerContentsOpacity;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _drawerContentsOpacity = new CurvedAnimation(
      parent: new ReverseAnimation(_controller),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new Column(
        children: <Widget>[
          widget.userAccountsDrawerHeader != null
              ? widget.userAccountsDrawerHeader(context)
              : new Container(),
          new MediaQuery.removePadding(
            context: context,
            // DrawerHeader consumes top MediaQuery padding.
            removeTop: true,
            child: new Expanded(
              child: new ListView(
                padding: const EdgeInsets.only(top: 8.0),
                children: <Widget>[
                  new Stack(
                    children: <Widget>[
                      // The initial contents of the drawer.
                      new FadeTransition(
                        opacity: _drawerContentsOpacity,
                        child: new Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: widget.drawerContents.map((f) {
                            return new ListTile(
                              leading: f.icon,
                              title: new Text(f.title),
                              onTap: () => _onTapChangePage(f),
                              subtitle: f.subtitle != null
                                  ? new Text(f.subtitle,
                                      style: new TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.red,
                                      ))
                                  : null,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onTapChangePage(DrawerDefinition f) {
    if (widget.changePageWithNavigator) {
      Navigator.of(context).popUntil(ModalRoute.withName('/'));
      Navigator.of(context).push(new PageRouteBuilder(
              pageBuilder: (BuildContext context, _, __) {
            return f.builder(context);
          }, transitionsBuilder:
                  (_, Animation<double> animation, __, Widget child) {
            return new FadeTransition(opacity: animation, child: child);
          }));
    } else {
      Navigator.of(context).pop();
      Store store = new StoreProvider.of(context).store;
      store.dispatch(new ChangePageAction(f));
    }
  }
}
