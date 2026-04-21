import 'package:dio/dio.dart';
import 'storage_service.dart';

class ApiService {
  late final Dio _dio;
  final StorageService _storageService;

  ApiService(this._storageService) {
    _dio = Dio(
      BaseOptions(
        // Dùng 10.0.2.2 cho máy ảo Android, hoặc localhost/IP thật tuỳ môi trường
        baseUrl: 'http://10.0.2.2:3000/api',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // Interceptor để tự động gắn Token vào mọi request
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storageService.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          // TODO: Có thể xử lý văng ra trang Login nếu mã lỗi là 401 ở đây
          return handler.next(e);
        },
      ),
    );
  }

  // =========================================================================
  // CÁC HÀM WRAPPER METHOD CHO HTTP REQUESTS
  // =========================================================================

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> delete(String path, {dynamic data}) async {
    try {
      return await _dio.delete(path, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Hàm xử lý lỗi chung để bóc tách thông báo từ Backend
  Exception _handleError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      // Backend của bạn trả về { "success": false, "message": "Lỗi gì đó" }
      final message = e.response?.data['message'] ?? 'Đã xảy ra lỗi hệ thống';
      return Exception(message);
    }
    return Exception('Không thể kết nối đến máy chủ. Vui lòng kiểm tra mạng.');
  }
}
