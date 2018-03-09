library flutter_firebase_ui;
export 'utils.dart';

import 'package:flutter/material.dart';
import 'login_view.dart';
import 'utils.dart';


class SignInScreen extends StatefulWidget {
  SignInScreen({
    Key key,
    this.title,
    this.header,
    this.providers,
  })
      : super(key: key);

  final String title;
  final Widget header;
  final List<ProvidersTypes> providers;

  @override
  _SignInScreenState createState() => new _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Widget get _header => widget.header ?? new Container();

  List<ProvidersTypes> get _providers =>
      widget.providers ?? [ProvidersTypes.email];

  @override
  Widget build(BuildContext context) => new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        elevation: 4.0,
      ),
      body: new Builder(
        builder: (BuildContext context) {
          return new ListView(
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _header,
                    new LoginView(providers: _providers),
                  ],
                )
              ]);
        },
      ));
}







