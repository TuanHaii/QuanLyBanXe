import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_service.dart';
import 'storage_service.dart';
import '../../features/authentication/services/auth_service.dart';
import '../../features/mall/services/mall_service.dart';
import '../../features/mall/services/sale_service.dart';

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
}
