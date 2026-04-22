import '../../../shared/services/api_service.dart';
import '../models/dashboard_summary_model.dart';

class DashboardService {
  final ApiService apiService;

  DashboardService({required this.apiService});

  Future<DashboardSummaryModel> fetchDashboardSummary() async {
    final response = await apiService.get('/dashboard/summary');
    final body = response.data;

    if (body is! Map<String, dynamic>) {
      throw Exception('Invalid response from dashboard service');
    }

    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw Exception('Dashboard summary not found');
    }

    return DashboardSummaryModel.fromJson(data);
  }
}
