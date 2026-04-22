// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';
// Nap thu vien hoac module can thiet.
import 'package:go_router/go_router.dart';

// Nap thu vien hoac module can thiet.
import '../constants/app_constants.dart';
// Nap thu vien hoac module can thiet.
import '../../features/authentication/screens/login_screen.dart';
// Nap thu vien hoac module can thiet.
import '../../features/authentication/screens/register_screen.dart';
// Nap thu vien hoac module can thiet.
import '../../features/authentication/screens/splash_screen.dart';
// Nap thu vien hoac module can thiet.
import '../../features/dashboard/screens/dashboard_screen.dart';
// Nap thu vien hoac module can thiet.
import '../../features/car_management/screens/car_list_screen.dart';
// Nap thu vien hoac module can thiet.
import '../../features/car_management/screens/car_detail_screen.dart';
// Nap thu vien hoac module can thiet.
import '../../features/car_management/screens/add_car_screen.dart';
// Nap thu vien hoac module can thiet.
import '../../features/mall/screens/mall_screen.dart';
// Nap thu vien hoac module can thiet.
import '../../features/mall/screens/sales_screen.dart';
// Nap thu vien hoac module can thiet.
import '../../features/mall/screens/sale_detail_screen.dart';
// Nap thu vien hoac module can thiet.
import '../../features/notification/screens/notification_screen.dart';
// Nap thu vien hoac module can thiet.
import '../../features/profile/screens/profile_screen.dart';
// Nap thu vien hoac module can thiet.
import '../../features/profile/screens/profile_info_screen.dart';
// Nap thu vien hoac module can thiet.
import '../../features/profile/screens/profile_security_screen.dart';
// Nap thu vien hoac module can thiet.
import '../../features/profile/screens/profile_history_screen.dart';

// Dinh nghia lop RouterService de gom nhom logic lien quan.
class RouterService {
  // Thuc thi cau lenh hien tai theo luong xu ly.
  RouterService._();

  // Khai bao bien CustomTransitionPage de luu du lieu su dung trong xu ly.
  static CustomTransitionPage<void> _buildPage(
    // Thuc thi cau lenh hien tai theo luong xu ly.
    GoRouterState state,
    // Khai bao bien child de luu du lieu su dung trong xu ly.
    Widget child,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  ) {
    // Tra ve ket qua cho noi goi ham.
    return CustomTransitionPage<void>(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      key: state.pageKey,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: child,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      transitionDuration: AppConstants.mediumDuration,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      reverseTransitionDuration: const Duration(milliseconds: 240),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Khai bao bien curvedAnimation de luu du lieu su dung trong xu ly.
        final curvedAnimation = CurvedAnimation(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          parent: animation,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          curve: Curves.easeOutCubic,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          reverseCurve: Curves.easeInCubic,
        );

        // Tra ve ket qua cho noi goi ham.
        return FadeTransition(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          opacity: curvedAnimation,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: SlideTransition(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            position: Tween<Offset>(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              begin: const Offset(0.06, 0),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              end: Offset.zero,
            // Thuc thi cau lenh hien tai theo luong xu ly.
            ).animate(curvedAnimation),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: child,
          ),
        );
      },
    );
  }

  // Khai bao bien final de luu du lieu su dung trong xu ly.
  static final GoRouter router = GoRouter(
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    initialLocation: RouteNames.splash,
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    debugLogDiagnostics: true,
    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
    routes: [
      // Splash Screen
      // Goi ham de thuc thi tac vu can thiet.
      GoRoute(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        path: RouteNames.splash,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        name: 'splash',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        pageBuilder: (context, state) => const NoTransitionPage<void>(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: SplashScreen(),
        ),
      ),

      // Authentication Routes
      // Goi ham de thuc thi tac vu can thiet.
      GoRoute(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        path: RouteNames.login,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        name: 'login',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        pageBuilder: (context, state) =>
            // Goi ham de thuc thi tac vu can thiet.
            _buildPage(state, const LoginScreen()),
      ),
      // Goi ham de thuc thi tac vu can thiet.
      GoRoute(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        path: RouteNames.register,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        name: 'register',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        pageBuilder: (context, state) =>
            // Goi ham de thuc thi tac vu can thiet.
            _buildPage(state, const RegisterScreen()),
      ),

      // Dashboard
      // Goi ham de thuc thi tac vu can thiet.
      GoRoute(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        path: RouteNames.dashboard,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        name: 'dashboard',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        pageBuilder: (context, state) =>
            // Goi ham de thuc thi tac vu can thiet.
            _buildPage(state, const DashboardScreen()),
      ),

      // Car Management Routes
      // Goi ham de thuc thi tac vu can thiet.
      GoRoute(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        path: RouteNames.carList,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        name: 'carList',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        pageBuilder: (context, state) => _buildPage(state, const CarListScreen()),
      ),
      // Goi ham de thuc thi tac vu can thiet.
      GoRoute(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        path: RouteNames.carDetail,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        name: 'carDetail',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        pageBuilder: (context, state) {
          // Khai bao bien id de luu du lieu su dung trong xu ly.
          final id = state.pathParameters['id'] ?? '';
          // Tra ve ket qua cho noi goi ham.
          return _buildPage(state, CarDetailScreen(carId: id));
        },
      ),
      // Goi ham de thuc thi tac vu can thiet.
      GoRoute(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        path: RouteNames.addCar,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        name: 'addCar',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        pageBuilder: (context, state) => _buildPage(state, const AddCarScreen()),
      ),

      // Mall Route
      // Goi ham de thuc thi tac vu can thiet.
      GoRoute(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        path: RouteNames.mall,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        name: 'mall',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        pageBuilder: (context, state) => _buildPage(state, const MallScreen()),
      ),
      // Goi ham de thuc thi tac vu can thiet.
      GoRoute(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        path: RouteNames.notification,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        name: 'notification',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        pageBuilder: (context, state) =>
            // Goi ham de thuc thi tac vu can thiet.
            _buildPage(state, const NotificationScreen()),
      ),
      // Goi ham de thuc thi tac vu can thiet.
      GoRoute(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        path: RouteNames.profile,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        name: 'profile',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        pageBuilder: (context, state) => _buildPage(state, const ProfileScreen()),
      ),
      // Goi ham de thuc thi tac vu can thiet.
      GoRoute(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        path: RouteNames.profileInfo,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        name: 'profileInfo',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        pageBuilder: (context, state) =>
            // Goi ham de thuc thi tac vu can thiet.
            _buildPage(state, const ProfileInfoScreen()),
      ),
      // Goi ham de thuc thi tac vu can thiet.
      GoRoute(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        path: RouteNames.profileSecurity,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        name: 'profileSecurity',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        pageBuilder: (context, state) =>
            // Goi ham de thuc thi tac vu can thiet.
            _buildPage(state, const ProfileSecurityScreen()),
      ),
      // Goi ham de thuc thi tac vu can thiet.
      GoRoute(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        path: RouteNames.profileHistory,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        name: 'profileHistory',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        pageBuilder: (context, state) =>
            // Goi ham de thuc thi tac vu can thiet.
            _buildPage(state, const ProfileHistoryScreen()),
      ),
      // Sales Routes
      // Goi ham de thuc thi tac vu can thiet.
      GoRoute(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        path: RouteNames.sales,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        name: 'sales',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        pageBuilder: (context, state) => _buildPage(state, const SalesScreen()),
      ),
      // Goi ham de thuc thi tac vu can thiet.
      GoRoute(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        path: RouteNames.saleDetail,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        name: 'saleDetail',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        pageBuilder: (context, state) {
          // Khai bao bien id de luu du lieu su dung trong xu ly.
          final id = state.pathParameters['id'] ?? '';
          // Tra ve ket qua cho noi goi ham.
          return _buildPage(state, SaleDetailScreen(saleId: id));
        },
      ),
    ],
  );
}
