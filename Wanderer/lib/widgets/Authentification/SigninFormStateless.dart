import 'package:flutter/material.dart';

import 'SigninFormWidget.dart';

class SigninFormStateless extends StatelessWidget {
  final bool _visible;
  final Function _routeLogIn;
  SigninFormStateless({@required bool visible, @required Function routeLogIn})
      : this._visible = visible,
        this._routeLogIn = routeLogIn;
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !_visible,
      child: AnimatedOpacity(
        child: SigninFormWidget(_routeLogIn),
        opacity: _visible ? 1 : 0,
        duration: Duration(milliseconds: 500),
      ),
    );
  }
}
