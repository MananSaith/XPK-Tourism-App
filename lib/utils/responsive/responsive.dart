import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;

  Responsive(this.context);

  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;

  // Calculate font size based on screen width
  static double fontSize(BuildContext context, double baseFontSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    return baseFontSize * (screenWidth / 360); // 360 is the base width
  }

  // Calculate responsive width
  static double width(BuildContext context, double baseWidth) {
    final screenWidth = MediaQuery.of(context).size.width;
    return baseWidth * (screenWidth / 360); // 360 is the base width
  }

  // Calculate responsive height
  static double height(BuildContext context, double baseHeight) {
    final screenHeight = MediaQuery.of(context).size.height;
    return baseHeight * (screenHeight / 690); // 690 is the base height
  }

  // Calculate responsive padding
  static EdgeInsets padding(
    BuildContext context, {
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return EdgeInsets.only(
      left: width(context, left),
      top: height(context, top),
      right: width(context, right),
      bottom: height(context, bottom),
    );
  }

  // Calculate responsive margin
  static EdgeInsets margin(
    BuildContext context, {
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return EdgeInsets.only(
      left: width(context, left),
      top: height(context, top),
      right: width(context, right),
      bottom: height(context, bottom),
    );
  }

  // Calculate icon size responsively
  static double iconSize(BuildContext context, double baseIconSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    return baseIconSize * (screenWidth / 360);
  }
}
