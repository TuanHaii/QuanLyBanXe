import 'package:flutter/material.dart';

import 'shared/themes/app_theme.dart';
import 'shared/constants/app_constants.dart';
import 'shared/services/router_service.dart';
import 'shared/services/service_locator.dart';
import 'shared/services/theme_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = getIt<ThemeService>();

    return AnimatedBuilder(
      animation: themeService,
      builder: (context, child) {
        return MaterialApp.router(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeService.themeMode,
          routerConfig: RouterService.router,
        );
      },
    );
  }
}
