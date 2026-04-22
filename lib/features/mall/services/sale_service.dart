// Nap thu vien hoac module can thiet.
import '../../../shared/services/api_service.dart';
// Nap thu vien hoac module can thiet.
import '../models/mall_model.dart';

// Dinh nghia lop SaleService de gom nhom logic lien quan.
class SaleService {
  // Khai bao bien ApiService de luu du lieu su dung trong xu ly.
  final ApiService apiService;

  // Khai bao constructor SaleService de khoi tao doi tuong.
  SaleService({required this.apiService});

  // Dinh nghia ham fetchSales de xu ly nghiep vu tuong ung.
  Future<List<SaleModel>> fetchSales() async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    final response = await apiService.get('/sales');
    // Khai bao bien data de luu du lieu su dung trong xu ly.
    final data = response.data;
    // Kiem tra dieu kien de re nhanh xu ly.
    if (data is Map<String, dynamic>) {
      // Khai bao bien items de luu du lieu su dung trong xu ly.
      final items = data['data'] as List<dynamic>?;
      // Tra ve ket qua cho noi goi ham.
      return items
              // Thuc thi cau lenh hien tai theo luong xu ly.
              ?.map((item) => SaleModel.fromJson(item as Map<String, dynamic>))
              // Thuc thi cau lenh hien tai theo luong xu ly.
              .toList() ??
          // Thuc thi cau lenh hien tai theo luong xu ly.
          [];
    }
    // Nem ngoai le de bao loi len tang xu ly phia tren.
    throw Exception('Invalid response from sales service');
  }

  // Khai bao bien fetchSaleById de luu du lieu su dung trong xu ly.
  Future<SaleModel> fetchSaleById(String id) async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    final response = await apiService.get('/sales/$id');
    // Khai bao bien data de luu du lieu su dung trong xu ly.
    final data = response.data;
    // Kiem tra dieu kien de re nhanh xu ly.
    if (data is Map<String, dynamic>) {
      // Khai bao bien item de luu du lieu su dung trong xu ly.
      final item = data['data'] as Map<String, dynamic>?;
      // Kiem tra dieu kien de re nhanh xu ly.
      if (item != null) {
        // Tra ve ket qua cho noi goi ham.
        return SaleModel.fromJson(item);
      }
    }
    // Nem ngoai le de bao loi len tang xu ly phia tren.
    throw Exception('Sale detail not found');
  }
}
