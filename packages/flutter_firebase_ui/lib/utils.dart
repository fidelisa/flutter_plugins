import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'l10n/localization.dart';

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
                  child: new Image.asset('assets/$logo',
                      package: 'flutter_firebase_ui')),
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

Map<ProvidersTypes, ButtonDescription> providersDefinitions(
        BuildContext context) =>
    {
      ProvidersTypes.facebook: new ButtonDescription(
          color: const Color.fromRGBO(59, 87, 157, 1.0),
          logo: "fb-logo.png",
          label: FFULocalizations.of(context).signInFacebook,
          name: "Facebook",
          labelColor: Colors.white),
      ProvidersTypes.google: new ButtonDescription(
          color: Colors.white,
          logo: "go-logo.png",
          label: FFULocalizations.of(context).signInGoogle,
          name: "Google",
          labelColor: Colors.grey),
      ProvidersTypes.email: new ButtonDescription(
          color: const Color.fromRGBO(219, 68, 55, 1.0),
          logo: "email-logo.png",
          label: FFULocalizations.of(context).signInEmail,
          name: "Email",
          labelColor: Colors.white),
    };

Future<Null> showErrorDialog(BuildContext context, String message,
    {String title}) {
  return showDialog<Null>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) => new AlertDialog(
          title: title != null ? new Text(title) : null,
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text(message ?? FFULocalizations.of(context).errorOccurred),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Row(
                children: <Widget>[
                  new Text(FFULocalizations.of(context).cancelButtonLabel),
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
