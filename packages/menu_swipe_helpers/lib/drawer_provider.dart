import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// _DrawerWrapper
class DrawerProvider extends StatefulWidget {
  DrawerProvider({Key key, @required Widget drawer, @required Widget child})
      : assert(drawer != null),
        assert(child != null),
        data = new _DrawerData(drawer: drawer, child: child),
        super(key: key);

  final _DrawerData data;

  static Widget drawerOf(BuildContext context) {
    final _InheritedDrawer inheritedDrawer =
        context.inheritFromWidgetOfExactType(_InheritedDrawer);
    if (inheritedDrawer == null) return null;
    return inheritedDrawer.drawer;
  }

  static void changeDrawer(BuildContext context, Widget drawer, [Widget page]) {
    final _InheritedDrawer inheritedDrawer =
        context.inheritFromWidgetOfExactType(_InheritedDrawer);
    if (inheritedDrawer == null) return null;
    inheritedDrawer.onChangeDrawer(drawer);
    if (page != null) {
      DrawerProvider.changePage(context, page);
    }
  }

  static Widget pageOf(BuildContext context) {
    final _InheritedDrawerPage inheritedPageDrawer =
        context.inheritFromWidgetOfExactType(_InheritedDrawerPage);
    if (inheritedPageDrawer == null) return null;
    return inheritedPageDrawer.child;
  }

  static void changePage(BuildContext context, Widget page) {
    final _InheritedDrawerPage inheritedPageDrawer =
        context.inheritFromWidgetOfExactType(_InheritedDrawerPage);
    if (inheritedPageDrawer == null) return null;
    inheritedPageDrawer.onChangePage(page);
  }

  Widget get child => data.child;

  @override
  _DrawerProviderState createState() => new _DrawerProviderState();
}

/// _DrawerData
class _DrawerData {
  Widget drawer;
  Widget child;

  _DrawerData({this.drawer, this.child});
}

/// _DrawerProviderState
class _DrawerProviderState extends State<DrawerProvider> {
  Widget _child;
  Widget _drawer;

  @override
  void initState() {
    _drawer = widget.data.drawer;
    _child = widget.data.child;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new _InheritedDrawer(
      drawer: _drawer,
      onChangeDrawer: _handleDrawerChange,
      child: new _DrawerPageProvider(child: _child),
    );
  }

  void _handleDrawerChange(Widget drawer) {
    setState(() {
      _drawer = drawer;
    });
  }
}

class _InheritedDrawer extends InheritedWidget {
  const _InheritedDrawer({
    Key key,
    @required this.drawer,
    @required Widget child,
    @required this.onChangeDrawer,
  })  : assert(drawer != null),
        super(key: key, child: child);

  final Widget drawer;
  final ValueChanged<Widget> onChangeDrawer;
  @override
  bool updateShouldNotify(_InheritedDrawer old) => drawer != old.drawer;
}

class _DrawerPageProvider extends StatefulWidget {
  _DrawerPageProvider({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget child;

  @override
  _DrawerPageProviderState createState() => new _DrawerPageProviderState();
}

class _DrawerPageProviderState extends State<_DrawerPageProvider> {
  Widget _child;

  @override
  void initState() {
    _child = widget.child;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new _InheritedDrawerPage(
      child: _child,
      onChangePage: (Widget page) {
        if (mounted) {
          setState(() {
            _child = page;
          });
        }
      },
    );
  }
}

class _InheritedDrawerPage extends InheritedWidget {
  const _InheritedDrawerPage({
    Key key,
    @required this.child,
    @required this.onChangePage,
  })  : assert(child != null),
        super(key: key, child: child);

  final Widget child;
  final ValueChanged<Widget> onChangePage;

  @override
  bool updateShouldNotify(_InheritedDrawerPage old) {
    return child != old.child;
  }
}
