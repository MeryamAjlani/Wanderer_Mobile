import 'package:flutter/material.dart';

import 'RestFormWidget.dart';

class RestFormStateless extends StatelessWidget {
  final bool _visible;
  final Function _routeLogIn;
  final Function _routeCode;
  RestFormStateless(
      {@required bool visible,
      @required Function routeLogIn,
      @required Function routeCode})
      : this._visible = visible,
        this._routeLogIn = routeLogIn,
        this._routeCode = routeCode;
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !_visible,
      child: AnimatedOpacity(
        child: RestFormWidget(_routeCode, _visible, goToLogin),
        opacity: _visible ? 1 : 0,
        duration: Duration(milliseconds: 500),
      ),
    );
  }

  Future<bool> goToLogin() {
    _routeLogIn();
    return Future.sync(() => false);
  }
}
