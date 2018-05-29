import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'l10n/localization.dart';
import 'utils.dart';

class SignUpView extends StatefulWidget {
  final String email;

  SignUpView(this.email, {Key key}) : super(key: key);

  @override
  _SignUpViewState createState() => new _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController _controllerEmail;
  TextEditingController _controllerDisplayName;
  TextEditingController _controllerPassword;

  bool _valid = false;

  @override
  initState() {
    super.initState();
    _controllerEmail = new TextEditingController(text: widget.email);
    _controllerDisplayName = new TextEditingController();
    _controllerPassword = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    _controllerEmail.text = widget.email;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Connexion"),
        elevation: 4.0,
      ),
      body: new Builder(
        builder: (BuildContext context) {
          return new Padding(
            padding: const EdgeInsets.all(16.0),
            child: new Column(
              children: <Widget>[
                new TextField(
                  controller: _controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: new InputDecoration(
                      labelText: FFULocalizations.of(context).emailLabel),
                ),
                const SizedBox(height: 8.0),
                new TextField(
                  controller: _controllerDisplayName,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  onChanged: _checkValid,
                  decoration: new InputDecoration(
                      labelText: FFULocalizations.of(context).nameLabel),
                ),
                const SizedBox(height: 8.0),
                new TextField(
                  controller: _controllerPassword,
                  obscureText: true,
                  autocorrect: false,
                  decoration: new InputDecoration(
                      labelText: FFULocalizations.of(context).passwordLabel),
                ),
              ],
            ),
          );
        },
      ),
      persistentFooterButtons: <Widget>[
        new ButtonBar(
          alignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new FlatButton(
                onPressed: _valid ? () => _connexion(context) : null,
                child: new Row(
                  children: <Widget>[
                    new Text(FFULocalizations.of(context).saveLabel),
                  ],
                )),
          ],
        )
      ],
    );
  }

  _connexion(BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      try {
        var userUpdateInfo = new UserUpdateInfo();
        userUpdateInfo.displayName = _controllerDisplayName.text;
        await _auth.updateProfile(userUpdateInfo);
        Navigator.pop(context, true);
      } catch (e) {
        showErrorDialog(context, e.details);
      }
    } on PlatformException catch (e) {
      print(e.details);
      //TODO improve errors catching
      String msg = FFULocalizations.of(context).passwordLengthMessage;
      showErrorDialog(context, msg);
    }
  }

  void _checkValid(String value) {
    setState(() {
      _valid = _controllerDisplayName.text.isNotEmpty;
    });
  }
}
