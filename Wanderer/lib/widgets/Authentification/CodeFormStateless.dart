import 'package:flutter/material.dart';
import 'package:Wanderer/widgets/Authentification/CodeFormWidget.dart';

class CodeFormStateless extends StatelessWidget {
  final bool _visible;
  final Function _routeReset;
    final Function _routeChange;
  final String _email;
  CodeFormStateless(
      {@required bool visible,
      @required Function routeReset,
      @required String email,
      @required Function routeChange})
      : this._visible = visible,
        this._routeReset = routeReset,
        this._routeChange=routeChange,
        this._email = email;
        
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !_visible,
      child: AnimatedOpacity(
        child: CodeFormWidget(_routeReset, _email,_routeChange),
        opacity: _visible ? 1 : 0,
        duration: Duration(milliseconds: 500),
      ),
    );
  }
}
