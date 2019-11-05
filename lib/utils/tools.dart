import 'dart:math';

import 'package:flutter/material.dart';

class Tools {
  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static Color tagToColor(String tag) {
    var text = tag.toLowerCase();
    switch (text) {
      case 'flutter':
        return hexToColor('#0175C2');
      case 'tensorflow':
      case 'tf':
        return hexToColor('#FFA800');
      case 'android':
        return hexToColor('#78C257');
      case 'firebase':
        return hexToColor('#F57C00');
      case 'web':
        return hexToColor('#039BE5');
      case 'kotlin':
        return hexToColor('#ec840c');
      case 'md':
      case 'materail design':
      case 'materaildesign':
        return Colors.purple;
      case 'wtm':
        return hexToColor('#00bda4');
      case 'mobile':
        return Colors.blue;
      case 'assistant':
        return Colors.red;
      case 'cloud':
        return hexToColor('#2b86e7');
      default:
        return multiColors[Random().nextInt(3)];
    }
  }

  static String tagToName(String tag) {
    var text = tag.toLowerCase();
    switch (text) {
      case 'flutter':
        return 'Flutter';
      case 'tensorflow':
      case 'tf':
        return 'TensorFlow';
      case 'android':
        return 'Android';
      case 'firebase':
        return 'Firebase';
      case 'web':
        return 'Web';
      case 'wtm':
        return 'Women Techmaker';
      case 'mobile':
        return 'Mobile';
      case 'assistant':
        return 'Assistant';
      case 'cloud':
        return 'Cloud';
      case 'md':
      case 'materail design':
      case 'materaildesign':
        return 'Materail Design';
      case 'kotlin':
        return 'Kotlin';
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
