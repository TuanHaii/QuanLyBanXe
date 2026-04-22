// ============================================================
// FILE: api_service.dart
// MÔ TẢ: Class trung tâm quản lý tất cả HTTP request trong app.
//        Được xây dựng trên thư viện Dio (package phổ biến hơn http
//        vì hỗ trợ interceptor, timeout, cancel request dễ dàng hơn).
//
//        BASE URL: http://10.0.2.2:3000/api
//        → 10.0.2.2 là địa chỉ đặc biệt của Android Emulator,
//          trỏ về localhost của máy tính host đang chạy backend.
//        → Nếu dùng máy thật: đổi thành IP LAN của máy bạn (vd: 192.168.1.x)
// ============================================================

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:quan_ly_ban_xe/shared/services/storage_service.dart';

import '../constants/app_constants.dart';

/// Class ApiService là "cổng giao tiếp" duy nhất giữa app và backend.
/// Mọi Service khác (AuthService, CarService, ...) đều dùng class này
/// để gởi request, không tự tạo Dio instance riêng.
class ApiService {
  /// _dio: instance của thư viện Dio, dùng để gửi HTTP request
  late final Dio _dio;

  /// _logger: in log đẹp hơn print() bình thường, giúp debug dễ hơn
  final Logger _logger = Logger();

  /// Constructor: khởi tạo Dio với cấu hình mặc định
  ApiService() {
    _dio = Dio(
      BaseOptions(
        // Base URL: tất cả endpoint sẽ được nối vào sau URL này
        // VD: baseUrl + '/auth/login' = 'http://10.0.2.2:3000/api/auth/login'
        baseUrl: AppConstants.baseUrl,

        // Timeout kết nối: nếu không kết nối được sau 30 giây thì báo lỗi
        connectTimeout: const Duration(
          milliseconds: AppConstants.connectionTimeout,
        ),

        // Timeout nhận dữ liệu: nếu server không trả về trong 30 giây thì báo lỗi
        receiveTimeout: const Duration(
          milliseconds: AppConstants.receiveTimeout,
        ),

        // Header mặc định gửi kèm mọi request
        // Content-Type: json → báo server là ta gửi JSON
        // Accept: json → yêu cầu server trả về JSON
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Đăng ký interceptor để log request/response ra console
    _setupInterceptors();
  }

  /// Hàm cài interceptor cho Dio.
  /// Interceptor là middleware: chạy trước/sau mỗi request để log, thêm header, v.v.
  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        // onRequest: chạy TRƯỚC khi gửi request → log thông tin request
        onRequest: (options, handler) {
          _logger.d(
            '🚀 REQUEST [${options.method}] → ${options.baseUrl}${options.path}',
          );
          _logger.d('   Headers: ${options.headers}');
          if (options.data != null) {
            _logger.d('   Body: ${options.data}');
          }
          return handler.next(options); // tiếp tục gửi request
        },

        // onResponse: chạy KHI nhận được response → log status và data
        onResponse: (response, handler) {
          _logger.d(
            '✅ RESPONSE [${response.statusCode}] ← ${response.requestOptions.path}',
          );
          _logger.d('   Data: ${response.data}');
          return handler.next(response); // tiếp tục xử lý response
        },

        // onError: chạy KHI có lỗi → log lỗi để debug
        onError: (error, handler) {
          _logger.e(
            '❌ ERROR [${error.response?.statusCode}] ← ${error.requestOptions.path}',
          );
          _logger.e('   Message: ${error.message}');
          _logger.e('   Response: ${error.response?.data}');
          return handler.next(error); // tiếp tục ném lỗi ra để catch ở Service
        },
      ),
    );
  }

  // -------------------------------------------------------
  // Quản lý Auth Token
  // -------------------------------------------------------

  /// Hàm này set Authorization header cho tất cả request tiếp theo.
  /// Được gọi SAU KHI đăng nhập thành công.
  /// Ví dụ: Authorization: Bearer eyJhbGci...
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
    print('🔑 [ApiService] Đã set Authorization token');
  }

  /// Hàm này xóa Authorization header.
  /// Được gọi KHI đăng xuất.
  void removeAuthToken() {
    _dio.options.headers.remove('Authorization');
    print('🔑 [ApiService] Đã xóa Authorization token');
  }

  // -------------------------------------------------------
  // Các phương thức HTTP cơ bản
  // -------------------------------------------------------

  /// GET request: dùng để lấy dữ liệu (Read)
  /// Ví dụ: GET /api/cars → lấy danh sách xe
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>?
    queryParameters, // tham số trên URL vd: ?page=1&limit=20
    Options? options,
  }) async {
    return await _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// POST request: dùng để tạo mới dữ liệu (Create)
  /// Ví dụ: POST /api/auth/login → đăng nhập
  Future<Response<T>> post<T>(
    String path, {
    dynamic data, // body của request (Map → được tự động encode thành JSON)
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// PUT request: dùng để cập nhật toàn bộ dữ liệu (Update)
  /// Ví dụ: PUT /api/cars/123 → cập nhật xe có id=123
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// DELETE request: dùng để xóa dữ liệu
  /// Ví dụ: DELETE /api/cars/123 → xóa xe có id=123
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// PATCH request: dùng để cập nhật một phần dữ liệu (Partial Update)
  /// Ví dụ: PATCH /api/cars/123 → chỉ cập nhật giá xe
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// Upload file (dùng multipart/form-data)
  /// Ví dụ: upload ảnh xe lên server
  Future<Response<T>> uploadFile<T>(
    String path, {
    required FormData formData,
    void Function(int, int)? onSendProgress, // callback để hiện progress upload
  }) async {
    return await _dio.post<T>(
      path,
      data: formData,
      onSendProgress: onSendProgress,
      options: Options(headers: {'Content-Type': 'multipart/form-data'}),
    );
  }
}
