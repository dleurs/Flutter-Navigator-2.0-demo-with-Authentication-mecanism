import 'package:flutter/material.dart';

import 'package:navigator_v2_flutter_with_auth/src/screen/base_screen.dart';

class LoginScreen extends StatefulWidget {
  //final String targetRouteName;

  LoginScreen({
    Key key,
    /* @required this.targetRouteName */
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseScreenState<LoginScreen> {
  @override
  Widget buildScreen(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Login page',
            style: Theme.of(context).textTheme.headline4,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Enter email address'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Enter password'),
          ),
          RaisedButton(onPressed: this.doLogin, child: Text('Login'))
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(title: Text('Login Screen'));
  }

  @override
  void onLoggedIn() {
    //Navigator.pushReplacementNamed(context, widget.targetRouteName);
  }
}
