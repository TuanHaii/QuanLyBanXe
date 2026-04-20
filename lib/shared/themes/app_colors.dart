import 'package:flutter/material.dart';

/// App Color Palette
class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFF63A4FF);
  static const Color primaryDark = Color(0xFF004BA0);

  // Secondary Colors
  static const Color secondary = Color(0xFFFF6F00);
  static const Color secondaryLight = Color(0xFFFFA040);
  static const Color secondaryDark = Color(0xFFC43E00);

  // Accent Colors
  static const Color accent = Color(0xFF00BCD4);

  // Background Colors
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color.fromARGB(255, 94, 112, 214);
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF000000);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Other Colors
  static const Color divider = Color(0xFFBDBDBD);
  static const Color disabled = Color(0xFF9E9E9E);
  static const Color shadow = Color(0x1A000000);
}

/// App Text Styles
class AppTextStyles {
  AppTextStyles._();

  // Material 3 aligned scale.
  static const TextStyle displayLarge = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 52,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.1,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 44,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.9,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 36,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.6,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 30,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.4,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 26,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 22,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle titleLarge = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.35,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.35,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );

  static const TextStyle labelLarge = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 11,
    fontWeight: FontWeight.w500,
  );

  // Legacy aliases kept for backward compatibility in old screens.
  static const TextStyle headline1 = displayLarge;
  static const TextStyle headline2 = displayMedium;
  static const TextStyle headline3 = displaySmall;
  static const TextStyle headline4 = headlineLarge;
  static const TextStyle headline5 = headlineMedium;
  static const TextStyle headline6 = headlineSmall;
  static const TextStyle button = labelLarge;
  static const TextStyle caption = bodySmall;
  static const TextStyle overline = labelSmall;
}

/// App Dimensions
class AppDimens {
  AppDimens._();

  // Padding & Margin
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 48.0;

  // Border Radius
  static const double radiusXS = 4.0;
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusCircle = 100.0;

  // Icon Sizes
  static const double iconXS = 16.0;
  static const double iconS = 20.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 48.0;

  // Button Heights
  static const double buttonHeightS = 36.0;
  static const double buttonHeightM = 48.0;
  static const double buttonHeightL = 56.0;

  // Avatar Sizes
  static const double avatarS = 32.0;
  static const double avatarM = 48.0;
  static const double avatarL = 64.0;
  static const double avatarXL = 96.0;
}
