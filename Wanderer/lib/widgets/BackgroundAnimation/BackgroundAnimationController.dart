import 'package:Wanderer/Modules/Vector2.dart';
import 'package:flutter/material.dart';

import 'BackgroundAnimatedElement.dart';

class BackgroundAnimationController extends StatefulWidget {
  void setOffset({double x, double y}) {
    createState().setOffset(x: x, y: y);
  }

  @override
  _BackgroundAnimationControllerState createState() =>
      _BackgroundAnimationControllerState();
}

class _BackgroundAnimationControllerState
    extends State<BackgroundAnimationController> {
  static bool isFirstBuild = true;
  static Vector2 offset = Vector2(0, -200);
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
            offset: offset,
            staticOffsetY: 70,
          ),
          BackgroundAnimatedElement(
            screenWidth: screenWidth,
            depthFactor: 1.35,
            imagePath: "assets/Images/animated-background/mountains-mid.png",
            offset: offset,
            staticOffsetY: 68,
          ),
          BackgroundAnimatedElement(
            screenWidth: screenWidth,
            depthFactor: 1.75,
            imagePath: "assets/Images/animated-background/trees-far.png",
            offset: offset,
            staticOffsetY: 75,
          ),
          BackgroundAnimatedElement(
            screenWidth: screenWidth,
            depthFactor: 2.1,
            imagePath: "assets/Images/animated-background/trees-close.png",
            offset: offset,
            staticOffsetY: -191,
          ),
          Center(
            child: Container(
              child: RaisedButton(
                onPressed: moveRight,
                child: Text("right"),
              ),
              margin: EdgeInsets.only(top: 400),
            ),
          ),
          Center(
            child: Container(
              child: RaisedButton(
                onPressed: moveLeft,
                child: Text("left"),
              ),
              margin: EdgeInsets.only(top: 500),
            ),
          ),
          Center(
            child: Container(
              child: RaisedButton(
                onPressed: moveUp,
                child: Text("Up"),
              ),
              margin: EdgeInsets.only(top: 600),
            ),
          ),
          Center(
            child: Container(
              child: RaisedButton(
                onPressed: moveDown,
                child: Text("Down"),
              ),
              margin: EdgeInsets.only(top: 700),
            ),
          ),
        ],
      ),
    );
  }

  void setOffset({double x, double y}) {
    setState(() {
      if (x != null) offset.x = x;
      if (y != null) offset.y = y;
    });
  }

  void moveRight() {
    setState(() {
      offset.x += 150;
    });
  }

  void moveLeft() {
    setState(() {
      offset.x -= 150;
    });
  }

  void moveUp() {
    setState(() {
      offset.y -= 100;
    });
  }

  void moveDown() {
    setState(() {
      offset.y += 100;
    });
  }

  void initY(_) {
    if (isFirstBuild) {
      print("after build");
      isFirstBuild = false;
      setState(() {
        offset.y = -15;
      });
    }
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(initY);
  }
}
