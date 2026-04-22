// Nap thu vien hoac module can thiet.
import '../../../shared/services/api_service.dart';
// Nap thu vien hoac module can thiet.
import '../models/history_item_model.dart';

// Dinh nghia lop HistoryService de gom nhom logic lien quan.
class HistoryService {
  // Khai bao bien ApiService de luu du lieu su dung trong xu ly.
  final ApiService apiService;

  // Khai bao constructor HistoryService de khoi tao doi tuong.
  HistoryService({required this.apiService});

  // Dinh nghia ham fetchHistory de xu ly nghiep vu tuong ung.
  Future<List<HistoryItemModel>> fetchHistory({String? query}) async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    final response = await apiService.get(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      '/history',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      queryParameters: {
        // Kiem tra dieu kien de re nhanh xu ly.
        if (query != null && query.trim().isNotEmpty) 'query': query.trim(),
      },
    );

    // Khai bao bien body de luu du lieu su dung trong xu ly.
    final body = response.data;
    // Kiem tra dieu kien de re nhanh xu ly.
    if (body is! Map<String, dynamic>) {
      // Nem ngoai le de bao loi len tang xu ly phia tren.
      throw Exception('Invalid response from history service');
    }

    // Khai bao bien items de luu du lieu su dung trong xu ly.
    final items = body['data'] as List<dynamic>? ?? const [];
    // Tra ve ket qua cho noi goi ham.
    return items
        // Thuc thi cau lenh hien tai theo luong xu ly.
        .whereType<Map<String, dynamic>>()
        // Thuc thi cau lenh hien tai theo luong xu ly.
        .map(HistoryItemModel.fromJson)
        // Thuc thi cau lenh hien tai theo luong xu ly.
        .toList(growable: false);
  }
}
