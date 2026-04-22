import '../../../shared/services/api_service.dart';
import '../models/dashboard_summary_model.dart';
import '../models/quick_action_models.dart';

class ReportService {
  final ApiService apiService;

  ReportService({required this.apiService});

  Future<ReportQuickActionData> fetchReportOverview() async {
    final responses = await Future.wait([
      apiService.get('/reports'),
      apiService.get('/reports/goals'),
    ]);

    final overview = _extractDataMap(responses[0].data, 'báo cáo nhanh');
    final goals = _extractDataMap(responses[1].data, 'mục tiêu báo cáo');

    return ReportQuickActionData(
      summary: DashboardSummaryModel.fromJson(overview),
      goals: ReportGoalsModel.fromJson(goals),
    );
  }

  Map<String, dynamic> _extractDataMap(dynamic body, String label) {
    if (body is! Map<String, dynamic>) {
      throw Exception('Invalid response from $label');
    }

    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw Exception('$label not found');
    }

    return data;
  }
}