import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

enum ProvidersTypes { email, google, facebook, twitter, phone }

ProvidersTypes stringToProvidersType(String value) {
  if (value.toLowerCase().contains('facebook')) return ProvidersTypes.facebook;
  if (value.toLowerCase().contains('google')) return ProvidersTypes.google;
  if (value.toLowerCase().contains('password')) return ProvidersTypes.email;
//TODO  if (value.toLowerCase().contains('twitter')) return ProvidersTypes.twitter;
//TODO  if (value.toLowerCase().contains('phone')) return ProvidersTypes.phone;
  return null;
}

// Description button
class ButtonDescription extends StatelessWidget {
  final String label;
  final Color labelColor;
  final Color color;
  final String logo;
  final String name;
  final VoidCallback onSelected;

  const ButtonDescription(
      {@required this.logo,
      @required this.label,
      @required this.name,
      this.onSelected,
      this.labelColor = Colors.grey,
      this.color = Colors.white});

  ButtonDescription copyWith({
    String label,
    Color labelColor,
    Color color,
    String logo,
    String name,
    VoidCallback onSelected,
  }) {
    return new ButtonDescription(
        label: label ?? this.label,
        labelColor: labelColor ?? this.labelColor,
        color: color ?? this.color,
        logo: logo ?? this.logo,
        name: name ?? this.name,
        onSelected: onSelected ?? this.onSelected);
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback _onSelected = onSelected ?? () => {};
    return new Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: new RaisedButton(
          color: color,
          child: new Row(
            children: <Widget>[
              new Container(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8.0, left: 16.0, right: 32.0),
                  child: new Image.asset('assets/$logo')),
              new Expanded(
                child: new Text(
                  label,
                  style: new TextStyle(color: labelColor),
                ),
              )
            ],
          ),
          onPressed: _onSelected),
    );
  }
}

Map<ProvidersTypes, ButtonDescription> providersDefinitions = {
  ProvidersTypes.facebook: const ButtonDescription(
      color: const Color.fromRGBO(59, 87, 157, 1.0),
      logo: "fb-logo.png",
      label: "Connexion avec Facebook",
      name: "Facebook",
      labelColor: Colors.white),
  ProvidersTypes.google: const ButtonDescription(
      color: Colors.white,
      logo: "go-logo.png",
      label: "Connexion avec Google",
      name: "Google",
      labelColor: Colors.grey),
  ProvidersTypes.email: const ButtonDescription(
      color: const Color.fromRGBO(219, 68, 55, 1.0),
      logo: "email-logo.png",
      label: "Connexion avec email",
      name: "Email",
      labelColor: Colors.white),
};

Future<Null> showErrorDialog(BuildContext context, exception) {
  return showDialog<Null>(
    context: context,
    barrierDismissible: false, // user must tap button!
    child: new AlertDialog(
      title: new Text('Vous avez déjà un compte'),
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            new Text(exception.toString()),
          ],
        ),
      ),
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
