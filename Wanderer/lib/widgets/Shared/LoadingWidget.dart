import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
          child: SpinKitFoldingCube(
        color: CustomColor.highlightText,
        size: 40.0,
      )),
    );
  }
}
