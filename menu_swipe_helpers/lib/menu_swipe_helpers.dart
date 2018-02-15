library menu_swipe_helpers;


import 'package:flutter/material.dart';
import 'package:meta/meta.dart';


/// Singleton class that store a drawer
///
class FdlsDrawerStorage {

  /// The drawer
  WidgetBuilder drawer;

  /// Hide creator to force singleton
  FdlsDrawerStorage._();

  /// Singleton instance
  static FdlsDrawerStorage instance = new FdlsDrawerStorage._();

}

///
@optionalTypeArgs
abstract class FdlsDrawerPage {

  String get title;
  Icon get icon;
  String get subtitle;
}

///
@optionalTypeArgs
abstract class FdlsDrawerPageState<T extends StatefulWidget> extends State<T> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  FdlsDrawerPage _drawerPageWidget;

  factory FdlsDrawerPageState._() => null;


  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _drawerPageWidget = (widget is FdlsDrawerPage) ? (widget as FdlsDrawerPage) : null;
  }

  @override
  Widget build(BuildContext context) {
    return buildScaffold();
  }

  Widget buildScaffold() => new Scaffold(
    key: _scaffoldKey,
    drawer: buildDrawer(),
    appBar: buildAppBar(),
    body: new SafeArea(child: buildBody()),
    persistentFooterButtons: buildPresistentFooterButtons(),
    floatingActionButton: buildFloatingButton(),
  );

  Widget buildBody() => new Center(
    child: new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: new Text(title,
            style: Theme.of(context).textTheme.subhead,
          ),
        ),
      ],
    ),
  );

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

  List<Widget> buildActions() => null;

  Widget buildDrawer() => FdlsDrawerStorage.instance.drawer(context);

  List<Widget> buildPresistentFooterButtons() => [];

  Widget buildFloatingButton() => null;

  String get title => _drawerPageWidget?.title;
}

///
class FdlsDrawer extends StatefulWidget {
  final List<FdlsDrawerPage> drawerContents;
  final WidgetBuilder userAccountsDrawerHeader;

  FdlsDrawer({ Key key,
    this.drawerContents,
    this.userAccountsDrawerHeader }):super(key: key);

  @override
  _FdlsDrawerState createState() => new _FdlsDrawerState();
}

///
class _FdlsDrawerState extends State<FdlsDrawer>
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
          widget.userAccountsDrawerHeader(context),
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
                          children: widget.drawerContents.map((FdlsDrawerPage f) {
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

  _onTapChangePage(FdlsDrawerPage f) {
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
    Navigator.of(context).push(
        new PageRouteBuilder(
            pageBuilder: (BuildContext context, _, __) {
              return (f is Widget) ? (f as Widget) : null;
            },
            transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
              return new FadeTransition(
                  opacity: animation,
                  child: child
              );
            }
        )
    );
  }
}



