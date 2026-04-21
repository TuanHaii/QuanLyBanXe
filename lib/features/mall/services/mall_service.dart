import '../../../shared/services/api_service.dart';
import '../models/mall_product_model.dart';

class MallService {
  final ApiService apiService;

  MallService({required this.apiService});

  Future<List<MallProduct>> fetchProducts({
    String? category,
    String? query,
  }) async {
    final response = await apiService.get(
      '/mall',
      queryParameters: {
        if (category != null && category.isNotEmpty) 'category': category,
        if (query != null && query.isNotEmpty) 'query': query,
      },
    );

    final data = response.data;
    if (data is Map<String, dynamic>) {
      final items = data['data'] as List<dynamic>?;
      return items
              ?.map(
                (item) => MallProduct.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [];
    }

    throw Exception('Invalid response from mall service');
  }
}
