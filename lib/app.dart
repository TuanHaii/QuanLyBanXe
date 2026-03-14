import 'package:flutter/material.dart';

import 'shared/themes/app_theme.dart';
import 'shared/constants/app_constants.dart';
import 'shared/services/router_service.dart';

class QuanLyBanXeApp extends StatelessWidget {
  const QuanLyBanXeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: RouterService.router,
    );
  }
}
