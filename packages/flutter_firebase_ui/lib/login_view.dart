import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

import 'email_view.dart';
import 'utils.dart';

class LoginView extends StatefulWidget {
  final List<ProvidersTypes> providers;

  LoginView({
    Key key,
    @required this.providers,
  })
      : super(key: key);

  @override
  _LoginViewState createState() => new _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Map<ProvidersTypes, ButtonDescription> _buttons;

  _handleEmailSignin() async {
    await Navigator
        .of(context)
        .push(new MaterialPageRoute<bool>(builder: (BuildContext context) {
      return new EmailView();
    }));
  }

  _handleGoogleSignin() async {
    GoogleSignIn _googleSignIn = new GoogleSignIn();

    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    if (googleAuth.accessToken != null) {
      try {
        FirebaseUser user = await _auth.signInWithGoogle(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        print(user);
      } catch (exception) {
        showErrorDialog(context, exception);
      }
    }
  }

  _handleFacebookSignin() async {
    var facebookLogin = new FacebookLogin();
    FacebookLoginResult result =
        await facebookLogin.logInWithReadPermissions(['email']);
    if (result.accessToken != null) {
      try {
        FirebaseUser user = await _auth.signInWithFacebook(
            accessToken: result.accessToken.token);
        print(user);
      } catch (exception) {
        showErrorDialog(context, exception);
      }
    }
  }

  @override
  initState() {
    super.initState();

    _initButtonsList();
  }

  _initButtonsList() {
    _buttons = {
      ProvidersTypes.facebook: providersDefinitions[ProvidersTypes.facebook]
          .copyWith(onSelected: _handleFacebookSignin),
      ProvidersTypes.google: providersDefinitions[ProvidersTypes.google]
          .copyWith(onSelected: _handleGoogleSignin),
      ProvidersTypes.email: providersDefinitions[ProvidersTypes.email]
          .copyWith(onSelected: _handleEmailSignin),
    };
  }

  @override
  Widget build(BuildContext context) => new Container(
          child: new Column(
              children: widget.providers.map((p) {
        return new Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _buttons[p] ?? new Container());
      }).toList()));
}
