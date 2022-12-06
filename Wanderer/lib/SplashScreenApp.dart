import 'package:flutter/material.dart';

import 'Services/Utility/CustomColor.dart';
import 'Services/Utility/DioService.dart';
import 'Services/Utility/LocalStorageService.dart';

class SplashScreenApp extends StatefulWidget {
  final Function _initializationDoneCallback;
  const SplashScreenApp({@required Function initializationDoneCallback})
      : this._initializationDoneCallback = initializationDoneCallback;

  @override
  _SplashScreenAppState createState() => _SplashScreenAppState();
}

class _SplashScreenAppState extends State<SplashScreenApp> {
  @override
  void initState() {
    print("splach screen initState");
    _initializeServices();
    super.initState();
  }

  Future _initializeServices() async {
    await DioService.initService();
    await LocalStorageService.initService();
    print("splach screen services initialized");
    widget._initializationDoneCallback();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Wanderer",
      theme: ThemeData(),
      home: body(),
    );
  }

  Widget body() {
    return Container(
        decoration: BoxDecoration(color: CustomColor.backgroundColor));
  }
}
