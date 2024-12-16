import 'package:flutter/material.dart';

class AppTheme {
  static const Color dark = Color(0xff1e1e1e);
  static const Color medium = Color(0x50FFFFFF);
  static const Color light = Color(0xFFFFFFFF);
  static const Color accent = Color(0xFFFFA500);

  static const Color disableBackgroundColor = Colors.black12;
  static const Color disableForegroundColor = Colors.white12;

  static const TextStyle inputStyle = TextStyle(color: light, fontSize: 20);
  static const TextStyle hintStyle = TextStyle(color: medium);
  static const TextStyle counterStyle = TextStyle(color: medium, fontSize: 14);
  static const TextStyle splashStyle = TextStyle(
    color: accent,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
}
