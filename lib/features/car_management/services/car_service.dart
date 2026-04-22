// Nap thu vien hoac module can thiet.
import '../../../shared/services/api_service.dart';
// Nap thu vien hoac module can thiet.
import '../models/car_model.dart';

// Dinh nghia lop CarService de gom nhom logic lien quan.
class CarService {
  // Khai bao bien ApiService de luu du lieu su dung trong xu ly.
  final ApiService apiService;

  // Khai bao constructor CarService de khoi tao doi tuong.
  CarService({required this.apiService});

  // Thuc thi cau lenh hien tai theo luong xu ly.
  Future<List<CarModel>> fetchCars({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? query,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    CarStatus? status,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    final response = await apiService.get(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      '/cars',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      queryParameters: {
        // Kiem tra dieu kien de re nhanh xu ly.
        if (query != null && query.trim().isNotEmpty) 'query': query.trim(),
        // Kiem tra dieu kien de re nhanh xu ly.
        if (status != null) 'status': status.name,
      },
    );

    // Khai bao bien data de luu du lieu su dung trong xu ly.
    final data = response.data;
    // Kiem tra dieu kien de re nhanh xu ly.
    if (data is! Map<String, dynamic>) {
      // Nem ngoai le de bao loi len tang xu ly phia tren.
      throw Exception('Invalid response from car service');
    }

    // Khai bao bien items de luu du lieu su dung trong xu ly.
    final items = data['data'] as List<dynamic>? ?? const [];
    // Tra ve ket qua cho noi goi ham.
    return items
        // Thuc thi cau lenh hien tai theo luong xu ly.
        .whereType<Map<String, dynamic>>()
        // Thuc thi cau lenh hien tai theo luong xu ly.
        .map(CarModel.fromJson)
        // Thuc thi cau lenh hien tai theo luong xu ly.
        .toList(growable: false);
  }

  // Khai bao bien fetchCarById de luu du lieu su dung trong xu ly.
  Future<CarModel> fetchCarById(String id) async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    final response = await apiService.get('/cars/$id');
    // Khai bao bien data de luu du lieu su dung trong xu ly.
    final data = response.data;
    // Kiem tra dieu kien de re nhanh xu ly.
    if (data is! Map<String, dynamic>) {
      // Nem ngoai le de bao loi len tang xu ly phia tren.
      throw Exception('Invalid response from car service');
    }

    // Khai bao bien item de luu du lieu su dung trong xu ly.
    final item = data['data'];
    // Kiem tra dieu kien de re nhanh xu ly.
    if (item is! Map<String, dynamic>) {
      // Nem ngoai le de bao loi len tang xu ly phia tren.
      throw Exception('Car detail not found');
    }

    // Tra ve ket qua cho noi goi ham.
    return CarModel.fromJson(item);
  }

  // Khai bao bien createCar de luu du lieu su dung trong xu ly.
  Future<CarModel> createCar(Map<String, dynamic> payload) async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    final response = await apiService.post('/cars', data: payload);
    // Khai bao bien data de luu du lieu su dung trong xu ly.
    final data = response.data;
    // Kiem tra dieu kien de re nhanh xu ly.
    if (data is! Map<String, dynamic>) {
      // Nem ngoai le de bao loi len tang xu ly phia tren.
      throw Exception('Invalid response from car service');
    }

    // Khai bao bien item de luu du lieu su dung trong xu ly.
    final item = data['data'];
    // Kiem tra dieu kien de re nhanh xu ly.
    if (item is! Map<String, dynamic>) {
      // Nem ngoai le de bao loi len tang xu ly phia tren.
      throw Exception('Create car failed');
    }

    // Tra ve ket qua cho noi goi ham.
    return CarModel.fromJson(item);
  }

  // Khai bao bien deleteCar de luu du lieu su dung trong xu ly.
  Future<void> deleteCar(String id) async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await apiService.delete('/cars/$id');
  }
}
