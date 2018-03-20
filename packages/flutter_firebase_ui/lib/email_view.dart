import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'password_view.dart';
import 'sign_up_view.dart';
import 'utils.dart';

class EmailView extends StatefulWidget {
  @override
  _EmailViewState createState() => new _EmailViewState();
}

class _EmailViewState extends State<EmailView> {
  final TextEditingController _controllerEmail = new TextEditingController();

  @override
  Widget build(BuildContext context) => new Scaffold(
        appBar: new AppBar(
          title: new Text("Bienvenue"),
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
                    decoration: new InputDecoration(labelText: 'Adresse mail'),
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
                  onPressed: () => _connexion(context),
                  child: new Row(
                    children: <Widget>[
                      new Text("SUIVANT"),
                    ],
                  )),
            ],
          )
        ],
      );

  _connexion(BuildContext context) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      List<String> providers =
          await auth.fetchProvidersForEmail(email: _controllerEmail.text);
      print(providers);

      if (providers == null) {
        Navigator
            .of(context)
            .push(new MaterialPageRoute<Null>(builder: (BuildContext context) {
          return new SignUpView(_controllerEmail.text);
        }));
      } else if (providers.contains('password')) {
        bool connected = await Navigator
            .of(context)
            .push(new MaterialPageRoute<bool>(builder: (BuildContext context) {
          return new PasswordView(_controllerEmail.text);
        }));

        if (connected) {
          Navigator.pop(context, true);
        }
      } else {
        _showDialogSelectOtherProvider(_controllerEmail.text, providers);
      }
    } catch (exception) {
      print(exception);
    }
  }

  _showDialogSelectOtherProvider(String email, List<String> providers) {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      child: new AlertDialog(
        title: new Text('Vous avez déjà un compte'),
        content: new SingleChildScrollView(
            child: new ListBody(
          children: <Widget>[
            new Text('''
Vous avez déjà utilisé $email.
Connectez-vous avec ${_providersToString(providers)} pour continuer.
          '''),
            new Column(
              children: providers.map((String p) {
                return new RaisedButton(
                  child: new Row(
                    children: <Widget>[
                      new Text(_providerStringToButton(p)),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            )
          ],
        )),
        actions: <Widget>[
          new FlatButton(
            child: new Row(
              children: <Widget>[
                new Text('CANCEL'),
              ],
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  String _providersToString(List<String> providers) {
    return providers.map((String provider) {
      ProvidersTypes type = stringToProvidersType(provider);
      return providersDefinitions[type]?.name;
    }).join(", ");
  }

  String _providerStringToButton(String provider) {
    ProvidersTypes type = stringToProvidersType(provider);
    return providersDefinitions[type]?.label;
  }
}
