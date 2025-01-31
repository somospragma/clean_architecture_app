import 'package:flutter/material.dart';

class CustomTextStyle {
  static const TextStyle FONT_STYLE_TITLE = TextStyle(
    letterSpacing: 0,
    height: 1.333,
    fontSize: 23,
    fontWeight: FontWeight.bold
  );

  static const TextStyle FONT_STYLE_DESCRIPTION = TextStyle(
    letterSpacing: 0,
    height: 1.333,
    fontSize: 16,
  );

  static const TextStyle FONT_STYLE_BUTTON = TextStyle(
    letterSpacing: 0,
    height: 1.333,
    fontSize: 16,
  );

  static const TextStyle FONT_STYLE_LINK_BUTTON = TextStyle(
    letterSpacing: 0,
    height: 1.333,
    fontSize: 14,
    decorationStyle: TextDecorationStyle.solid,
    decoration: TextDecoration.underline,
  );
}
