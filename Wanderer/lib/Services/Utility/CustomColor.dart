import 'package:Wanderer/Modules/CustomTheme.dart';
import 'package:flutter/material.dart';

class CustomColor {
  static const _darkTheme = const CustomTheme(
      backgroundColor: Color(0xff241333),
      interactable: Color(0xffe4648f),
      lightBackground: Color(0xff352741),
      interactableAccent: Color(0xffe7accf),
      highlightText: Colors.white,
      primaryText: Color(0xCCffffff),
      secondaryText: Color(0xaaffffff),
      secondaryHighlight: Colors.amber,
      fadedText: Colors.white54);
  static const _currentTheme = _darkTheme;
  static Color get backgroundColor {
    return _currentTheme.backgroundColor;
  }

  static Color get interactable {
    return _currentTheme.interactable;
  }

  static Color get lightBackground {
    return _currentTheme.lightBackground;
  }

  static Color get interactableAccent {
    return _currentTheme.interactableAccent;
  }

  static Color get highlightText {
    return _currentTheme.highlightText;
  }

  static Color get primaryText {
    return _currentTheme.primaryText;
  }

  static Color get secondaryText {
    return _currentTheme.secondaryText;
  }

  static Color get secondaryHighlight {
    return _currentTheme.secondaryHighlight;
  }

  static Color get fadedText {
    return _currentTheme.fadedText;
  }
}
