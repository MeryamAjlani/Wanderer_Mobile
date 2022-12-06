import 'package:flutter/material.dart';

class CustomTheme {
  const CustomTheme(
      {Color backgroundColor,
      Color interactable,
      Color lightBackground,
      Color highlightText,
      Color primaryText,
      Color secondaryHighlight,
      Color secondaryText,
      Color fadedText,
      Color interactableAccent,
      Color interactableHighlight})
      : this.backgroundColor = backgroundColor,
        this.interactable = interactable,
        this.lightBackground = lightBackground,
        this.highlightText = highlightText,
        this.primaryText = primaryText,
        this.secondaryText = secondaryText,
        this.secondaryHighlight = secondaryHighlight,
        this.fadedText = fadedText,
        this.interactableAccent = interactableAccent;

  final Color backgroundColor;
  final Color interactable;
  final Color lightBackground;
  final Color highlightText;
  final Color primaryText;
  final Color secondaryText;
  final Color secondaryHighlight;
  final Color fadedText;
  final Color interactableAccent;
}
