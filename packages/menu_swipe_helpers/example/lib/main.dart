import 'package:flutter/material.dart';
import 'package:menu_swipe_helpers/menu_swipe_helpers.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

const String _kAsset0 = 'avatars/yann.jpg';
const String _kGalleryAssetsPackage = 'flutter_plugins_assets';

void main() => runApp(new MyApp());

/// Create a Store with DrawerStoreMixin interface
class AppState implements DrawerStore {
  final Widget activeDrawer;
  final DrawerDefinition activePage;

  AppState({this.activeDrawer, this.activePage});
}

AppState appReducer(AppState state, action) {
  return new AppState(
      activeDrawer: drawerReducer(state.activeDrawer, action),
      activePage: pageReducer(state.activePage, action));
}

class MyApp extends StatelessWidget {
  final store = new Store<AppState>(appReducer,
      initialState: new AppState(
          activeDrawer: _drawerBuilder,
          activePage: _drawerBuilder.drawerContents.first));

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new MaterialApp(
          title: 'Flutter Demo',
          theme: new ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: new ActivePage()),
    );
  }
}

class FirstPageDefinition implements DrawerDefinition {
  @override
  Icon get icon => const Icon(Icons.home);

  @override
  String get subtitle => null;

  @override
  String get title => "First page";

  @override
  Widget builder(BuildContext context) {
    return new FirstPage();
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPage createState() => new _FirstPage();
}

class _FirstPage extends State<FirstPage> with DrawerStateMixin {
  @override
  Widget buildBody() {
    var _style = Theme.of(context).textTheme.subhead;
    return new Container(
        decoration: new BoxDecoration(color: Colors.green),
        child: new Center(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(32.0),
                child: new Text('''
Very basic page, go to the other pages to see more
              ''', style: _style, softWrap: true),
              ),
            ],
          ),
        ));
  }

  @override
  String get title => "First Page";
}

class SecondPageDefinition implements DrawerDefinition {
  @override
  Icon get icon => const Icon(Icons.settings);

  @override
  String get subtitle => null;

  @override
  String get title => "Second Page";

  @override
  Widget builder(BuildContext context) {
    return new SecondPage();
  }
}

class SecondPage extends StatefulWidget {
  @override
  _SecondPage createState() => new _SecondPage();
}

class _SecondPage extends State<SecondPage> with DrawerStateMixin {
  @override
  Widget buildBody() {
    var _style = Theme.of(context).textTheme.subhead;
    return new Container(
        decoration: new BoxDecoration(color: Colors.red),
        child: new Center(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Text("Demo", style: _style),
              new Padding(
                padding: const EdgeInsets.all(32.0),
                child: new Text('''
Action in app bar
Persistent Footer Button
Floating button
              ''', style: _style, softWrap: true),
              ),
            ],
          ),
        ));
  }

  List<Widget> buildActions() => [
        new IconButton(
          icon: new Icon(Icons.edit),
          onPressed: () => {
                //TODO not implemented
              },
        ),
      ];

  @override
  List<Widget> buildPersistentFooterButtons() {
    return [
      new ButtonBar(
        alignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new FlatButton(
              onPressed: () => {
                    //TODO not implemented
                  },
              child: new Row(
                children: <Widget>[
                  new Text("BUTTON"),
                ],
              )),
        ],
      )
    ];
  }

  @override
  Widget buildFloatingButton() {
    return new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () => {
              //TODO not implemented
            });
  }

  @override
  String get title => "Second Page";
}

class ThirdPageDefinition implements DrawerDefinition {
  @override
  Icon get icon => const Icon(Icons.email);

  @override
  String get subtitle => null;

  @override
  String get title => "Third Page";

  @override
  Widget builder(BuildContext context) {
    return new ThirdPage();
  }
}

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPage createState() => new _ThirdPage();
}

class _ThirdPage extends State<ThirdPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void updateDrawer(Widget value) {
    Store store = new StoreProvider.of(context).store;
    store.dispatch(new UpdateDrawerAction(value));
  }

  @override
  Widget build(BuildContext context) {
    var _style = Theme.of(context).textTheme.subhead;

    return new Scaffold(
      key: _scaffoldKey,
      drawer: new ActiveDrawer(),
      body: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            new InkWell(
              child: new Text(
                '''
Page from scatch 
TAP to open the drawer
              ''',
                style: _style,
                softWrap: true,
              ),
              onTap: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
            new RaisedButton(
                child: new Row(
                  children: <Widget>[
                    new Text("Change menu swipe"),
                  ],
                ),
                onPressed: () {
                  updateDrawer(_drawerBuilder2);
                })
          ],
        ),
      ),
    );
  }
}

class FourthPageDefinition implements DrawerDefinition {
  @override
  Icon get icon => const Icon(Icons.person);

  @override
  String get subtitle => null;

  @override
  String get title => "Fourth page";

  @override
  Widget builder(BuildContext context) {
    return new FirstPage();
  }
}

Widget _userAccountDrawer(BuildContext context) => new UserAccountsDrawerHeader(
      accountName: new Text("Yann-Cyril Pelud"),
      accountEmail: new Text("yann@fidelisa.com"),
      currentAccountPicture: new CircleAvatar(
        backgroundImage: new AssetImage(
          _kAsset0,
          package: _kGalleryAssetsPackage,
        ),
      ),
      margin: EdgeInsets.zero,
    );

var _drawerBuilder = new DrawerHelper(
  drawerContents: [
    new FirstPageDefinition(),
    new SecondPageDefinition(),
    new ThirdPageDefinition()
  ],
  userAccountsDrawerHeader: _userAccountDrawer,
);

var _drawerBuilder2 = new DrawerHelper(drawerContents: [
  new FirstPageDefinition(),
  new SecondPageDefinition(),
  new ThirdPageDefinition(),
  new FourthPageDefinition()
], userAccountsDrawerHeader: _userAccountDrawer);
