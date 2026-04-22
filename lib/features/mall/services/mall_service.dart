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

  Future<Map<String, dynamic>> sellProduct({
    required String productId,
    required String hoTen,
    required String sdt,
    String? email,
    String? diaChi,
    int diemTichLuy = 0,
    String phuongThucThanhToan = 'Tiền mặt',
  }) async {
    final response = await apiService.post(
      '/mall/$productId/sell',
      data: {
        'hoTen': hoTen.trim(),
        'sdt': sdt.trim(),
        if (email != null && email.trim().isNotEmpty) 'email': email.trim(),
        if (diaChi != null && diaChi.trim().isNotEmpty) 'diaChi': diaChi.trim(),
        'diemTichLuy': diemTichLuy,
        'phuongThucThanhToan': phuongThucThanhToan,
      },
    );

    final body = response.data;
    if (body is! Map<String, dynamic>) {
      throw Exception('Invalid sell response from mall service');
    }

    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw Exception('Sell result is missing');
    }

    return data;
  }
}
