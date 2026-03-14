import 'package:go_router/go_router.dart';

import '../constants/app_constants.dart';
import '../../features/authentication/screens/login_screen.dart';
import '../../features/authentication/screens/register_screen.dart';
import '../../features/authentication/screens/splash_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/car_management/screens/car_list_screen.dart';
import '../../features/car_management/screens/car_detail_screen.dart';
import '../../features/car_management/screens/add_car_screen.dart';
import '../../features/sales/screens/sales_screen.dart';

class RouterService {
  RouterService._();

  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true,
    routes: [
      // Splash Screen
      GoRoute(
        path: RouteNames.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // Authentication Routes
      GoRoute(
        path: RouteNames.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.register,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),

      // Dashboard
      GoRoute(
        path: RouteNames.dashboard,
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),

      // Car Management Routes
      GoRoute(
        path: RouteNames.carList,
        name: 'carList',
        builder: (context, state) => const CarListScreen(),
      ),
      GoRoute(
        path: RouteNames.carDetail,
        name: 'carDetail',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return CarDetailScreen(carId: id);
        },
      ),
      GoRoute(
        path: RouteNames.addCar,
        name: 'addCar',
        builder: (context, state) => const AddCarScreen(),
      ),

      // Sales Routes
      GoRoute(
        path: RouteNames.sales,
        name: 'sales',
        builder: (context, state) => const SalesScreen(),
      ),
    ],
  );
}
