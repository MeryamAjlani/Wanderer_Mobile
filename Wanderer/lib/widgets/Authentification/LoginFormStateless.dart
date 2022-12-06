import 'package:flutter/material.dart';
import 'package:Wanderer/widgets/Authentification/LoginFormWidget.dart';

class LoginFormStateless extends StatelessWidget {
  final bool _visible;
  final Function _routeSignIn;
  final Function _routeReset;
  LoginFormStateless(
      {@required bool visible,
      @required Function routeSignIn,
      @required Function routeReset})
      : this._visible = visible,
        this._routeSignIn = routeSignIn,
        this._routeReset = routeReset;

  void routeSignIn() {
    print("sign in");
    _routeSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !_visible,
      child: AnimatedOpacity(
        child: LoginFormWidget(routeSignIn, _routeReset),
        opacity: _visible ? 1 : 0,
        duration: Duration(milliseconds: 500),
      ),
    );
  }
}
