// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';

/// App Color Palette
// Dinh nghia lop AppColors de gom nhom logic lien quan.
class AppColors {
  // Thuc thi cau lenh hien tai theo luong xu ly.
  AppColors._();

  // Primary Colors
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Color primary = Color(0xFF1976D2);
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Color primaryLight = Color(0xFF63A4FF);
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Color primaryDark = Color(0xFF004BA0);

  // Secondary Colors
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Color secondary = Color(0xFFFF6F00);
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Color secondaryLight = Color(0xFFFFA040);
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Color secondaryDark = Color(0xFFC43E00);

  // Accent Colors
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Color accent = Color(0xFF00BCD4);

  // Background Colors
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Color backgroundLight = Color(0xFFF5F5F5);
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Color backgroundDark = Color(0xFF121212);
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Color surfaceLight = Color(0xFFFFFFFF);
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Text Colors
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Color textPrimary = Color(0xFF212121);
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Color textSecondary = Color.fromARGB(255, 94, 112, 214);
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Color textLight = Color(0xFFFFFFFF);
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Color textDark = Color(0xFF000000);

  // Status Colors
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Color success = Color(0xFF4CAF50);
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Color warning = Color(0xFFFFC107);
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Color error = Color(0xFFF44336);
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Color info = Color(0xFF2196F3);

  // Other Colors
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Color divider = Color(0xFFBDBDBD);
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Color disabled = Color(0xFF9E9E9E);
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Color shadow = Color(0x1A000000);
}

/// App Text Styles
// Dinh nghia lop AppTextStyles de gom nhom logic lien quan.
class AppTextStyles {
  // Thuc thi cau lenh hien tai theo luong xu ly.
  AppTextStyles._();

  // Material 3 aligned scale.
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const TextStyle displayLarge = TextStyle(
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontFamily: 'Roboto',
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontSize: 52,
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontWeight: FontWeight.w700,
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    letterSpacing: -1.1,
  );

  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const TextStyle displayMedium = TextStyle(
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontFamily: 'Roboto',
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontSize: 44,
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontWeight: FontWeight.w700,
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    letterSpacing: -0.9,
  );

  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const TextStyle displaySmall = TextStyle(
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontFamily: 'Roboto',
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontSize: 36,
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontWeight: FontWeight.w700,
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    letterSpacing: -0.6,
  );

  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const TextStyle headlineLarge = TextStyle(
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontFamily: 'Roboto',
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontSize: 30,
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontWeight: FontWeight.w700,
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    letterSpacing: -0.4,
  );

  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const TextStyle headlineMedium = TextStyle(
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontFamily: 'Roboto',
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontSize: 26,
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontWeight: FontWeight.w700,
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    letterSpacing: -0.25,
  );

  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const TextStyle headlineSmall = TextStyle(
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontFamily: 'Roboto',
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontSize: 22,
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontWeight: FontWeight.w600,
  );

  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const TextStyle titleLarge = TextStyle(
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontFamily: 'Roboto',
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontSize: 20,
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontWeight: FontWeight.w600,
  );

  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const TextStyle titleMedium = TextStyle(
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontFamily: 'Roboto',
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontSize: 16,
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontWeight: FontWeight.w600,
  );

  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const TextStyle titleSmall = TextStyle(
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontFamily: 'Roboto',
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontSize: 14,
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontWeight: FontWeight.w600,
  );

  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const TextStyle bodyLarge = TextStyle(
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontFamily: 'Roboto',
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontSize: 16,
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontWeight: FontWeight.w400,
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    height: 1.35,
  );

  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const TextStyle bodyMedium = TextStyle(
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontFamily: 'Roboto',
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontSize: 14,
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontWeight: FontWeight.w400,
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    height: 1.35,
  );

  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const TextStyle bodySmall = TextStyle(
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontFamily: 'Roboto',
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontSize: 12,
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontWeight: FontWeight.w400,
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    height: 1.3,
  );

  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const TextStyle labelLarge = TextStyle(
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontFamily: 'Roboto',
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontSize: 14,
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontWeight: FontWeight.w600,
  );

  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const TextStyle labelMedium = TextStyle(
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontFamily: 'Roboto',
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontSize: 12,
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontWeight: FontWeight.w600,
  );

  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const TextStyle labelSmall = TextStyle(
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontFamily: 'Roboto',
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontSize: 11,
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    fontWeight: FontWeight.w500,
  );

  // Legacy aliases kept for backward compatibility in old screens.
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const TextStyle headline1 = displayLarge;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const TextStyle headline2 = displayMedium;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const TextStyle headline3 = displaySmall;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const TextStyle headline4 = headlineLarge;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const TextStyle headline5 = headlineMedium;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const TextStyle headline6 = headlineSmall;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const TextStyle button = labelLarge;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const TextStyle caption = bodySmall;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const TextStyle overline = labelSmall;
}

/// App Dimensions
// Dinh nghia lop AppDimens de gom nhom logic lien quan.
class AppDimens {
  // Thuc thi cau lenh hien tai theo luong xu ly.
  AppDimens._();

  // Padding & Margin
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const double paddingXS = 4.0;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const double paddingS = 8.0;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const double paddingM = 16.0;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const double paddingL = 24.0;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const double paddingXL = 32.0;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const double paddingXXL = 48.0;

  // Border Radius
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const double radiusXS = 4.0;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const double radiusS = 8.0;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const double radiusM = 12.0;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const double radiusL = 16.0;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const double radiusXL = 24.0;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const double radiusCircle = 100.0;

  // Icon Sizes
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const double iconXS = 16.0;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const double iconS = 20.0;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const double iconM = 24.0;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const double iconL = 32.0;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const double iconXL = 48.0;

  // Button Heights
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const double buttonHeightS = 36.0;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const double buttonHeightM = 48.0;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const double buttonHeightL = 56.0;

  // Avatar Sizes
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const double avatarS = 32.0;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const double avatarM = 48.0;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const double avatarL = 64.0;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const double avatarXL = 96.0;
}
