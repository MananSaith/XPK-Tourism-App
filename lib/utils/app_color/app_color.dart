import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryAppBar = Color(0xFF03045E);
  static const Color primaryButton = Color(0xFF023E8A);

  // Secondary Colors
  static const Color secondaryButton = Color(0xFF0077B6);

  // Background Colors
  static const Color cardBackground = Color(0xFF0096C7);
  static const Color softBackground = Color(0xFF90E0EF);
  static const Color inputModelBackground = Color(0xFFADE8F4);
  static const Color scaffoldBackground = Color(0xFFCAF0F8);

  // Text and Elements
  static const Color jetBlack = Color(0xFF000000);
  static const Color tranparentBlack = Color.fromARGB(155, 0, 0, 0);

  static const Color subText = Color(0xFF333333);
  static const Color lightGray = Color(0xFFD3D3D3); // Light Gray

  static const Color mutedElements = Color(0xFF48CAE4);

  // Utility Colors
  static const Color whiteBar = Color(0xFFFFFFFF);
  static const Color dangerRed = Color(0xFFFF4D4D);
  static const Color successGreen = Color(0xFF2ECC71);
  static const Color gray = Color.fromARGB(255, 124, 124, 124);

  // Status Colors
  static const Color warning = Color(0xFFFAE635); // Yellow500
  static const Color error = Color(0xFFF44336); // Red500
  static const Color success = Color(0xFF4CAF51); // Green500
  static const Color info = Color(0xFFFBBA00); // Orange600

  // Background Colors
  static const Color bgLight = Color(0xFFFFFFFF); // White
  static const Color bgDark = Color(0xFF121212); // Black
  static const Color white = Color.fromARGB(255, 255, 255, 255); // Black

  // Text and Icon Colors
  static const Color contentPrimary = Color(0xFF212121); // Gray900
  static const Color contentSecondary = Color(0xFF414141); // Gray800
  static const Color contentTertiary = Color(0xFF5A5A5A); // Gray700
  static const Color contentDisabled = Color(0xFFB8B8B8); // Gray300

  // Additional Shades
  static const Color gray50 = Color(0xFFF7F7F7);
  static const Color gray100 = Color(0xFFE8E8E8);
  static const Color gray200 = Color(0xFFD0D0D0);
  static const Color gray300 = Color(0xFFB8B8B8);
  static const Color gray400 = Color(0xFFA0A0A0);
  static const Color gray500 = Color(0xFF898989);
  static const Color gray600 = Color(0xFF717171);
  static const Color gray700 = Color(0xFF5A5A5A);
  static const Color gray800 = Color(0xFF414141);
  static const Color gray900 = Color(0xFF2A2A2A);

  // Borders and Dividers
  static const Color borderDivider = Color(0xFFF0F0F0);
  static const LinearGradient buttonGradian = LinearGradient(
    colors: [primaryAppBar, mutedElements], // Gradient colors
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const LinearGradient scafoldBackGroundGrandient = LinearGradient(
    colors: [scaffoldBackground, cardBackground], // Gradient colors
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
