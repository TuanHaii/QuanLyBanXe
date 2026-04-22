// Nap thu vien hoac module can thiet.
import 'package:get_it/get_it.dart';
// Nap thu vien hoac module can thiet.
import 'package:shared_preferences/shared_preferences.dart';

// Nap thu vien hoac module can thiet.
import 'api_service.dart';
// Nap thu vien hoac module can thiet.
import 'storage_service.dart';
// Nap thu vien hoac module can thiet.
import 'theme_service.dart';
// Nap thu vien hoac module can thiet.
import '../../features/authentication/services/auth_service.dart';
// Nap thu vien hoac module can thiet.
import '../../features/car_management/services/car_service.dart';
// Nap thu vien hoac module can thiet.
import '../../features/dashboard/services/dashboard_service.dart';
// Nap thu vien hoac module can thiet.
import '../../features/dashboard/services/inventory_quick_action_service.dart';
// Nap thu vien hoac module can thiet.
import '../../features/dashboard/services/report_service.dart';
// Nap thu vien hoac module can thiet.
import '../../features/dashboard/services/sales_quick_action_service.dart';
// Nap thu vien hoac module can thiet.
import '../../features/dashboard/services/support_service.dart';
// Nap thu vien hoac module can thiet.
import '../../features/mall/services/mall_service.dart';
// Nap thu vien hoac module can thiet.
import '../../features/mall/services/sale_service.dart';
// Nap thu vien hoac module can thiet.
import '../../features/notification/services/notification_service.dart';
// Nap thu vien hoac module can thiet.
import '../../features/profile/services/history_service.dart';

// Khai bao bien GetIt de luu du lieu su dung trong xu ly.
final GetIt getIt = GetIt.instance;

/// Setup all services and dependencies
// Khai bao bien setupServiceLocator de luu du lieu su dung trong xu ly.
Future<void> setupServiceLocator() async {
  // External dependencies
  // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
  final sharedPreferences = await SharedPreferences.getInstance();
  // Thuc thi cau lenh hien tai theo luong xu ly.
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Core services
  // Thuc thi cau lenh hien tai theo luong xu ly.
  getIt.registerLazySingleton<StorageService>(
    // Thuc thi cau lenh hien tai theo luong xu ly.
    () => StorageService(getIt<SharedPreferences>()),
  );

  // Thuc thi cau lenh hien tai theo luong xu ly.
  getIt.registerSingleton<ThemeService>(
    // Goi ham de thuc thi tac vu can thiet.
    ThemeService(storageService: getIt<StorageService>()),
  );

  // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
  await getIt<ThemeService>().loadSettings();

  // Thuc thi cau lenh hien tai theo luong xu ly.
  getIt.registerLazySingleton<ApiService>(() => ApiService());

  // Feature services
  // Thuc thi cau lenh hien tai theo luong xu ly.
  getIt.registerLazySingleton<AuthService>(
    // Thuc thi cau lenh hien tai theo luong xu ly.
    () => AuthService(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      apiService: getIt<ApiService>(),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      storageService: getIt<StorageService>(),
    ),
  );

  // Thuc thi cau lenh hien tai theo luong xu ly.
  getIt.registerLazySingleton<MallService>(
    // Thuc thi cau lenh hien tai theo luong xu ly.
    () => MallService(apiService: getIt<ApiService>()),
  );

  // Thuc thi cau lenh hien tai theo luong xu ly.
  getIt.registerLazySingleton<SaleService>(
    // Thuc thi cau lenh hien tai theo luong xu ly.
    () => SaleService(apiService: getIt<ApiService>()),
  );

  // Thuc thi cau lenh hien tai theo luong xu ly.
  getIt.registerLazySingleton<CarService>(
    // Thuc thi cau lenh hien tai theo luong xu ly.
    () => CarService(apiService: getIt<ApiService>()),
  );

  // Thuc thi cau lenh hien tai theo luong xu ly.
  getIt.registerLazySingleton<DashboardService>(
    // Thuc thi cau lenh hien tai theo luong xu ly.
    () => DashboardService(apiService: getIt<ApiService>()),
  );

  // Thuc thi cau lenh hien tai theo luong xu ly.
  getIt.registerLazySingleton<ReportService>(
    // Thuc thi cau lenh hien tai theo luong xu ly.
    () => ReportService(apiService: getIt<ApiService>()),
  );

  // Thuc thi cau lenh hien tai theo luong xu ly.
  getIt.registerLazySingleton<SupportService>(
    // Thuc thi cau lenh hien tai theo luong xu ly.
    () => SupportService(apiService: getIt<ApiService>()),
  );

  // Thuc thi cau lenh hien tai theo luong xu ly.
  getIt.registerLazySingleton<SalesQuickActionService>(
    // Thuc thi cau lenh hien tai theo luong xu ly.
    () => SalesQuickActionService(apiService: getIt<ApiService>()),
  );

  // Thuc thi cau lenh hien tai theo luong xu ly.
  getIt.registerLazySingleton<InventoryQuickActionService>(
    // Thuc thi cau lenh hien tai theo luong xu ly.
    () => InventoryQuickActionService(apiService: getIt<ApiService>()),
  );

  // Thuc thi cau lenh hien tai theo luong xu ly.
  getIt.registerLazySingleton<HistoryService>(
    // Thuc thi cau lenh hien tai theo luong xu ly.
    () => HistoryService(apiService: getIt<ApiService>()),
  );

  // Thuc thi cau lenh hien tai theo luong xu ly.
  getIt.registerLazySingleton<NotificationService>(
    // Thuc thi cau lenh hien tai theo luong xu ly.
    () => NotificationService(apiService: getIt<ApiService>()),
  );
}
