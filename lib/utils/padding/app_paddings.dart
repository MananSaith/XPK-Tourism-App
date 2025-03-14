import 'package:flutter/material.dart';

class AppPaddings {
  static const EdgeInsets defaultPadding = EdgeInsets.all(16);
  static const EdgeInsets defaultPadding14 = EdgeInsets.all(14);
  static const EdgeInsets defaultPadding13 = EdgeInsets.all(13);
  static const EdgeInsets defaultPadding12 = EdgeInsets.all(12);
  static const EdgeInsets defaultPadding08 = EdgeInsets.all(05);
  static const EdgeInsets defaultPadding04 = EdgeInsets.all(05);

  static const EdgeInsets topOnly = EdgeInsets.only(top: 16);
  static const EdgeInsets topOnly05 = EdgeInsets.only(top: 05);
  static const EdgeInsets topOnly06 = EdgeInsets.only(top: 06);
  static const EdgeInsets topOnly07 = EdgeInsets.only(top: 07);
  static const EdgeInsets topOnly08 = EdgeInsets.only(top: 08);
  static const EdgeInsets topOnly09 = EdgeInsets.only(top: 09);
  static const EdgeInsets topOnly10 = EdgeInsets.only(top: 010);
  static const EdgeInsets bottomOnly = EdgeInsets.only(bottom: 16);
  static const EdgeInsets bottomOnly10 = EdgeInsets.only(bottom: 10);
  static const EdgeInsets leftOnly = EdgeInsets.only(left: 16);
  static const EdgeInsets leftOnly50 = EdgeInsets.only(left: 50);
  static const EdgeInsets leftOnly45 = EdgeInsets.only(left: 45);
  static const EdgeInsets leftOnly40 = EdgeInsets.only(left: 40);
  static const EdgeInsets rightOnly = EdgeInsets.only(right: 16);
  static const EdgeInsets rightOnly5 = EdgeInsets.only(right: 05);
  static const EdgeInsets rightOnly8 = EdgeInsets.only(right: 08);
  static const EdgeInsets vertical = EdgeInsets.symmetric(vertical: 16);
  static const EdgeInsets horizontal = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets horizontal20 = EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsets horizontal30 = EdgeInsets.symmetric(horizontal: 30);
  static const EdgeInsets horizontal32 = EdgeInsets.symmetric(horizontal: 32);
  static const EdgeInsets horizontal40 = EdgeInsets.symmetric(horizontal: 40);
  static const EdgeInsets horizontal10 = EdgeInsets.symmetric(horizontal: 10);
  static const EdgeInsets horizontal15 = EdgeInsets.symmetric(horizontal: 15);

  static const EdgeInsets horizontal08 = EdgeInsets.symmetric(horizontal: 08);
  static const EdgeInsets horizontal06 = EdgeInsets.symmetric(horizontal: 06);
  static const EdgeInsets horizontal05 = EdgeInsets.symmetric(horizontal: 05);
  static const EdgeInsets horizontal24 = EdgeInsets.symmetric(horizontal: 24);
  static const EdgeInsets horizontal38 = EdgeInsets.symmetric(horizontal: 38);
  static const EdgeInsets horizontalvertical =
      EdgeInsets.symmetric(horizontal: 24, vertical: 10);
}

class AppConfig {
  BuildContext context;
  double height = 30;
  double width = 50;
  AppConfig(this.context) {
    MediaQueryData queryData = MediaQuery.of(context);
    height = queryData.size.height;
    width = queryData.size.width;
  }
}
