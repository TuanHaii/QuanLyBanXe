import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_service.dart';
import 'storage_service.dart';
import 'theme_service.dart';
import '../../features/authentication/services/auth_service.dart';
import '../../features/car_management/services/car_service.dart';
import '../../features/dashboard/services/dashboard_service.dart';
import '../../features/dashboard/services/inventory_quick_action_service.dart';
import '../../features/dashboard/services/report_service.dart';
import '../../features/dashboard/services/sales_quick_action_service.dart';
import '../../features/dashboard/services/support_service.dart';
import '../../features/mall/services/mall_service.dart';
import '../../features/mall/services/sale_service.dart';
import '../../features/notification/services/notification_service.dart';
import '../../features/profile/services/history_service.dart';

final GetIt getIt = GetIt.instance;

/// Setup all services and dependencies
Future<void> setupServiceLocator() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Core services
  getIt.registerLazySingleton<StorageService>(
    () => StorageService(getIt<SharedPreferences>()),
  );

  getIt.registerSingleton<ThemeService>(
    ThemeService(storageService: getIt<StorageService>()),
  );

  await getIt<ThemeService>().loadSettings();

  getIt.registerLazySingleton<ApiService>(() => ApiService());

  // Feature services
  getIt.registerLazySingleton<AuthService>(
    () => AuthService(
      apiService: getIt<ApiService>(),
      storageService: getIt<StorageService>(),
    ),
  );

  getIt.registerLazySingleton<MallService>(
    () => MallService(apiService: getIt<ApiService>()),
  );

  getIt.registerLazySingleton<SaleService>(
    () => SaleService(apiService: getIt<ApiService>()),
  );

  getIt.registerLazySingleton<CarService>(
    () => CarService(apiService: getIt<ApiService>()),
  );

  getIt.registerLazySingleton<DashboardService>(
    () => DashboardService(apiService: getIt<ApiService>()),
  );

  getIt.registerLazySingleton<ReportService>(
    () => ReportService(apiService: getIt<ApiService>()),
  );

  getIt.registerLazySingleton<SupportService>(
    () => SupportService(apiService: getIt<ApiService>()),
  );

  getIt.registerLazySingleton<SalesQuickActionService>(
    () => SalesQuickActionService(apiService: getIt<ApiService>()),
  );

  getIt.registerLazySingleton<InventoryQuickActionService>(
    () => InventoryQuickActionService(apiService: getIt<ApiService>()),
  );

  getIt.registerLazySingleton<HistoryService>(
    () => HistoryService(apiService: getIt<ApiService>()),
  );

  getIt.registerLazySingleton<NotificationService>(
    () => NotificationService(apiService: getIt<ApiService>()),
  );
}
