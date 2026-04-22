// Nap thu vien hoac module can thiet.
import 'package:quan_ly_ban_xe/shared/services/api_service.dart';
// Nap thu vien hoac module can thiet.
import 'package:quan_ly_ban_xe/shared/services/storage_service.dart';

// Nap thu vien hoac module can thiet.
import '../models/user_model.dart';

// Dinh nghia lop AuthService de gom nhom logic lien quan.
class AuthService {
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String mockEmail = 'admin@mock.com';
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String mockPassword = '123456';
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String _mockToken = 'mock-token-admin';

  // Khai bao bien ApiService de luu du lieu su dung trong xu ly.
  final ApiService apiService;
  // Khai bao bien StorageService de luu du lieu su dung trong xu ly.
  final StorageService storageService;

  // Goi ham de thuc thi tac vu can thiet.
  AuthService({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.apiService,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.storageService,
  });

  /// Check if user is logged in
  // Khai bao bien get de luu du lieu su dung trong xu ly.
  bool get isLoggedIn => storageService.getToken() != null;

  /// Get current user data
  // Thuc thi cau lenh hien tai theo luong xu ly.
  UserModel? get currentUser {
    // Khai bao bien userData de luu du lieu su dung trong xu ly.
    final userData = storageService.getUserData();
    // Kiem tra dieu kien de re nhanh xu ly.
    if (userData != null) {
      // Tra ve ket qua cho noi goi ham.
      return UserModel.fromJson(userData);
    }
    // Tra ve ket qua cho noi goi ham.
    return null;
  }

  // Thuc thi cau lenh hien tai theo luong xu ly.
  UserModel get mockUser => const UserModel(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        id: 'mock-admin-001',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        name: 'Admin Demo',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        email: mockEmail,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        phone: '0987654321',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        role: 'admin',
      );

  // Khai bao bien _saveAuthSession de luu du lieu su dung trong xu ly.
  Future<void> _saveAuthSession({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required String token,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required Map<String, dynamic> userData,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await storageService.saveToken(token);
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await storageService.saveUserData(userData);
    // Thuc thi cau lenh hien tai theo luong xu ly.
    apiService.setAuthToken(token);
  }

  // Khai bao bien _extractUserData de luu du lieu su dung trong xu ly.
  Map<String, dynamic> _extractUserData(Map<String, dynamic> responseBody) {
    // Khai bao bien directUser de luu du lieu su dung trong xu ly.
    final directUser = responseBody['user'];
    // Kiem tra dieu kien de re nhanh xu ly.
    if (directUser is Map<String, dynamic>) {
      // Tra ve ket qua cho noi goi ham.
      return directUser;
    }

    // Khai bao bien data de luu du lieu su dung trong xu ly.
    final data = responseBody['data'];
    // Kiem tra dieu kien de re nhanh xu ly.
    if (data is Map<String, dynamic> && data['id'] != null) {
      // Tra ve ket qua cho noi goi ham.
      return data;
    }

    // Kiem tra dieu kien de re nhanh xu ly.
    if (responseBody['id'] != null) {
      // Tra ve ket qua cho noi goi ham.
      return responseBody;
    }

    // Nem ngoai le de bao loi len tang xu ly phia tren.
    throw Exception('Không thể đọc dữ liệu người dùng từ backend.');
  }

  /// Login with email and password
  // Khai bao bien login de luu du lieu su dung trong xu ly.
  Future<UserModel> login({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required String email,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required String password,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) async {
    // Khai bao bien normalizedEmail de luu du lieu su dung trong xu ly.
    final normalizedEmail = email.trim().toLowerCase();

    // Kiem tra dieu kien de re nhanh xu ly.
    if (normalizedEmail == mockEmail && password == mockPassword) {
      // Khai bao bien user de luu du lieu su dung trong xu ly.
      final user = mockUser;
      // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
      await _saveAuthSession(token: _mockToken, userData: user.toJson());
      // Tra ve ket qua cho noi goi ham.
      return user;
    }

    // Bao boc khoi lenh co the phat sinh loi de xu ly an toan.
    try {
      // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
      final response = await apiService.post(
        // Thuc thi cau lenh hien tai theo luong xu ly.
        '/auth/login',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        data: {
          // Thuc thi cau lenh hien tai theo luong xu ly.
          'email': normalizedEmail,
          // Thuc thi cau lenh hien tai theo luong xu ly.
          'password': password,
        },
      );

      // Khai bao bien data de luu du lieu su dung trong xu ly.
      final data = response.data as Map<String, dynamic>;
      // Khai bao bien token de luu du lieu su dung trong xu ly.
      final token = data['token'] as String;
      // Khai bao bien userData de luu du lieu su dung trong xu ly.
      final userData = _extractUserData(data);

      // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
      await _saveAuthSession(token: token, userData: userData);

      // Tra ve ket qua cho noi goi ham.
      return UserModel.fromJson(userData);
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } catch (e) {
      // Nem ngoai le de bao loi len tang xu ly phia tren.
      throw Exception(
        // Thuc thi cau lenh hien tai theo luong xu ly.
        'Chưa có database/API. Dùng tài khoản mẫu: $mockEmail / $mockPassword',
      );
    }
  }

  /// Register new user
  // Khai bao bien register de luu du lieu su dung trong xu ly.
  Future<UserModel> register({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required String name,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required String email,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required String password,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required String phone,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) async {
    // Bao boc khoi lenh co the phat sinh loi de xu ly an toan.
    try {
      // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
      final response = await apiService.post(
        // Thuc thi cau lenh hien tai theo luong xu ly.
        '/auth/register',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        data: {
          // Thuc thi cau lenh hien tai theo luong xu ly.
          'name': name,
          // Thuc thi cau lenh hien tai theo luong xu ly.
          'email': email,
          // Thuc thi cau lenh hien tai theo luong xu ly.
          'password': password,
          // Thuc thi cau lenh hien tai theo luong xu ly.
          'phone': phone,
        },
      );

      // Khai bao bien data de luu du lieu su dung trong xu ly.
      final data = response.data as Map<String, dynamic>;
      // Khai bao bien token de luu du lieu su dung trong xu ly.
      final token = data['token'] as String;
      // Khai bao bien userData de luu du lieu su dung trong xu ly.
      final userData = _extractUserData(data);

      // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
      await _saveAuthSession(token: token, userData: userData);

      // Tra ve ket qua cho noi goi ham.
      return UserModel.fromJson(userData);
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } catch (e) {
      // Nem ngoai le de bao loi len tang xu ly phia tren.
      throw Exception('Đăng ký thất bại. Vui lòng kiểm tra backend và thử lại.');
    }
  }

  /// Logout
  // Khai bao bien logout de luu du lieu su dung trong xu ly.
  Future<void> logout() async {
    // Bao boc khoi lenh co the phat sinh loi de xu ly an toan.
    try {
      // Khai bao bien token de luu du lieu su dung trong xu ly.
      final token = storageService.getToken();
      // Kiem tra dieu kien de re nhanh xu ly.
      if (token != null && !token.startsWith('mock-token')) {
        // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
        await apiService.post('/auth/logout');
      }
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } catch (e) {
      // Ignore logout errors
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } finally {
      // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
      await storageService.removeToken();
      // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
      await storageService.removeUserData();
      // Thuc thi cau lenh hien tai theo luong xu ly.
      apiService.removeAuthToken();
    }
  }

  /// Forgot password
  // Khai bao bien forgotPassword de luu du lieu su dung trong xu ly.
  Future<void> forgotPassword(String email) async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await apiService.post(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      '/auth/forgot-password',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      data: {'email': email},
    );
  }

  /// Reset password
  // Khai bao bien resetPassword de luu du lieu su dung trong xu ly.
  Future<void> resetPassword({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required String token,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required String password,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await apiService.post(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      '/auth/reset-password',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      data: {
        // Thuc thi cau lenh hien tai theo luong xu ly.
        'token': token,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        'password': password,
      },
    );
  }

  /// Update user profile
  // Khai bao bien updateProfile de luu du lieu su dung trong xu ly.
  Future<UserModel> updateProfile(Map<String, dynamic> data) async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    final response = await apiService.put('/auth/profile', data: data);
    // Khai bao bien body de luu du lieu su dung trong xu ly.
    final body = response.data as Map<String, dynamic>;
    // Khai bao bien userData de luu du lieu su dung trong xu ly.
    final userData = _extractUserData(body);
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await storageService.saveUserData(userData);
    // Tra ve ket qua cho noi goi ham.
    return UserModel.fromJson(userData);
  }

  // Khai bao bien fetchProfile de luu du lieu su dung trong xu ly.
  Future<UserModel> fetchProfile() async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    final response = await apiService.get('/auth/profile');
    // Khai bao bien body de luu du lieu su dung trong xu ly.
    final body = response.data as Map<String, dynamic>;
    // Khai bao bien userData de luu du lieu su dung trong xu ly.
    final userData = _extractUserData(body);
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await storageService.saveUserData(userData);
    // Tra ve ket qua cho noi goi ham.
    return UserModel.fromJson(userData);
  }

  /// Initialize auth state (call on app start)
  // Khai bao bien initializeAuth de luu du lieu su dung trong xu ly.
  Future<void> initializeAuth() async {
    // Khai bao bien token de luu du lieu su dung trong xu ly.
    final token = storageService.getToken();
    // Kiem tra dieu kien de re nhanh xu ly.
    if (token != null) {
      // Thuc thi cau lenh hien tai theo luong xu ly.
      apiService.setAuthToken(token);
    }
  }
}
