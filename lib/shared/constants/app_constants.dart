/// App-wide constants
// Dinh nghia lop AppConstants de gom nhom logic lien quan.
class AppConstants {
  // Thuc thi cau lenh hien tai theo luong xu ly.
  AppConstants._();

  // App Info
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String appName = 'Quản Lý Bán Xe';
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String appVersion = '1.0.0';

  // API
  // Update this value for the local development environment.
  // On Android emulator, 10.0.2.2 maps to the host machine.
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String baseUrl = 'http://10.0.2.2:3000/api';
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const int connectionTimeout = 30000;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const int receiveTimeout = 30000;

  // Storage Keys
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String tokenKey = 'auth_token';
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String userKey = 'user_data';
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String themeKey = 'theme_mode';
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String languageKey = 'language';

  // Pagination
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const int defaultPageSize = 20;

  // Animation Duration
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Duration shortDuration = Duration(milliseconds: 200);
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Duration mediumDuration = Duration(milliseconds: 400);
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Duration longDuration = Duration(milliseconds: 600);
}

/// Route names
// Dinh nghia lop RouteNames de gom nhom logic lien quan.
class RouteNames {
  // Thuc thi cau lenh hien tai theo luong xu ly.
  RouteNames._();

  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String splash = '/';
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String login = '/login';
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String register = '/register';
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String forgotPassword = '/forgot-password';
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String dashboard = '/dashboard';
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String carList = '/cars';
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String carDetail = '/cars/:id';
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String addCar = '/cars/add';
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String editCar = '/cars/:id/edit';
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String mall = '/mall';
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String notification = '/notifications';
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String sales = '/sales';
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String saleDetail = '/sales/:id';
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String profile = '/profile';
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String profileInfo = '/profile/info';
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String profileSecurity = '/profile/security';
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String profileHistory = '/profile/history';
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String settings = '/settings';
}

/// Asset paths
// Dinh nghia lop AssetPaths de gom nhom logic lien quan.
class AssetPaths {
  // Thuc thi cau lenh hien tai theo luong xu ly.
  AssetPaths._();

  // Images
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String imagesPath = 'assets/images';
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String logo = '$imagesPath/logo.png';
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String placeholder = '$imagesPath/placeholder.png';

  // Icons
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String iconsPath = 'assets/icons';
}
