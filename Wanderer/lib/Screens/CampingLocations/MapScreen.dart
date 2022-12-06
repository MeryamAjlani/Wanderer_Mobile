import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:Wanderer/widgets/CampingLocation/CampingLocationMapWidget.dart';
import 'package:Wanderer/widgets/Profile/DrawerWidget.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  static final String routeName = "/mapScreen";
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      backgroundColor: CustomColor.backgroundColor,
      body: CampingLocationMapWidget(),
    );
  }
}
