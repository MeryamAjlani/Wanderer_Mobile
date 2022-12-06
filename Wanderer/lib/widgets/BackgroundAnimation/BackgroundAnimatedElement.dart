import 'package:Wanderer/Modules/Vector2.dart';
import 'package:flutter/material.dart';

class BackgroundAnimatedElement extends StatelessWidget {
  final double _screenWidth;
  final double _depthFactor;
  final String _imagePath;
  final Vector2 _offset;
  final int _duration;
  final double _staticOffsetY;

  BackgroundAnimatedElement(
      {@required double screenWidth,
      @required double depthFactor,
      @required String imagePath,
      @required Vector2 offset,
      double staticOffsetY = 0,
      int duration = 4})
      : this._screenWidth = screenWidth,
        this._depthFactor = depthFactor,
        this._imagePath = imagePath,
        this._duration = duration,
        this._offset = offset,
        this._staticOffsetY = staticOffsetY;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      right: _offset.x * (_depthFactor - 1) * 1.05,
      bottom: _offset.y * (_depthFactor) + _staticOffsetY,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: OverflowBox(
        maxWidth: double.infinity,
        minHeight: MediaQuery.of(context).size.height,
        minWidth: MediaQuery.of(context).size.width,
        child: Image(
          width: _screenWidth * _depthFactor,
          image: AssetImage(_imagePath),
        ),
      ),
      duration: Duration(seconds: _duration),
      curve: Curves.easeOutQuart,
    );
  }
}
