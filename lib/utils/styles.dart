import 'dart:ui';

import 'package:flutter/material.dart';

double width = window.physicalSize.width / window.devicePixelRatio,
    height = window.physicalSize.height / window.devicePixelRatio;

class HW {
  static double getHeight(double height) {
    return height * height / 1080;
  }

  static double getWidth(double width) {
    return width * width / 1920;
  }
}

class Corners {
  static const double sm = 10;
  static const BorderRadius smBorder = BorderRadius.all(smRadius);
  static const Radius smRadius = Radius.circular(sm);
}
