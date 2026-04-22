// Nap thu vien hoac module can thiet.
import '../../../shared/services/api_service.dart';
// Nap thu vien hoac module can thiet.
import '../models/mall_product_model.dart';

// Dinh nghia lop MallService de gom nhom logic lien quan.
class MallService {
  // Khai bao bien ApiService de luu du lieu su dung trong xu ly.
  final ApiService apiService;

  // Khai bao constructor MallService de khoi tao doi tuong.
  MallService({required this.apiService});

  // Thuc thi cau lenh hien tai theo luong xu ly.
  Future<List<MallProduct>> fetchProducts({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? category,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? query,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    final response = await apiService.get(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      '/mall',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      queryParameters: {
        // Kiem tra dieu kien de re nhanh xu ly.
        if (category != null && category.isNotEmpty) 'category': category,
        // Kiem tra dieu kien de re nhanh xu ly.
        if (query != null && query.isNotEmpty) 'query': query,
      },
    );

    // Khai bao bien data de luu du lieu su dung trong xu ly.
    final data = response.data;
    // Kiem tra dieu kien de re nhanh xu ly.
    if (data is Map<String, dynamic>) {
      // Khai bao bien items de luu du lieu su dung trong xu ly.
      final items = data['data'] as List<dynamic>?;
      // Tra ve ket qua cho noi goi ham.
      return items
              // Thuc thi cau lenh hien tai theo luong xu ly.
              ?.map(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                (item) => MallProduct.fromJson(item as Map<String, dynamic>),
              )
              // Thuc thi cau lenh hien tai theo luong xu ly.
              .toList() ??
          // Thuc thi cau lenh hien tai theo luong xu ly.
          [];
    }

    // Nem ngoai le de bao loi len tang xu ly phia tren.
    throw Exception('Invalid response from mall service');
  }
}
