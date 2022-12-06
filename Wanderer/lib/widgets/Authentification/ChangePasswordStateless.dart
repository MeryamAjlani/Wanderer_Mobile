import 'package:flutter/material.dart';
import 'package:Wanderer/widgets/Authentification/CodeFormWidget.dart';

import 'ChangePassword.dart';

class ChangePasswordStateless extends StatelessWidget {
  final bool _visible;
  final Function _routeLogin;
  final String _email;
 ChangePasswordStateless(
      {@required bool visible,
      @required Function routeLogin,
      @required String email})
      : this._visible = visible,
        this._routeLogin =routeLogin,
        this._email = email;
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !_visible,
      child: AnimatedOpacity(
        child: ChangePassword( _email,_routeLogin),
        opacity: _visible ? 1 : 0,
        duration: Duration(milliseconds: 500),
      ),
    );
  }
}
