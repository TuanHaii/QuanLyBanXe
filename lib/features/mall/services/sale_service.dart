import '../../../shared/services/api_service.dart';
import '../models/mall_model.dart';

class SaleService {
  final ApiService apiService;

  SaleService({required this.apiService});

  Future<List<SaleModel>> fetchSales() async {
    final response = await apiService.get('/sales');
    final data = response.data;
    if (data is Map<String, dynamic>) {
      final items = data['data'] as List<dynamic>?;
      return items
              ?.map((item) => SaleModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [];
    }
    throw Exception('Invalid response from sales service');
  }

  Future<SaleModel> fetchSaleById(String id) async {
    final response = await apiService.get('/sales/$id');
    final data = response.data;
    if (data is Map<String, dynamic>) {
      final item = data['data'] as Map<String, dynamic>?;
      if (item != null) {
        return SaleModel.fromJson(item);
      }
    }
    throw Exception('Sale detail not found');
  }
}
