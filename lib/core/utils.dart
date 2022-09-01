import 'package:flutter/material.dart';

class Utils {
  final base1 = Color(0xff0a0d1d);
  final base2 = Color.fromARGB(255, 45, 35, 104);
  final primary = Colors.indigo.shade500;
  final mainGradient = LinearGradient(
    colors: [
      Color(0xff0a0d1d),
      Color(0xff0a0d1d),
      Color.fromARGB(255, 45, 35, 104)
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static String elipsedString(String value, int length) {
    if (value.length < length) {
      return value;
    }
    return value.substring(0, length) + "...";
  }
}
