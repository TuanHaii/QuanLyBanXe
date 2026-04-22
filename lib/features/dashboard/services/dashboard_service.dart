// ============================================================
// FILE: dashboard_service.dart
// MÔ TẢ: Service xử lý các API liên quan đến dashboard.
//        - Gọi API GET /api/dashboard/summary để lấy số liệu tổng quan
//        - Parse dữ liệu thành DashboardSummaryModel để hiển thị trên UI
// ============================================================

import '../../../shared/services/api_service.dart';
import '../models/dashboard_summary_model.dart';

/// Class DashboardService xử lý tất cả các chức năng dashboard.
/// Được đăng ký trong service_locator.dart để dùng ở bất kỳ màn hình nào.
class DashboardService {
  // apiService: dùng để gọi HTTP request đến backend
  final ApiService apiService;

  DashboardService({required this.apiService});

  // ============================================================
  // HÀM: fetchDashboardSummary() - Lấy tổng quan dashboard
  // API: GET /api/dashboard/summary
  // Header: Authorization: Bearer <token>
  // Response: { "data": { "summary": {...}, "recent_transactions": [...] } }
  // ============================================================

  /// Hàm này gọi API GET /api/dashboard/summary để lấy:
  /// - Tổng số xe trong kho
  /// - Số xe đã bán
  /// - Số xe còn trong kho
  /// - Tổng doanh thu
  /// - Xu hướng doanh thu (%)
  /// - Lịch sử giao dịch gần đây
  /// Dữ liệu này được dùng để hiển thị 4 StatCard trên Dashboard screen.
  Future<DashboardSummaryModel> fetchDashboardSummary() async {
    print('🌐 [DashboardService] Đang gọi GET /api/dashboard/summary');

    try {
      // Gọi API lấy dữ liệu dashboard
      final response = await apiService.get('/dashboard/summary');
      final body = response.data;

      // Kiểm tra response có phải Map không (phải là JSON object)
      if (body is! Map<String, dynamic>) {
        print('❌ [DashboardService] Response không phải JSON object');
        throw Exception('Invalid response from dashboard service');
      }

      // Backend trả về { "data": { ... } }
      // Lấy phần "data" ra
      final data = body['data'];
      if (data is! Map<String, dynamic>) {
        print('❌ [DashboardService] Không tìm thấy key "data" trong response');
        throw Exception('Dashboard summary not found');
      }

      // Parse data thành DashboardSummaryModel object
      final summary = DashboardSummaryModel.fromJson(data);
      print('✅ [DashboardService] Lấy dashboard summary thành công!');
      print('   Tổng xe: ${summary.totalCars}');
      print('   Bán được: ${summary.carsSold}');
      print('   Doanh thu: ${summary.totalRevenueLabel}');
      return summary;
    } catch (e) {
      // In ra lỗi để debug
      print('❌ [DashboardService] Lỗi khi lấy dashboard summary: $e');
      rethrow; // Ném lỗi tiếp ra để DashboardScreen xử lý
    }
  }
}
