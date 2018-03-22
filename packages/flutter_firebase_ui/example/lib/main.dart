import 'package:flutter/material.dart';
import 'package:flutter_firebase_ui/flutter_firebase_ui.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    return new SignInScreen(
      title: "Bienvenue",
      header: new Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: new Padding(
          padding: const EdgeInsets.all(32.0),
          child: new Text("Demo"),
        ),
      ),
      providers: [
        ProvidersTypes.facebook,
        ProvidersTypes.google,
        ProvidersTypes.email
      ],
    );
  }
}
