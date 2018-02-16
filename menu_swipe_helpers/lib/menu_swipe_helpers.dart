library menu_swipe_helpers;


import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class DrawerModel extends Model {
  Widget _drawer;

  Widget get drawer => _drawer;

  DrawerModel({Widget drawer})
    :assert(drawer != null),
    _drawer= drawer;

  update(Widget value) {
    _drawer = value;
    notifyListeners();
  }
}



///
abstract class DrawerDefinition {

  String get title;
  Icon get icon;
  String get subtitle;

  Widget builder(BuildContext context);
}

///
abstract class DrawerStateMixin<T extends StatefulWidget> extends State<T> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  factory DrawerStateMixin._() => null;

  @override
  Widget build(BuildContext context) {
    return buildScaffold();
  }

  Widget buildScaffold() => new Scaffold(
    key: _scaffoldKey,
    drawer: new ScopedModelDescendant<DrawerModel>(
      builder: (context, child, model) => model.drawer,
    ),
    appBar: buildAppBar(),
    body: buildBody(),
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

  List<Widget> buildPresistentFooterButtons() => [];

  Widget buildFloatingButton() => null;

  String get title => "Titre";



}

///
class DrawerHelper extends StatefulWidget {
  final List<DrawerDefinition> drawerContents;
  final WidgetBuilder userAccountsDrawerHeader;

  DrawerHelper({ Key key,
    this.drawerContents,
    this.userAccountsDrawerHeader }):
    super(key: key);

  @override
  _DrawerHelperState createState() => new _DrawerHelperState();
}

///
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
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
    Navigator.of(context).push(
        new PageRouteBuilder(
            pageBuilder: (BuildContext context, _, __) {
              return f.builder(context);
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



