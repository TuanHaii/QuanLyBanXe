/// App-wide constants
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Quản Lý Bán Xe';
  static const String appVersion = '1.0.0';

  // API
  static const String baseUrl = 'https://api.example.com';
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language';

  // Pagination
  static const int defaultPageSize = 20;

  // Animation Duration
  static const Duration shortDuration = Duration(milliseconds: 200);
  static const Duration mediumDuration = Duration(milliseconds: 400);
  static const Duration longDuration = Duration(milliseconds: 600);
}

/// Route names
class RouteNames {
  RouteNames._();

  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String dashboard = '/dashboard';
  static const String carList = '/cars';
  static const String carDetail = '/cars/:id';
  static const String addCar = '/cars/add';
  static const String editCar = '/cars/:id/edit';
  static const String sales = '/sales';
  static const String saleDetail = '/sales/:id';
  static const String profile = '/profile';
  static const String settings = '/settings';
}

/// Asset paths
class AssetPaths {
  AssetPaths._();

  // Images
  static const String imagesPath = 'assets/images';
  static const String logo = '$imagesPath/logo.png';
  static const String placeholder = '$imagesPath/placeholder.png';

  // Icons
  static const String iconsPath = 'assets/icons';
}
