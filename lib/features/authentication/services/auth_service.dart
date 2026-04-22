// ============================================================
// FILE: auth_service.dart
// MÔ TẢ: Service xử lý toàn bộ logic xác thực người dùng.
// Được viết chuẩn theo API Docs của BE_QLBX.
// ============================================================

import 'package:dio/dio.dart';
import '../../../shared/services/api_service.dart';
import '../../../shared/services/storage_service.dart';
import '../models/user_model.dart';

class AuthService {
  // Biến apiService để gọi HTTP request (GET, POST, PUT, DELETE)
  final ApiService apiService;

  // Biến storageService để lưu token xuống bộ nhớ máy tính/điện thoại
  final StorageService storageService;

  AuthService({required this.apiService, required this.storageService});
  // ============================================================
  // QUẢN LÝ TRẠNG THÁI (STATE) ĐĂNG NHẬP
  // ============================================================

  // Biến cờ đánh dấu người dùng đã đăng nhập hay chưa
  bool _isLoggedIn = false;

  // Biến lưu trữ thông tin người dùng hiện tại (để hiển thị tên, avatar ra UI)
  UserModel? _currentUser;

  // Cung cấp Getter để các file UI (như splash_screen) có thể đọc được trạng thái
  bool get isLoggedIn => _isLoggedIn;
  UserModel? get currentUser => _currentUser;

  // ============================================================
  // HÀM: initializeAuth()
  // MÔ TẢ: Khởi tạo trạng thái đăng nhập khi vừa mở app
  // Được gọi trong file splash_screen.dart
  // ============================================================
  Future<void> initializeAuth() async {
    print('⏳ [AuthService] Đang kiểm tra trạng thái đăng nhập cũ...');
    try {
      // Bước 1: Đọc token từ bộ nhớ điện thoại (đã lưu ở lần đăng nhập trước)
      // Lưu ý: Tùy vào cách bạn viết StorageService mà nó có thể cần 'await' hay không.
      final token = await storageService.getToken();

      // Nếu có token (người dùng đã từng đăng nhập và chưa bấm Đăng xuất)
      if (token != null && token.isNotEmpty) {
        // Bước 2: Nạp token này vào ApiService để các lệnh gọi API tiếp theo được phép đi qua
        apiService.setAuthToken(token);

        // Bước 3: Dùng token này gọi thử API lấy Profile xem token còn hạn không
        // (Bởi vì token có thể nằm trong máy nhưng đã hết hạn từ 3 ngày trước)
        _currentUser = await fetchProfile();

        // Nếu chạy qua được dòng trên mà không văng lỗi -> Token còn sống!
        _isLoggedIn = true;
        print(
          '✅ [AuthService] Token còn hạn. Tự động đăng nhập cho: ${_currentUser?.name}',
        );
      } else {
        // Nếu không có token -> Người dùng mới tải app hoặc đã đăng xuất
        _isLoggedIn = false;
        _currentUser = null;
        print('ℹ️ [AuthService] Không có phiên đăng nhập nào được lưu.');
      }
    } catch (e) {
      // Sẽ nhảy vào đây nếu token hết hạn (Backend chửi 401) hoặc mất mạng
      print(
        '⚠️ [AuthService] Phiên đăng nhập cũ không hợp lệ hoặc lỗi mạng: $e',
      );

      // Xóa sạch dấu vết token cũ bị hỏng để đảm bảo an toàn
      await storageService.removeToken();
      await storageService.removeUserData();
      apiService.removeAuthToken();

      // Đặt trạng thái về chưa đăng nhập để văng ra màn hình Login
      _isLoggedIn = false;
      _currentUser = null;
    }
  }

  // ============================================================
  // HÀM: updateProfile() - Cập nhật thông tin cá nhân
  // GỌI API: PUT /api/auth/profile
  // BODY: { "name": "...", "phone": "..." }
  // ============================================================
  Future<UserModel> updateProfile(Map<String, dynamic> data) async {
    try {
      print('🌐 [AuthService] Đang gọi API Cập nhật Profile với data: $data');

      // 1. Gọi API PUT gửi dữ liệu mới (tên, sđt) lên Backend
      final response = await apiService.put('/auth/profile', data: data);

      final responseBody = response.data as Map<String, dynamic>;

      if (responseBody['success'] == true) {
        // 2. Lấy cục thông tin user mới nhất do BE trả về
        // Theo tài liệu BE, data user sau khi update nằm trong key 'data'
        final userData = responseBody['data'] as Map<String, dynamic>;

        // 3. Ghi đè thông tin mới này xuống bộ nhớ điện thoại (SharedPreferences)
        await storageService.saveUserData(userData);

        // 4. Cập nhật luôn biến _currentUser đang lưu trên RAM
        _currentUser = UserModel.fromJson(userData);

        print('✅ [AuthService] Cập nhật profile thành công!');

        // 5. Trả về user mới để màn hình UI tự động cập nhật chữ
        return _currentUser!;
      } else {
        // Nếu BE trả về success: false
        throw Exception(responseBody['message'] ?? 'Cập nhật thất bại');
      }
    } on DioException catch (e) {
      print('❌ [AuthService] Lỗi mạng khi cập nhật profile: $e');

      // Bắt lỗi Token hết hạn
      if (e.response?.statusCode == 401) {
        throw Exception('Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.');
      }

      // Lấy câu chửi từ Backend (ví dụ: "Số điện thoại không hợp lệ")
      final serverMsg =
          e.response?.data?['message'] ??
          'Không thể cập nhật thông tin. Vui lòng kiểm tra mạng.';
      throw Exception(serverMsg);
    } catch (e) {
      print('❌ [AuthService] Lỗi hệ thống: $e');
      throw Exception('Lỗi cập nhật: $e');
    }
  }

  // ============================================================
  // HÀM: login() - Đăng nhập
  // GỌI API: POST /api/auth/login
  // ============================================================
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      print('🌐 [AuthService] Đang gọi API Đăng nhập với email: $email');

      // Gọi API POST gửi email và password lên Backend
      final response = await apiService.post(
        '/auth/login',
        data: {'email': email.trim().toLowerCase(), 'password': password},
      );

      // Biến responseBody chứa toàn bộ cục JSON mà Backend trả về
      final responseBody = response.data as Map<String, dynamic>;

      // Theo tài liệu BE, nếu thành công thì success sẽ là true
      if (responseBody['success'] == true) {
        // 1. Lấy token từ JSON
        final token = responseBody['token'] as String;

        // 2. Lấy thông tin user từ JSON
        final userData = responseBody['user'] as Map<String, dynamic>;

        // 3. Lưu token và thông tin user xuống bộ nhớ máy (để lần sau mở app không cần đăng nhập)
        await storageService.saveToken(token);
        await storageService.saveUserData(userData);

        // 4. Nhét token vào ApiService để các lần gọi API sau (như lấy danh sách xe) sẽ tự có token
        apiService.setAuthToken(token);

        print('✅ [AuthService] Đăng nhập thành công! Token: $token');

        // Chuyển cục JSON userData thành UserModel và trả về cho giao diện
        return UserModel.fromJson(userData);
      } else {
        // Trái lại nếu BE báo false, ném ra lỗi để giao diện bắt được
        throw Exception(responseBody['message'] ?? 'Đăng nhập thất bại');
      }
    } on DioException catch (e) {
      // Bắt lỗi do kết nối mạng hoặc lỗi do BE ném ra (VD: Sai mật khẩu - Code 401)
      print('❌ [AuthService] Lỗi mạng khi đăng nhập: $e');
      final serverMsg =
          e.response?.data?['message'] ?? 'Sai email hoặc mật khẩu';
      throw Exception(serverMsg);
    } catch (e) {
      // Bắt các lỗi code khác (VD: lỗi parse JSON)
      print('❌ [AuthService] Lỗi hệ thống: $e');
      throw Exception('Lỗi đăng nhập: $e');
    }
  }

  // ============================================================
  // HÀM: register() - Đăng ký
  // GỌI API: POST /api/auth/register
  // ============================================================
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      print('🌐 [AuthService] Đang gọi API Đăng ký');

      final response = await apiService.post(
        '/auth/register',
        data: {
          'name': name.trim(),
          'email': email.trim().toLowerCase(),
          'password': password,
          'phone': phone.trim(),
        },
      );

      final responseBody = response.data as Map<String, dynamic>;

      if (responseBody['success'] == true) {
        // Backend QLBX trả về token và user ngay sau khi đăng ký thành công
        final token = responseBody['token'] as String;
        final userData = responseBody['user'] as Map<String, dynamic>;

        // Tự động đăng nhập luôn cho người dùng
        await storageService.saveToken(token);
        await storageService.saveUserData(userData);
        apiService.setAuthToken(token);

        print('✅ [AuthService] Đăng ký thành công!');
        return UserModel.fromJson(userData);
      } else {
        throw Exception(responseBody['message']);
      }
    } on DioException catch (e) {
      print('❌ [AuthService] Lỗi API đăng ký: $e');
      final msg =
          e.response?.data?['message'] ??
          'Dữ liệu không hợp lệ hoặc email đã tồn tại';
      throw Exception(msg);
    }
  }

  // ============================================================
  // HÀM: logout() - Đăng xuất
  // GỌI API: POST /api/auth/logout
  // ============================================================
  Future<void> logout() async {
    try {
      print('🚪 [AuthService] Đang gọi API Đăng xuất...');

      // Gọi BE để hủy token (nếu BE có xử lý blacklist)
      await apiService.post('/auth/logout');
    } catch (e) {
      // Bỏ qua lỗi mạng nếu BE sập, vì quan trọng nhất là phải xóa local data
      print('⚠️ [AuthService] Lỗi gọi API logout (vẫn tiếp tục xóa data): $e');
    } finally {
      // CUỐI CÙNG: Bắt buộc xóa sạch dữ liệu trên điện thoại
      await storageService.removeToken();
      await storageService.removeUserData();
      apiService.removeAuthToken();
      print('✅ [AuthService] Đã xóa toàn bộ phiên đăng nhập khỏi máy');
    }
  }

  // ============================================================
  // HÀM: fetchProfile() - Lấy thông tin user mới nhất
  // GỌI API: GET /api/auth/profile
  // ============================================================
  Future<UserModel> fetchProfile() async {
    try {
      print('🌐 [AuthService] Đang gọi API lấy Profile');

      final response = await apiService.get('/auth/profile');
      final responseBody = response.data as Map<String, dynamic>;

      if (responseBody['success'] == true) {
        // Lưu ý: Theo Doc của BE_QLBX, API profile trả user nằm trong key 'data' chứ không phải 'user'
        final userData = responseBody['data'] as Map<String, dynamic>;

        // Lưu đè thông tin mới xuống máy
        await storageService.saveUserData(userData);

        print('✅ [AuthService] Lấy profile thành công');
        return UserModel.fromJson(userData);
      } else {
        throw Exception(responseBody['message']);
      }
    } on DioException catch (e) {
      print('❌ [AuthService] Lỗi lấy profile: $e');
      if (e.response?.statusCode == 401) {
        throw Exception('Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.');
      }
      throw Exception('Không thể lấy thông tin. Vui lòng kiểm tra mạng.');
    }
  }
}
