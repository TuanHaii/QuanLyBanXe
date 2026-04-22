// Nap thu vien hoac module can thiet.
import '../../../shared/services/api_service.dart';
// Nap thu vien hoac module can thiet.
import '../models/dashboard_summary_model.dart';

// Dinh nghia lop DashboardService de gom nhom logic lien quan.
class DashboardService {
  // Khai bao bien ApiService de luu du lieu su dung trong xu ly.
  final ApiService apiService;

  // Khai bao constructor DashboardService de khoi tao doi tuong.
  DashboardService({required this.apiService});

  // Khai bao bien fetchDashboardSummary de luu du lieu su dung trong xu ly.
  Future<DashboardSummaryModel> fetchDashboardSummary() async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    final response = await apiService.get('/dashboard/summary');
    // Khai bao bien body de luu du lieu su dung trong xu ly.
    final body = response.data;

    // Kiem tra dieu kien de re nhanh xu ly.
    if (body is! Map<String, dynamic>) {
      // Nem ngoai le de bao loi len tang xu ly phia tren.
      throw Exception('Invalid response from dashboard service');
    }

    // Khai bao bien data de luu du lieu su dung trong xu ly.
    final data = body['data'];
    // Kiem tra dieu kien de re nhanh xu ly.
    if (data is! Map<String, dynamic>) {
      // Nem ngoai le de bao loi len tang xu ly phia tren.
      throw Exception('Dashboard summary not found');
    }

    // Tra ve ket qua cho noi goi ham.
    return DashboardSummaryModel.fromJson(data);
  }
}
