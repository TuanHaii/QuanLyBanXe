import 'package:dio/dio.dart';
import '../../../shared/services/api_service.dart';
import '../models/car_model.dart';

class CarService {
  final ApiService _apiService;

  CarService(this._apiService);

  // GET /cars
  Future<List<CarModel>> getCars() async {
    try {
      final response = await _apiService.get('/cars');

      if (response.data['success'] == true) {
        // Lấy array data từ JSON
        final List<dynamic> data = response.data['data'];
        // Map từng phần tử thành CarModel
        return data.map((json) => CarModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Không thể tải danh sách xe');
    }
  }
}
