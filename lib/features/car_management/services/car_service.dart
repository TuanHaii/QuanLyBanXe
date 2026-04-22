import '../../../shared/services/api_service.dart';
import '../models/car_model.dart';
import '../models/catalog_option_model.dart';

class CarService {
  final ApiService apiService;

  CarService({required this.apiService});

  Future<List<CarModel>> layDanhSachXe() async {
    final response = await apiService.get('/cars');
    final body = _extractBody(response.data);

    final items = _extractItems(body['data']);
    return items.map(CarModel.fromJson).toList(growable: false);
  }

  Future<CarModel> layXeTheoMa(int maXe) async {
    final response = await apiService.get('/cars/$maXe');
    final body = _extractBody(response.data);
    return CarModel.fromJson(_extractItem(body['data']));
  }

  Future<CarModel> themXe(CarModel xeMoi) async {
    final response = await apiService.post('/cars', data: xeMoi.toJson());
    final body = _extractBody(response.data);
    if (body['success'] == false) {
      throw Exception(body['message'] ?? 'Thêm xe thất bại');
    }

    return CarModel.fromJson(_extractItem(body['data']));
  }

  Future<CarModel> suaXe(int maXe, CarModel xeDaSua) async {
    final response = await apiService.put(
      '/cars/$maXe',
      data: xeDaSua.toJson(),
    );
    final body = _extractBody(response.data);
    if (body['success'] == false) {
      throw Exception(body['message'] ?? 'Cập nhật xe thất bại');
    }

    return CarModel.fromJson(_extractItem(body['data']));
  }

  Future<void> xoaXe(int maXe) async {
    final response = await apiService.delete('/cars/$maXe');
    final body = _extractBody(response.data);
    if (body['success'] == false) {
      throw Exception(body['message'] ?? 'Xóa xe thất bại');
    }
  }

  Future<List<CatalogOption>> fetchBrands() async {
    final response = await apiService.get('/catalog/brands');
    final body = _extractBody(response.data);

    return _extractItems(
      body['data'],
    ).map(CatalogOption.fromBrandJson).toList(growable: false);
  }

  Future<List<CatalogOption>> fetchCarTypes() async {
    final response = await apiService.get('/catalog/car-types');
    final body = _extractBody(response.data);

    return _extractItems(
      body['data'],
    ).map(CatalogOption.fromCategoryJson).toList(growable: false);
  }

  Future<CatalogOption> ensureBrand(String tenHang) async {
    final normalized = tenHang.trim();
    final existing = await fetchBrands();
    for (final brand in existing) {
      if (brand.name.toLowerCase() == normalized.toLowerCase()) {
        return brand;
      }
    }

    final response = await apiService.post(
      '/catalog/brands',
      data: {'tenHang': normalized},
    );
    final body = _extractBody(response.data);
    return CatalogOption.fromBrandJson(_extractItem(body['data']));
  }

  Future<CatalogOption> ensureCarType(String tenLoai) async {
    final normalized = tenLoai.trim();
    final existing = await fetchCarTypes();
    for (final category in existing) {
      if (category.name.toLowerCase() == normalized.toLowerCase()) {
        return category;
      }
    }

    final response = await apiService.post(
      '/catalog/car-types',
      data: {'tenLoai': normalized},
    );
    final body = _extractBody(response.data);
    return CatalogOption.fromCategoryJson(_extractItem(body['data']));
  }

  Future<List<CarModel>> fetchCars({String? query, dynamic status}) async {
    final cars = await layDanhSachXe();
    if (query == null || query.trim().isEmpty) {
      return cars;
    }

    final normalizedQuery = query.trim().toLowerCase();
    return cars
        .where((car) => car.searchIndex.contains(normalizedQuery))
        .toList(growable: false);
  }

  Future<CarModel> fetchCarById(String id) async {
    final parsedId = int.tryParse(id);
    if (parsedId == null) {
      throw Exception('Mã xe không hợp lệ');
    }
    return layXeTheoMa(parsedId);
  }

  Future<CarModel> createCar(Map<String, dynamic> payload) async {
    return themXe(CarModel.fromJson(payload));
  }

  Future<void> deleteCar(String id) async {
    final parsedId = int.tryParse(id);
    if (parsedId == null) {
      throw Exception('Mã xe không hợp lệ');
    }
    await xoaXe(parsedId);
  }

  Map<String, dynamic> _extractBody(dynamic raw) {
    if (raw is Map<String, dynamic>) {
      return raw;
    }

    if (raw is Map) {
      return Map<String, dynamic>.from(raw);
    }

    throw Exception('Invalid response from car service');
  }

  List<Map<String, dynamic>> _extractItems(dynamic raw) {
    if (raw is List) {
      return raw
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList(growable: false);
    }

    return const [];
  }

  Map<String, dynamic> _extractItem(dynamic raw) {
    if (raw is Map<String, dynamic>) {
      return raw;
    }

    if (raw is Map) {
      return Map<String, dynamic>.from(raw);
    }

    throw Exception('Car detail not found');
  }
}
