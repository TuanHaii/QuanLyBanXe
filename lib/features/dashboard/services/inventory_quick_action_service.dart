import '../../../shared/services/api_service.dart';
import '../models/inventory_quick_action_models.dart';

class InventoryQuickActionService {
  final ApiService apiService;

  InventoryQuickActionService({required this.apiService});

  Future<InventoryQuickActionData> fetchInventoryOverview() async {
    final response = await apiService.get('/cars');
    final body = response.data;

    if (body is! Map<String, dynamic>) {
      throw Exception('Invalid response from car service');
    }

    final items = body['data'] as List<dynamic>? ?? const [];
    final cars = items
        .whereType<Map<String, dynamic>>()
        .map(InventoryCarItem.fromJson)
        .toList(growable: false);

    final available = cars.where((c) => c.status == 'available').length;
    final sold = cars.where((c) => c.status == 'sold').length;
    final reserved = cars.where((c) => c.status == 'reserved').length;

    return InventoryQuickActionData(
      totalCars: cars.length,
      availableCars: available,
      soldCars: sold,
      reservedCars: reserved,
      recentCars: cars,
    );
  }
}
