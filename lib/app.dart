// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';

// Nap thu vien hoac module can thiet.
import 'shared/themes/app_theme.dart';
// Nap thu vien hoac module can thiet.
import 'shared/constants/app_constants.dart';
// Nap thu vien hoac module can thiet.
import 'shared/services/router_service.dart';
// Nap thu vien hoac module can thiet.
import 'shared/services/service_locator.dart';
// Nap thu vien hoac module can thiet.
import 'shared/services/theme_service.dart';

// Dinh nghia lop MyApp de gom nhom logic lien quan.
class MyApp extends StatelessWidget {
  // Khai bao bien MyApp de luu du lieu su dung trong xu ly.
  const MyApp({super.key});

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien themeService de luu du lieu su dung trong xu ly.
    final themeService = getIt<ThemeService>();

    // Tra ve ket qua cho noi goi ham.
    return AnimatedBuilder(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      animation: themeService,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      builder: (context, child) {
        // Tra ve ket qua cho noi goi ham.
        return MaterialApp.router(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          title: AppConstants.appName,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          debugShowCheckedModeBanner: false,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          theme: AppTheme.lightTheme,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          darkTheme: AppTheme.darkTheme,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          themeMode: themeService.themeMode,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          themeAnimationCurve: Curves.easeInOutCubic,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          themeAnimationDuration: AppConstants.mediumDuration,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          routerConfig: RouterService.router,
        );
      },
    );
  }
}
