// Nap thu vien hoac module can thiet.
import '../../../shared/services/api_service.dart';
// Nap thu vien hoac module can thiet.
import '../models/inventory_quick_action_models.dart';

// Dinh nghia lop InventoryQuickActionService de gom nhom logic lien quan.
class InventoryQuickActionService {
  // Khai bao bien ApiService de luu du lieu su dung trong xu ly.
  final ApiService apiService;

  // Khai bao constructor InventoryQuickActionService de khoi tao doi tuong.
  InventoryQuickActionService({required this.apiService});

  // Khai bao bien fetchInventoryOverview de luu du lieu su dung trong xu ly.
  Future<InventoryQuickActionData> fetchInventoryOverview() async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    final response = await apiService.get('/cars');
    // Khai bao bien body de luu du lieu su dung trong xu ly.
    final body = response.data;

    // Kiem tra dieu kien de re nhanh xu ly.
    if (body is! Map<String, dynamic>) {
      // Nem ngoai le de bao loi len tang xu ly phia tren.
      throw Exception('Invalid response from car service');
    }

    // Khai bao bien items de luu du lieu su dung trong xu ly.
    final items = body['data'] as List<dynamic>? ?? const [];
    // Khai bao bien cars de luu du lieu su dung trong xu ly.
    final cars = items
        // Thuc thi cau lenh hien tai theo luong xu ly.
        .whereType<Map<String, dynamic>>()
        // Thuc thi cau lenh hien tai theo luong xu ly.
        .map(InventoryCarItem.fromJson)
        // Thuc thi cau lenh hien tai theo luong xu ly.
        .toList(growable: false);

    // Khai bao bien available de luu du lieu su dung trong xu ly.
    final available = cars.where((c) => c.status == 'available').length;
    // Khai bao bien sold de luu du lieu su dung trong xu ly.
    final sold = cars.where((c) => c.status == 'sold').length;
    // Khai bao bien reserved de luu du lieu su dung trong xu ly.
    final reserved = cars.where((c) => c.status == 'reserved').length;

    // Tra ve ket qua cho noi goi ham.
    return InventoryQuickActionData(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      totalCars: cars.length,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      availableCars: available,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      soldCars: sold,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      reservedCars: reserved,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      recentCars: cars,
    );
  }
}
