// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';
// Nap thu vien hoac module can thiet.
import 'app_colors.dart';

// Dinh nghia lop AppTheme de gom nhom logic lien quan.
class AppTheme {
  // Thuc thi cau lenh hien tai theo luong xu ly.
  AppTheme._();

  // Khai bao bien TextTheme de luu du lieu su dung trong xu ly.
  static TextTheme _buildTextTheme(Brightness brightness) {
    // Khai bao bien baseTextColor de luu du lieu su dung trong xu ly.
    final baseTextColor =
        // Gan gia tri cho bien brightness.
        brightness == Brightness.dark ? AppColors.textLight : AppColors.textPrimary;

    // Tra ve ket qua cho noi goi ham.
    return TextTheme(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      displayLarge: AppTextStyles.displayLarge,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      displayMedium: AppTextStyles.displayMedium,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      displaySmall: AppTextStyles.displaySmall,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      headlineLarge: AppTextStyles.headlineLarge,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      headlineMedium: AppTextStyles.headlineMedium,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      headlineSmall: AppTextStyles.headlineSmall,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      titleLarge: AppTextStyles.titleLarge,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      titleMedium: AppTextStyles.titleMedium,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      titleSmall: AppTextStyles.titleSmall,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      bodyLarge: AppTextStyles.bodyLarge,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      bodyMedium: AppTextStyles.bodyMedium,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      bodySmall: AppTextStyles.bodySmall,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      labelLarge: AppTextStyles.labelLarge,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      labelMedium: AppTextStyles.labelMedium,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      labelSmall: AppTextStyles.labelSmall,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    ).apply(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      fontFamily: 'Roboto',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      bodyColor: baseTextColor,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      displayColor: baseTextColor,
    );
  }

  // Khai bao bien TextTheme de luu du lieu su dung trong xu ly.
  static TextTheme _buildPrimaryTextTheme(Brightness brightness) {
    // Khai bao bien onPrimary de luu du lieu su dung trong xu ly.
    final onPrimary = brightness == Brightness.dark
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ? AppColors.textDark
        // Thuc thi cau lenh hien tai theo luong xu ly.
        : AppColors.textLight;

    // Tra ve ket qua cho noi goi ham.
    return _buildTextTheme(brightness).apply(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      bodyColor: onPrimary,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      displayColor: onPrimary,
    );
  }

  /// Light Theme
  // Khai bao bien ThemeData de luu du lieu su dung trong xu ly.
  static ThemeData get lightTheme {
    // Tra ve ket qua cho noi goi ham.
    return ThemeData(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      useMaterial3: true,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      brightness: Brightness.light,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      fontFamily: 'Roboto',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      textTheme: _buildTextTheme(Brightness.light),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      primaryTextTheme: _buildPrimaryTextTheme(Brightness.light),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      primaryColor: AppColors.primary,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      scaffoldBackgroundColor: AppColors.backgroundLight,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      colorScheme: const ColorScheme.light(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        primary: AppColors.primary,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        primaryContainer: AppColors.primaryLight,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        secondary: AppColors.secondary,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        secondaryContainer: AppColors.secondaryLight,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        surface: AppColors.surfaceLight,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        error: AppColors.error,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onPrimary: AppColors.textLight,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onSecondary: AppColors.textLight,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onSurface: AppColors.textPrimary,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onError: AppColors.textLight,
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      appBarTheme: const AppBarTheme(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        elevation: 0,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        centerTitle: true,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        backgroundColor: AppColors.primary,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        foregroundColor: AppColors.textLight,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        iconTheme: IconThemeData(color: AppColors.textLight),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      cardTheme: CardThemeData(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        elevation: 2,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        shape: RoundedRectangleBorder(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      elevatedButtonTheme: ElevatedButtonThemeData(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        style: ElevatedButton.styleFrom(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          backgroundColor: AppColors.primary,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          foregroundColor: AppColors.textLight,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          minimumSize: const Size(double.infinity, 48),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          shape: RoundedRectangleBorder(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            borderRadius: BorderRadius.circular(8),
          ),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          textStyle: const TextStyle(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            fontSize: 16,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      outlinedButtonTheme: OutlinedButtonThemeData(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        style: OutlinedButton.styleFrom(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          foregroundColor: AppColors.primary,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          minimumSize: const Size(double.infinity, 48),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          side: const BorderSide(color: AppColors.primary),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          shape: RoundedRectangleBorder(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      textButtonTheme: TextButtonThemeData(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        style: TextButton.styleFrom(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          foregroundColor: AppColors.primary,
        ),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      inputDecorationTheme: InputDecorationTheme(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        filled: true,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        fillColor: AppColors.surfaceLight,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        contentPadding: const EdgeInsets.symmetric(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          horizontal: 16,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          vertical: 16,
        ),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: OutlineInputBorder(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderRadius: BorderRadius.circular(8),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        enabledBorder: OutlineInputBorder(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderRadius: BorderRadius.circular(8),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        focusedBorder: OutlineInputBorder(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderRadius: BorderRadius.circular(8),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        errorBorder: OutlineInputBorder(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderRadius: BorderRadius.circular(8),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        backgroundColor: AppColors.primary,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        foregroundColor: AppColors.textLight,
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        backgroundColor: AppColors.surfaceLight,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        selectedItemColor: AppColors.primary,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        unselectedItemColor: AppColors.textSecondary,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        type: BottomNavigationBarType.fixed,
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      dividerTheme: const DividerThemeData(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: AppColors.divider,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        thickness: 1,
      ),
    );
  }

  /// Dark Theme
  // Khai bao bien ThemeData de luu du lieu su dung trong xu ly.
  static ThemeData get darkTheme {
    // Tra ve ket qua cho noi goi ham.
    return ThemeData(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      useMaterial3: true,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      brightness: Brightness.dark,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      fontFamily: 'Roboto',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      textTheme: _buildTextTheme(Brightness.dark),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      primaryTextTheme: _buildPrimaryTextTheme(Brightness.dark),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      primaryColor: AppColors.primary,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      scaffoldBackgroundColor: AppColors.backgroundDark,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      colorScheme: const ColorScheme.dark(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        primary: AppColors.primaryLight,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        primaryContainer: AppColors.primary,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        secondary: AppColors.secondaryLight,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        secondaryContainer: AppColors.secondary,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        surface: AppColors.surfaceDark,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        error: AppColors.error,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onPrimary: AppColors.textDark,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onSecondary: AppColors.textDark,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onSurface: AppColors.textLight,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onError: AppColors.textLight,
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      appBarTheme: const AppBarTheme(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        elevation: 0,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        centerTitle: true,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        backgroundColor: AppColors.surfaceDark,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        foregroundColor: AppColors.textLight,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        iconTheme: IconThemeData(color: AppColors.textLight),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      cardTheme: CardThemeData(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        elevation: 2,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: AppColors.surfaceDark,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        shape: RoundedRectangleBorder(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      elevatedButtonTheme: ElevatedButtonThemeData(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        style: ElevatedButton.styleFrom(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          backgroundColor: AppColors.primaryLight,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          foregroundColor: AppColors.textDark,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          minimumSize: const Size(double.infinity, 48),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          shape: RoundedRectangleBorder(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            borderRadius: BorderRadius.circular(8),
          ),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          textStyle: const TextStyle(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            fontSize: 16,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      outlinedButtonTheme: OutlinedButtonThemeData(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        style: OutlinedButton.styleFrom(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          foregroundColor: AppColors.primaryLight,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          minimumSize: const Size(double.infinity, 48),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          side: const BorderSide(color: AppColors.primaryLight),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          shape: RoundedRectangleBorder(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      inputDecorationTheme: InputDecorationTheme(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        filled: true,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        fillColor: AppColors.surfaceDark,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        contentPadding: const EdgeInsets.symmetric(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          horizontal: 16,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          vertical: 16,
        ),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: OutlineInputBorder(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderRadius: BorderRadius.circular(8),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        enabledBorder: OutlineInputBorder(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderRadius: BorderRadius.circular(8),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderSide: BorderSide(color: AppColors.divider.withValues(alpha: 0.3)),
        ),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        focusedBorder: OutlineInputBorder(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderRadius: BorderRadius.circular(8),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
        ),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        backgroundColor: AppColors.primaryLight,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        foregroundColor: AppColors.textDark,
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        backgroundColor: AppColors.surfaceDark,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        selectedItemColor: AppColors.primaryLight,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        unselectedItemColor: AppColors.textSecondary,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
