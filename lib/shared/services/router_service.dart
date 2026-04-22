import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_constants.dart';
import '../../features/authentication/screens/login_screen.dart';
import '../../features/authentication/screens/register_screen.dart';
import '../../features/authentication/screens/splash_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/car_management/screens/car_list_screen.dart';
import '../../features/car_management/screens/car_detail_screen.dart';
import '../../features/car_management/screens/add_car_screen.dart';
import '../../features/mall/screens/mall_screen.dart';
import '../../features/mall/screens/sales_screen.dart';
import '../../features/mall/screens/sale_detail_screen.dart';
import '../../features/notification/screens/notification_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/profile/screens/profile_info_screen.dart';
import '../../features/profile/screens/profile_security_screen.dart';
import '../../features/profile/screens/profile_history_screen.dart';

class RouterService {
  RouterService._();

  static CustomTransitionPage<void> _buildPage(
    GoRouterState state,
    Widget child,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: AppConstants.mediumDuration,
      reverseTransitionDuration: const Duration(milliseconds: 240),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );

        return FadeTransition(
          opacity: curvedAnimation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.06, 0),
              end: Offset.zero,
            ).animate(curvedAnimation),
            child: child,
          ),
        );
      },
    );
  }

  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true,
    routes: [
      // Splash Screen
      GoRoute(
        path: RouteNames.splash,
        name: 'splash',
        pageBuilder: (context, state) =>
            const NoTransitionPage<void>(child: SplashScreen()),
      ),

      // Authentication Routes
      GoRoute(
        path: RouteNames.login,
        name: 'login',
        pageBuilder: (context, state) => _buildPage(state, const LoginScreen()),
      ),
      GoRoute(
        path: RouteNames.register,
        name: 'register',
        pageBuilder: (context, state) =>
            _buildPage(state, const RegisterScreen()),
      ),

      // Dashboard
      GoRoute(
        path: RouteNames.dashboard,
        name: 'dashboard',
        pageBuilder: (context, state) =>
            _buildPage(state, const DashboardScreen()),
      ),

      // Car Management Routes
      GoRoute(
        path: RouteNames.carList,
        name: 'carList',
        pageBuilder: (context, state) =>
            _buildPage(state, const CarListScreen()),
      ),
      GoRoute(
        path: RouteNames.carDetail,
        name: 'carDetail',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return _buildPage(state, CarDetailScreen(carId: id));
        },
      ),
      GoRoute(
        path: RouteNames.addCar,
        name: 'addCar',
        pageBuilder: (context, state) =>
            _buildPage(state, const AddCarScreen()),
      ),
      GoRoute(
        path: RouteNames.editCar,
        name: 'editCar',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return _buildPage(state, AddCarScreen(carId: id));
        },
      ),

      // Mall Route
      GoRoute(
        path: RouteNames.mall,
        name: 'mall',
        pageBuilder: (context, state) => _buildPage(state, const MallScreen()),
      ),
      GoRoute(
        path: RouteNames.notification,
        name: 'notification',
        pageBuilder: (context, state) =>
            _buildPage(state, const NotificationScreen()),
      ),
      GoRoute(
        path: RouteNames.profile,
        name: 'profile',
        pageBuilder: (context, state) =>
            _buildPage(state, const ProfileScreen()),
      ),
      GoRoute(
        path: RouteNames.profileInfo,
        name: 'profileInfo',
        pageBuilder: (context, state) =>
            _buildPage(state, const ProfileInfoScreen()),
      ),
      GoRoute(
        path: RouteNames.profileSecurity,
        name: 'profileSecurity',
        pageBuilder: (context, state) =>
            _buildPage(state, const ProfileSecurityScreen()),
      ),
      GoRoute(
        path: RouteNames.profileHistory,
        name: 'profileHistory',
        pageBuilder: (context, state) =>
            _buildPage(state, const ProfileHistoryScreen()),
      ),
      // Sales Routes
      GoRoute(
        path: RouteNames.sales,
        name: 'sales',
        pageBuilder: (context, state) => _buildPage(state, const SalesScreen()),
      ),
      GoRoute(
        path: RouteNames.saleDetail,
        name: 'saleDetail',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return _buildPage(state, SaleDetailScreen(saleId: id));
        },
      ),
    ],
  );
}
