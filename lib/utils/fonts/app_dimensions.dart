// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AppDimensions {
  static const double FONT_SIZE_05 = 05.0;
  static const double FONT_SIZE_06 = 06.0;
  static const double FONT_SIZE_07 = 07.0;
  static const double FONT_SIZE_08 = 08.0;
  static const double FONT_SIZE_09 = 09.0;
  static const double FONT_SIZE_10 = 10.0;
  static const double FONT_SIZE_11 = 11.0;
  static const double FONT_SIZE_12 = 12.0;
  static const double FONT_SIZE_13 = 13.0;
  static const double FONT_SIZE_14 = 14.0;
  static const double FONT_SIZE_15 = 15.0;
  static const double FONT_SIZE_16 = 16.0;
  static const double FONT_SIZE_17 = 17.0;
  static const double FONT_SIZE_18 = 18.0;
  static const double FONT_SIZE_19 = 19.0;
  static const double FONT_SIZE_20 = 20.0;
  static const double FONT_SIZE_21 = 21.0;
  static const double FONT_SIZE_22 = 22.0;
  static const double FONT_SIZE_24 = 24.0;
  static const double FONT_SIZE_26 = 26.0;
  static const double FONT_SIZE_28 = 28.0;

  static const double FONT_SIZE_30 = 30.0;
  static const double FONT_SIZE_35 = 35.0;
  static const double FONT_SIZE_38 = 38.0;
  static const double FONT_SIZE_40 = 40.0;
  static const double FONT_SIZE_45 = 45.0;
  static const double FONT_SIZE_50 = 50.0;
  static double smallTextSize = Get.width * 0.013;

  static double getSmallTextSize(double size) {
    return size * 0.011;
  }

  static double getRegularTextSize(double size) {
    return size * 0.011;
  }

  static double getMediumTextSize(double size) {
    return size * 0.02;
  }

  static double getLargeTextSize(double size) {
    return size * 0.025;
  }
}

Widget vSizedBox({double height = 15.0}) {
  return SizedBox(
    height: height,
  );
}

Widget hSizedBox({double width = 20.0}) {
  return SizedBox(
    width: width,
  );
}
