import 'package:Wanderer/Modules/Vector2.dart';
import 'package:flutter/material.dart';

import 'BackgroundAnimatedElement.dart';

class BackgroundAnimatedControllerStateless extends StatelessWidget {
  static bool isFirstBuild = true;
  final Vector2 _offset;

  BackgroundAnimatedControllerStateless.fromCoordinates({double x, double y})
      : _offset = Vector2(x, y);

  BackgroundAnimatedControllerStateless(this._offset);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          BackgroundAnimatedElement(
            screenWidth: screenWidth,
            depthFactor: 1.2,
            imagePath: "assets/Images/animated-background/mountains-far.png",
            offset: _offset,
            staticOffsetY: 70,
          ),
          BackgroundAnimatedElement(
            screenWidth: screenWidth,
            depthFactor: 1.35,
            imagePath: "assets/Images/animated-background/mountains-mid.png",
            offset: _offset,
            staticOffsetY: 68,
          ),
          BackgroundAnimatedElement(
            screenWidth: screenWidth,
            depthFactor: 1.75,
            imagePath: "assets/Images/animated-background/trees-far.png",
            offset: _offset,
            staticOffsetY: 75,
          ),
          BackgroundAnimatedElement(
            screenWidth: screenWidth,
            depthFactor: 2.1,
            imagePath: "assets/Images/animated-background/trees-close.png",
            offset: _offset,
            staticOffsetY: -191,
          ),
        ],
      ),
    );
  }
}
