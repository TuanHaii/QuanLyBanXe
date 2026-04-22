// Nap thu vien hoac module can thiet.
import '../../../shared/services/api_service.dart';
// Nap thu vien hoac module can thiet.
import '../models/sales_quick_action_models.dart';

// Dinh nghia lop SalesQuickActionService de gom nhom logic lien quan.
class SalesQuickActionService {
  // Khai bao bien ApiService de luu du lieu su dung trong xu ly.
  final ApiService apiService;

  // Khai bao constructor SalesQuickActionService de khoi tao doi tuong.
  SalesQuickActionService({required this.apiService});

  // Khai bao bien fetchSalesOverview de luu du lieu su dung trong xu ly.
  Future<SalesQuickActionData> fetchSalesOverview() async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    final response = await apiService.get('/sales');
    // Khai bao bien body de luu du lieu su dung trong xu ly.
    final body = response.data;

    // Kiem tra dieu kien de re nhanh xu ly.
    if (body is! Map<String, dynamic>) {
      // Nem ngoai le de bao loi len tang xu ly phia tren.
      throw Exception('Invalid response from sales service');
    }

    // Khai bao bien items de luu du lieu su dung trong xu ly.
    final items = body['data'] as List<dynamic>? ?? const [];
    // Khai bao bien sales de luu du lieu su dung trong xu ly.
    final sales = items
        // Thuc thi cau lenh hien tai theo luong xu ly.
        .whereType<Map<String, dynamic>>()
        // Thuc thi cau lenh hien tai theo luong xu ly.
        .map(SaleOverviewItem.fromJson)
        // Thuc thi cau lenh hien tai theo luong xu ly.
        .toList(growable: false);

    // Khai bao bien completed de luu du lieu su dung trong xu ly.
    final completed = sales.where((s) => s.status == 'completed').length;
    // Khai bao bien pending de luu du lieu su dung trong xu ly.
    final pending = sales.where((s) => s.status == 'pending').length;
    // Khai bao bien totalRevenue de luu du lieu su dung trong xu ly.
    final totalRevenue = sales
        // Thuc thi cau lenh hien tai theo luong xu ly.
        .where((s) => s.status == 'completed')
        // Thuc thi cau lenh hien tai theo luong xu ly.
        .fold<double>(0, (sum, s) => sum + s.salePrice);

    // Khai bao bien formatRevenue de luu du lieu su dung trong xu ly.
    String formatRevenue(double value) {
      // Kiem tra dieu kien de re nhanh xu ly.
      if (value >= 1000000000) {
        // Tra ve ket qua cho noi goi ham.
        return '${(value / 1000000000).toStringAsFixed(1)} tỷ';
      // Thuc thi cau lenh hien tai theo luong xu ly.
      } else if (value >= 1000000) {
        // Tra ve ket qua cho noi goi ham.
        return '${(value / 1000000).toStringAsFixed(0)} triệu';
      }
      // Tra ve ket qua cho noi goi ham.
      return '${value.toStringAsFixed(0)} VNĐ';
    }

    // Tra ve ket qua cho noi goi ham.
    return SalesQuickActionData(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      totalSales: sales.length,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      completedSales: completed,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      pendingSales: pending,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      totalRevenue: totalRevenue,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      formattedRevenue: formatRevenue(totalRevenue),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      recentSales: sales,
    );
  }
}
