import 'package:quan_ly_ban_xe/shared/services/api_service.dart';
import 'package:quan_ly_ban_xe/shared/services/storage_service.dart';

import '../models/user_model.dart';

class AuthService {
  static const String mockEmail = 'admin@mock.com';
  static const String mockPassword = '123456';
  static const String _mockToken = 'mock-token-admin';

  final ApiService apiService;
  final StorageService storageService;

  AuthService({
    required this.apiService,
    required this.storageService,
  });

  /// Check if user is logged in
  bool get isLoggedIn => storageService.getToken() != null;

  /// Get current user data
  UserModel? get currentUser {
    final userData = storageService.getUserData();
    if (userData != null) {
      return UserModel.fromJson(userData);
    }
    return null;
  }

  UserModel get mockUser => const UserModel(
        id: 'mock-admin-001',
        name: 'Admin Demo',
        email: mockEmail,
        phone: '0987654321',
        role: 'admin',
      );

  Future<void> _saveAuthSession({
    required String token,
    required Map<String, dynamic> userData,
  }) async {
    await storageService.saveToken(token);
    await storageService.saveUserData(userData);
    apiService.setAuthToken(token);
  }

  Map<String, dynamic> _extractUserData(Map<String, dynamic> responseBody) {
    final directUser = responseBody['user'];
    if (directUser is Map<String, dynamic>) {
      return directUser;
    }

    final data = responseBody['data'];
    if (data is Map<String, dynamic> && data['id'] != null) {
      return data;
    }

    if (responseBody['id'] != null) {
      return responseBody;
    }

    throw Exception('Không thể đọc dữ liệu người dùng từ backend.');
  }

  /// Login with email and password
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();

    if (normalizedEmail == mockEmail && password == mockPassword) {
      final user = mockUser;
      await _saveAuthSession(token: _mockToken, userData: user.toJson());
      return user;
    }

    try {
      final response = await apiService.post(
        '/auth/login',
        data: {
          'email': normalizedEmail,
          'password': password,
        },
      );

      final data = response.data as Map<String, dynamic>;
      final token = data['token'] as String;
      final userData = _extractUserData(data);

      await _saveAuthSession(token: token, userData: userData);

      return UserModel.fromJson(userData);
    } catch (e) {
      throw Exception(
        'Chưa có database/API. Dùng tài khoản mẫu: $mockEmail / $mockPassword',
      );
    }
  }

  /// Register new user
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      final response = await apiService.post(
        '/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
        },
      );

      final data = response.data as Map<String, dynamic>;
      final token = data['token'] as String;
      final userData = _extractUserData(data);

      await _saveAuthSession(token: token, userData: userData);

      return UserModel.fromJson(userData);
    } catch (e) {
      throw Exception('Đăng ký thất bại. Vui lòng kiểm tra backend và thử lại.');
    }
  }

  /// Logout
  Future<void> logout() async {
    try {
      final token = storageService.getToken();
      if (token != null && !token.startsWith('mock-token')) {
        await apiService.post('/auth/logout');
      }
    } catch (e) {
      // Ignore logout errors
    } finally {
      await storageService.removeToken();
      await storageService.removeUserData();
      apiService.removeAuthToken();
    }
  }

  /// Forgot password
  Future<void> forgotPassword(String email) async {
    await apiService.post(
      '/auth/forgot-password',
      data: {'email': email},
    );
  }

  /// Reset password
  Future<void> resetPassword({
    required String token,
    required String password,
  }) async {
    await apiService.post(
      '/auth/reset-password',
      data: {
        'token': token,
        'password': password,
      },
    );
  }

  /// Update user profile
  Future<UserModel> updateProfile(Map<String, dynamic> data) async {
    final response = await apiService.put('/auth/profile', data: data);
    final body = response.data as Map<String, dynamic>;
    final userData = _extractUserData(body);
    await storageService.saveUserData(userData);
    return UserModel.fromJson(userData);
  }

  Future<UserModel> fetchProfile() async {
    final response = await apiService.get('/auth/profile');
    final body = response.data as Map<String, dynamic>;
    final userData = _extractUserData(body);
    await storageService.saveUserData(userData);
    return UserModel.fromJson(userData);
  }

  /// Initialize auth state (call on app start)
  Future<void> initializeAuth() async {
    final token = storageService.getToken();
    if (token != null) {
      apiService.setAuthToken(token);
    }
  }
}
