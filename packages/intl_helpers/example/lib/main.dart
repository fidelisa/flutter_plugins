import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_helpers/intl_helpers.dart';
import 'l10n/messages_all.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Intl Helper Example',
//      locale: new Locale('fr', 'FR'),
      locale: new Locale('en', 'US'),
      localizationsDelegates: createBasicLocalizationsDelegates(
          supportedLanguages: ['fr', 'en'],
          initializeMessages: initializeMessages),
      supportedLocales: [
        new Locale('en', 'US'), // English
        new Locale('fr', 'FR'), // French
      ],
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Intl Helper Example Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String welcome(name) => Intl.message('Bienvenue, $name',
      name: "_MyHomePageState_welcome",
      args: [name],
      desc: 'message de bienvenue avec nom');

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              GenericHelperLocalizations.of(context).welcome,
              style: Theme.of(context).textTheme.display1,
            ),
            new SizedBox(
              height: 32.0,
            ),
            new Text(
              welcome('Alice'),
              style: Theme.of(context).textTheme.display2,
            ),
            new SizedBox(
              height: 32.0,
            ),
            new Text(
              GlobalMessage.instance.welcomeGlobal,
              style: Theme.of(context).textTheme.display1,
            ),
            new SizedBox(
              height: 32.0,
            ),
            new Text(
              MaterialLocalizations.of(context).signedInLabel,
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
    );
  }
}

class GlobalMessage {
  /// constructor not allowed, only singleton
  GlobalMessage._();

  /// singleton instance
  static final GlobalMessage instance = new GlobalMessage._();

  /// welcome global sample
  String get welcomeGlobal => Intl.message("Bienvenue à tous !",
      name: "welcomeGlobal", args: [], desc: "welcome message");
}
