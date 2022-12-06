import 'package:flutter/cupertino.dart';

class ClippingStyled extends StatelessWidget {
  final Widget _child;
  final double _radius;
  ClippingStyled({@required Widget child, @required double radius})
      : this._child = child,
        this._radius = radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(_radius),
          topRight: Radius.circular(_radius)),
      child: _child,
    );
  }
}
