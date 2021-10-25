import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:innovers_exam/utils/colors.dart';

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

class Borders {
  static BorderSide border = BorderSide(color: AppColors.grey, width: 1.5);
  static BorderSide borderWith1 =
      BorderSide(color: AppColors.greyDark, width: 1);
  static BorderSide errorBorder = BorderSide(color: Colors.red, width: 1);
}
