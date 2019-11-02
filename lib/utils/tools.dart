import 'dart:math';

import 'package:flutter/material.dart';

class Tools {
  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static Color tagToColor(String tag) {
    switch (tag) {
      case 'flutter':
      case 'Flutter':
        return hexToColor('#0175C2');
      case 'tensorflow':
      case 'TensorFlow':
      case 'tf':
        return hexToColor('#FFA800');
      case 'android':
      case 'Android':
        return hexToColor('#78C257');
      case 'firebase':
        return hexToColor('#F57C00');
      case 'web':
        return hexToColor('#039BE5');
      case 'md':
        return Colors.purple;
      default:
        return multiColors[Random().nextInt(3)];
    }
  }

  static String tagToName(String tag) {
    switch (tag) {
      case 'flutter':
      case 'Flutter':
        return 'Flutter';
      case 'tensorflow':
      case 'TensorFlow':
      case 'tf':
        return 'TensorFlow';
      case 'android':
      case 'Android':
        return 'Android';
      case 'firebase':
      case 'Firebase':
        return 'Firebase';
      case 'web':
      case 'Web':
        return 'Web';
      case 'md':
        return 'Materail Design';
      default:
        return tag;
    }
  }

  static List<Color> multiColors = [
    Colors.red,
    Colors.amber,
    Colors.green,
    Colors.blue,
  ];
}
