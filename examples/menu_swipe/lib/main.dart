import 'package:flutter/material.dart';
import 'package:menu_swipe_helpers/menu_swipe_helpers.dart';

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
    currentAccountPicture: new CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor,
      child: new Text("YP"),
    ),
    margin: EdgeInsets.zero,
  );
}

class FirstPage extends StatefulWidget implements FdlsDrawerPage {
  FirstPage({Key key}) : super(key: key);

  @override
  _FirstPage createState() => new _FirstPage();

  @override
  Icon get icon => const Icon(Icons.first_page);

  @override
  String get subtitle => null;

  @override
  String get title => "First page";
}

class _FirstPage extends State<FirstPage> with FdlsDrawerPageState {

}

class SecondPage extends StatefulWidget implements FdlsDrawerPage {
  SecondPage({Key key}) : super(key: key);

  @override
  _SecondPage createState() => new _SecondPage();

  @override
  Icon get icon => const Icon(Icons.last_page);

  @override
  String get subtitle => null;

  @override
  String get title => "Second page";
}

class _SecondPage extends State<SecondPage> with FdlsDrawerPageState {

  @override
  Widget buildBody() => new Container(
      decoration: new BoxDecoration(color: Colors.red),
      child: new Center(
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
      )
  );


  List<Widget> buildActions() => [
    new IconButton(
      icon: new Icon(Icons.edit),
      onPressed: () => {},
    ),
  ];
}
