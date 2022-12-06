import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String _text;
  final double _bottomMargin;
  TitleText(this._text, {double bottomMargin = 5})
      : this._bottomMargin = bottomMargin;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: _bottomMargin),
      child: Text(
        _text,
        style: TextStyle(color: CustomColor.primaryText),
      ),
    );
  }
}
