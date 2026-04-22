import '../../../shared/services/api_service.dart';
import '../models/sales_quick_action_models.dart';

class SalesQuickActionService {
  final ApiService apiService;

  SalesQuickActionService({required this.apiService});

  Future<SalesQuickActionData> fetchSalesOverview() async {
    final response = await apiService.get('/sales');
    final body = response.data;

    if (body is! Map<String, dynamic>) {
      throw Exception('Invalid response from sales service');
    }

    final items = body['data'] as List<dynamic>? ?? const [];
    final sales = items
        .whereType<Map<String, dynamic>>()
        .map(SaleOverviewItem.fromJson)
        .toList(growable: false);

    final completed = sales.where((s) => s.status == 'completed').length;
    final pending = sales.where((s) => s.status == 'pending').length;
    final totalRevenue = sales
        .where((s) => s.status == 'completed')
        .fold<double>(0, (sum, s) => sum + s.salePrice);

    String formatRevenue(double value) {
      if (value >= 1000000000) {
        return '${(value / 1000000000).toStringAsFixed(1)} tỷ';
      } else if (value >= 1000000) {
        return '${(value / 1000000).toStringAsFixed(0)} triệu';
      }
      return '${value.toStringAsFixed(0)} VNĐ';
    }

    return SalesQuickActionData(
      totalSales: sales.length,
      completedSales: completed,
      pendingSales: pending,
      totalRevenue: totalRevenue,
      formattedRevenue: formatRevenue(totalRevenue),
      recentSales: sales,
    );
  }
}
