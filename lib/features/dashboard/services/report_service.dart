// Nap thu vien hoac module can thiet.
import '../../../shared/services/api_service.dart';
// Nap thu vien hoac module can thiet.
import '../models/dashboard_summary_model.dart';
// Nap thu vien hoac module can thiet.
import '../models/quick_action_models.dart';

// Dinh nghia lop ReportService de gom nhom logic lien quan.
class ReportService {
  // Khai bao bien ApiService de luu du lieu su dung trong xu ly.
  final ApiService apiService;

  // Khai bao constructor ReportService de khoi tao doi tuong.
  ReportService({required this.apiService});

  // Khai bao bien fetchReportOverview de luu du lieu su dung trong xu ly.
  Future<ReportQuickActionData> fetchReportOverview() async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    final responses = await Future.wait([
      // Thuc thi cau lenh hien tai theo luong xu ly.
      apiService.get('/reports'),
      // Thuc thi cau lenh hien tai theo luong xu ly.
      apiService.get('/reports/goals'),
    ]);

    // Khai bao bien overview de luu du lieu su dung trong xu ly.
    final overview = _extractDataMap(responses[0].data, 'báo cáo nhanh');
    // Khai bao bien goals de luu du lieu su dung trong xu ly.
    final goals = _extractDataMap(responses[1].data, 'mục tiêu báo cáo');

    // Tra ve ket qua cho noi goi ham.
    return ReportQuickActionData(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      summary: DashboardSummaryModel.fromJson(overview),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      goals: ReportGoalsModel.fromJson(goals),
    );
  }

  // Khai bao bien _extractDataMap de luu du lieu su dung trong xu ly.
  Map<String, dynamic> _extractDataMap(dynamic body, String label) {
    // Kiem tra dieu kien de re nhanh xu ly.
    if (body is! Map<String, dynamic>) {
      // Nem ngoai le de bao loi len tang xu ly phia tren.
      throw Exception('Invalid response from $label');
    }

    // Khai bao bien data de luu du lieu su dung trong xu ly.
    final data = body['data'];
    // Kiem tra dieu kien de re nhanh xu ly.
    if (data is! Map<String, dynamic>) {
      // Nem ngoai le de bao loi len tang xu ly phia tren.
      throw Exception('$label not found');
    }

    // Tra ve ket qua cho noi goi ham.
    return data;
  }
}
