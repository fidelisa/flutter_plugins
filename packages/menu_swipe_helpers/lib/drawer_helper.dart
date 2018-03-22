import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:menu_swipe_helpers/actions/actions.dart';
import 'package:menu_swipe_helpers/drawer_definition.dart';
import 'package:redux/redux.dart';

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
    if (f.hideDrawer) {
      Navigator.of(context).pop();
      Navigator.of(context).push(
          new PageRouteBuilder(pageBuilder: (BuildContext context, _, __) {
        return f.builder(context);
      }));
    } else if (widget.changePageWithNavigator || f.hideDrawer) {
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
