import 'package:flutter/material.dart';
import 'package:menu_swipe_helpers/menu_swipe_helpers.dart';

const String _kAsset0 = 'avatars/yann.jpg';
const String _kGalleryAssetsPackage = 'flutter_plugins_assets';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    FdlsDrawerStorage.instance.drawer = (BuildContext context) {
      return new FdlsDrawer(
        drawerContents: [
          new FirstPage(),
          new SecondPage()
        ],
        userAccountsDrawerHeader: _userAccountDrawer,);
    };

      return new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new FirstPage(),
      );

  }

  Widget _userAccountDrawer(BuildContext context) => new UserAccountsDrawerHeader(
    accountName: new Text("Yann-Cyril Pelud"),
    accountEmail: new Text("yann@fidelisa.com"),
    currentAccountPicture: const CircleAvatar(
      backgroundImage: const AssetImage(
        _kAsset0,
        package: _kGalleryAssetsPackage,
      ),
    ),
    margin: EdgeInsets.zero,
  );
}

class FirstPage extends StatefulWidget implements FdlsDrawerPage {
  FirstPage({Key key}) : super(key: key);

  @override
  _FirstPage createState() => new _FirstPage();

  @override
  Icon get icon => const Icon(Icons.home);

  @override
  String get subtitle => null;

  @override
  String get title => "First page";
}

class _FirstPage extends State<FirstPage> with FdlsDrawerPageState {

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
              child: new Text(
              '''
Very basic page, go to the seconde page to see more
              ''',
              style: _style,
              softWrap: true),
            ),
          ],
        ),
      )
    );

  } 


}

class SecondPage extends StatefulWidget implements FdlsDrawerPage {
  SecondPage({Key key}) : super(key: key);

  @override
  _SecondPage createState() => new _SecondPage();

  @override
  Icon get icon => const Icon(Icons.settings);

  @override
  String get subtitle => null;

  @override
  String get title => "Seconde Page";
}

class _SecondPage extends State<SecondPage> with FdlsDrawerPageState {

  @override
  Widget buildBody() {
    var _style = Theme.of(context).textTheme.subhead;
    return new Container(
      decoration: new BoxDecoration(color: Colors.red),
      child: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text("Demo",style: _style),
            new Padding(
              padding: const EdgeInsets.all(32.0),
              child: new Text(
              '''
Action in app bar
Persistent Footer Button
Floating button
              ''',
              style: _style,
              softWrap: true),
            ),
          ],
        ),
      )
  );

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
  List<Widget> buildPresistentFooterButtons() {
    return [
      new ButtonBar(
        alignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new FlatButton(
              onPressed: () => {
                //TODO not implemented
              },
              child: new Text("BUTTON")),
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

}
