import '../../../shared/services/api_service.dart';
import '../models/car_model.dart';

class CarService {
  final ApiService apiService;

  CarService({required this.apiService});

  Future<List<CarModel>> fetchCars({
    String? query,
    CarStatus? status,
  }) async {
    final response = await apiService.get(
      '/cars',
      queryParameters: {
        if (query != null && query.trim().isNotEmpty) 'query': query.trim(),
        if (status != null) 'status': status.name,
      },
    );

    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw Exception('Invalid response from car service');
    }

    final items = data['data'] as List<dynamic>? ?? const [];
    return items
        .whereType<Map<String, dynamic>>()
        .map(CarModel.fromJson)
        .toList(growable: false);
  }

  Future<CarModel> fetchCarById(String id) async {
    final response = await apiService.get('/cars/$id');
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw Exception('Invalid response from car service');
    }

    final item = data['data'];
    if (item is! Map<String, dynamic>) {
      throw Exception('Car detail not found');
    }

    return CarModel.fromJson(item);
  }

  Future<CarModel> createCar(Map<String, dynamic> payload) async {
    final response = await apiService.post('/cars', data: payload);
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw Exception('Invalid response from car service');
    }

    final item = data['data'];
    if (item is! Map<String, dynamic>) {
      throw Exception('Create car failed');
    }

    return CarModel.fromJson(item);
  }

  Future<void> deleteCar(String id) async {
    await apiService.delete('/cars/$id');
  }
}
