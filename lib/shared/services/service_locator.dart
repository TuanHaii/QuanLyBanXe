// lib/shared/services/service_locator.dart
import 'package:get_it/get_it.dart';
import 'storage_service.dart';
import 'api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/authentication/services/auth_service.dart';
import '../../features/car_management/services/car_service.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // 1. Đăng ký các service lõi
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(getIt<StorageService>()),
  );

  // 2. Đăng ký các feature services
  getIt.registerLazySingleton<AuthService>(
    () => AuthService(getIt<ApiService>(), getIt<StorageService>()),
  );
  getIt.registerLazySingleton<CarService>(
    () => CarService(getIt<ApiService>()),
  );
}
