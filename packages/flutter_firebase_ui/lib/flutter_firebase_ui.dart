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
    this.footer,
    this.providers,
    this.color = Colors.white,
  }) : super(key: key);

  final String title;
  final Widget header;
  final Widget footer;
  final List<ProvidersTypes> providers;
  final Color color;

  @override
  _SignInScreenState createState() => new _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Widget get _header => widget.header ?? new Container();
  Widget get _footer => widget.footer ?? new Container();

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
          return new Container(
              padding: const EdgeInsets.all(16.0),
              decoration: new BoxDecoration(color: widget.color),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _header,
                  new Expanded(child: new LoginView(providers: _providers)),
                  _footer
                ],
              ));
        },
      ));
}
