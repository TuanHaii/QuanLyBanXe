// Nap thu vien hoac module can thiet.
import 'package:dio/dio.dart';
// Nap thu vien hoac module can thiet.
import 'package:logger/logger.dart';

// Nap thu vien hoac module can thiet.
import '../constants/app_constants.dart';

// Dinh nghia lop ApiService de gom nhom logic lien quan.
class ApiService {
  // Khai bao bien final de luu du lieu su dung trong xu ly.
  late final Dio _dio;
  // Khai bao bien Logger de luu du lieu su dung trong xu ly.
  final Logger _logger = Logger();

  // Goi ham de thuc thi tac vu can thiet.
  ApiService() {
    // Gan gia tri cho bien _dio.
    _dio = Dio(
      // Goi ham de thuc thi tac vu can thiet.
      BaseOptions(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        baseUrl: AppConstants.baseUrl,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        connectTimeout: const Duration(milliseconds: AppConstants.connectionTimeout),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        receiveTimeout: const Duration(milliseconds: AppConstants.receiveTimeout),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        headers: {
          // Thuc thi cau lenh hien tai theo luong xu ly.
          'Content-Type': 'application/json',
          // Thuc thi cau lenh hien tai theo luong xu ly.
          'Accept': 'application/json',
        },
      ),
    );

    // Khai bao constructor _setupInterceptors de khoi tao doi tuong.
    _setupInterceptors();
  }

  // Dinh nghia ham _setupInterceptors de xu ly nghiep vu tuong ung.
  void _setupInterceptors() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _dio.interceptors.add(
      // Goi ham de thuc thi tac vu can thiet.
      InterceptorsWrapper(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onRequest: (options, handler) {
          // Thuc thi cau lenh hien tai theo luong xu ly.
          _logger.d('REQUEST[${options.method}] => PATH: ${options.path}');
          // Tra ve ket qua cho noi goi ham.
          return handler.next(options);
        },
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onResponse: (response, handler) {
          // Thuc thi cau lenh hien tai theo luong xu ly.
          _logger.d(
            // Thuc thi cau lenh hien tai theo luong xu ly.
            'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
          );
          // Tra ve ket qua cho noi goi ham.
          return handler.next(response);
        },
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onError: (error, handler) {
          // Thuc thi cau lenh hien tai theo luong xu ly.
          _logger.e(
            // Thuc thi cau lenh hien tai theo luong xu ly.
            'ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}',
          );
          // Tra ve ket qua cho noi goi ham.
          return handler.next(error);
        },
      ),
    );
  }

  /// Set auth token for authenticated requests
  // Dinh nghia ham setAuthToken de xu ly nghiep vu tuong ung.
  void setAuthToken(String token) {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Remove auth token
  // Dinh nghia ham removeAuthToken de xu ly nghiep vu tuong ung.
  void removeAuthToken() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _dio.options.headers.remove('Authorization');
  }

  /// GET request
  // Thuc thi cau lenh hien tai theo luong xu ly.
  Future<Response<T>> get<T>(
    // Khai bao bien path de luu du lieu su dung trong xu ly.
    String path, {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    Map<String, dynamic>? queryParameters,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    Options? options,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) async {
    // Tra ve ket qua cho noi goi ham.
    return await _dio.get<T>(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      path,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      queryParameters: queryParameters,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      options: options,
    );
  }

  /// POST request
  // Thuc thi cau lenh hien tai theo luong xu ly.
  Future<Response<T>> post<T>(
    // Khai bao bien path de luu du lieu su dung trong xu ly.
    String path, {
    // Khai bao bien data de luu du lieu su dung trong xu ly.
    dynamic data,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    Map<String, dynamic>? queryParameters,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    Options? options,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) async {
    // Tra ve ket qua cho noi goi ham.
    return await _dio.post<T>(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      path,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      data: data,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      queryParameters: queryParameters,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      options: options,
    );
  }

  /// PUT request
  // Thuc thi cau lenh hien tai theo luong xu ly.
  Future<Response<T>> put<T>(
    // Khai bao bien path de luu du lieu su dung trong xu ly.
    String path, {
    // Khai bao bien data de luu du lieu su dung trong xu ly.
    dynamic data,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    Map<String, dynamic>? queryParameters,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    Options? options,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) async {
    // Tra ve ket qua cho noi goi ham.
    return await _dio.put<T>(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      path,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      data: data,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      queryParameters: queryParameters,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      options: options,
    );
  }

  /// DELETE request
  // Thuc thi cau lenh hien tai theo luong xu ly.
  Future<Response<T>> delete<T>(
    // Khai bao bien path de luu du lieu su dung trong xu ly.
    String path, {
    // Khai bao bien data de luu du lieu su dung trong xu ly.
    dynamic data,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    Map<String, dynamic>? queryParameters,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    Options? options,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) async {
    // Tra ve ket qua cho noi goi ham.
    return await _dio.delete<T>(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      path,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      data: data,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      queryParameters: queryParameters,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      options: options,
    );
  }

  /// PATCH request
  // Thuc thi cau lenh hien tai theo luong xu ly.
  Future<Response<T>> patch<T>(
    // Khai bao bien path de luu du lieu su dung trong xu ly.
    String path, {
    // Khai bao bien data de luu du lieu su dung trong xu ly.
    dynamic data,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    Map<String, dynamic>? queryParameters,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    Options? options,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) async {
    // Tra ve ket qua cho noi goi ham.
    return await _dio.patch<T>(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      path,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      data: data,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      queryParameters: queryParameters,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      options: options,
    );
  }

  /// Upload file
  // Thuc thi cau lenh hien tai theo luong xu ly.
  Future<Response<T>> uploadFile<T>(
    // Khai bao bien path de luu du lieu su dung trong xu ly.
    String path, {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required FormData formData,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    void Function(int, int)? onSendProgress,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) async {
    // Tra ve ket qua cho noi goi ham.
    return await _dio.post<T>(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      path,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      data: formData,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      onSendProgress: onSendProgress,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      options: Options(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        headers: {'Content-Type': 'multipart/form-data'},
      ),
    );
  }
}
