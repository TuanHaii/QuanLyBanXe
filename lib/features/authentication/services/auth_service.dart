import 'package:dio/dio.dart';
import '../../../shared/services/api_service.dart';
import '../../../shared/services/storage_service.dart';
import '../models/user_model.dart';

class AuthService {
  final ApiService _apiService;
  final StorageService _storageService;
  bool _isLoggedIn = false;
  UserModel? _currentUser;

  bool get isLoggedIn => _isLoggedIn;
  UserModel? get currentUser => _currentUser;

  AuthService(this._apiService, this._storageService);

  // Phương thức khởi tạo để kiểm tra trạng thái đăng nhập khi app bắt đầu
  Future<void> initializeAuth() async {
    final token = await _storageService.getToken();

    if (token != null && token.isNotEmpty) {
      try {
        // Dùng token gọi thử lấy Profile để xác nhận Token chưa hết hạn
        _currentUser = await getProfile();
        _isLoggedIn = true;
      } catch (e) {
        // Nếu lỗi (vd: mã 401 do token hết hạn), tiến hành dọn dẹp
        await _storageService.removeToken();
        _isLoggedIn = false;
        _currentUser = null;
      }
    } else {
      _isLoggedIn = false;
      _currentUser = null;
    }
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      final response = await _apiService.post(
        '/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
        },
      );

      if (response.data['success'] == true) {
        final data = response.data['data'];
        await _storageService.saveToken(data['token']);

        // Cập nhật trạng thái
        _currentUser = UserModel.fromJson(data['user']);
        _isLoggedIn = true;

        return _currentUser!;
      }
      throw Exception(response.data['message']);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Lỗi đăng ký');
    }
  }

  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _apiService.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      if (response.data['success'] == true) {
        final data = response.data['data'];
        await _storageService.saveToken(data['token']);

        // Cập nhật trạng thái
        _currentUser = UserModel.fromJson(data['user']);
        _isLoggedIn = true;

        return _currentUser!;
      }
      throw Exception(response.data['message']);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Sai email hoặc mật khẩu');
    }
  }

  Future<void> logout() async {
    try {
      // Gọi API để hủy token trên server (nếu BE có xử lý blacklist)
      await _apiService.post('/auth/logout');
    } catch (e) {
      // Bỏ qua lỗi mạng khi logout, vẫn phải xóa token local
    } finally {
      // Dọn dẹp token và biến trạng thái
      await _storageService.removeToken();
      _isLoggedIn = false;
      _currentUser = null;
    }
  }

  Future<String?> forgotPassword(String email) async {
    try {
      final response = await _apiService.post(
        '/auth/forgot-password',
        data: {'email': email},
      );
      return response.data['data']?['resetToken'];
    } catch (e) {
      throw Exception('Không thể gửi yêu cầu khôi phục');
    }
  }

  Future<void> resetPassword(String token, String newPassword) async {
    try {
      await _apiService.post(
        '/auth/reset-password',
        data: {'token': token, 'password': newPassword},
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Token không hợp lệ hoặc hết hạn',
      );
    }
  }

  Future<UserModel> getProfile() async {
    try {
      final response = await _apiService.get('/auth/profile');
      if (response.data['success'] == true) {
        _currentUser = UserModel.fromJson(response.data['data']);
        return _currentUser!;
      }
      throw Exception('Không thể tải hồ sơ');
    } catch (e) {
      throw Exception('Lỗi kết nối hồ sơ');
    }
  }

  Future<UserModel> updateProfile({
    String? name,
    String? phone,
    String? email,
  }) async {
    try {
      final response = await _apiService.put(
        '/auth/profile',
        data: {
          if (name != null) 'name': name,
          if (phone != null) 'phone': phone,
          if (email != null) 'email': email,
        },
      );
      if (response.data['success'] == true) {
        _currentUser = UserModel.fromJson(response.data['data']);
        return _currentUser!;
      }
      throw Exception('Cập nhật thất bại');
    } catch (e) {
      throw Exception('Lỗi cập nhật hồ sơ');
    }
  }
}
