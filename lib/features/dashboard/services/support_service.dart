// Nap thu vien hoac module can thiet.
import '../../../shared/services/api_service.dart';
// Nap thu vien hoac module can thiet.
import '../models/quick_action_models.dart';

// Dinh nghia lop SupportService de gom nhom logic lien quan.
class SupportService {
  // Khai bao bien ApiService de luu du lieu su dung trong xu ly.
  final ApiService apiService;

  // Khai bao constructor SupportService de khoi tao doi tuong.
  SupportService({required this.apiService});

  // Dinh nghia ham fetchSupportItems de xu ly nghiep vu tuong ung.
  Future<List<SupportItemModel>> fetchSupportItems() async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    final response = await apiService.get('/support');
    // Khai bao bien body de luu du lieu su dung trong xu ly.
    final body = response.data;

    // Kiem tra dieu kien de re nhanh xu ly.
    if (body is! Map<String, dynamic>) {
      // Nem ngoai le de bao loi len tang xu ly phia tren.
      throw Exception('Invalid response from support service');
    }

    // Backend returns { success: true, data: [...] }
    // data is directly the list of support items
    // Khai bao bien items de luu du lieu su dung trong xu ly.
    final items = body['data'] as List<dynamic>? ?? const [];
    // Tra ve ket qua cho noi goi ham.
    return items
        // Thuc thi cau lenh hien tai theo luong xu ly.
        .whereType<Map<String, dynamic>>()
        // Thuc thi cau lenh hien tai theo luong xu ly.
        .map(SupportItemModel.fromJson)
        // Thuc thi cau lenh hien tai theo luong xu ly.
        .toList(growable: false);
  }

  // Khai bao bien sendContact de luu du lieu su dung trong xu ly.
  Future<SupportContactSubmissionModel> sendContact({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required String name,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required String email,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required String message,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    final response = await apiService.post(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      '/support/contact',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      data: {
        // Thuc thi cau lenh hien tai theo luong xu ly.
        'name': name.trim(),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        'email': email.trim(),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        'message': message.trim(),
      },
    );

    // Khai bao bien body de luu du lieu su dung trong xu ly.
    final body = response.data;
    // Kiem tra dieu kien de re nhanh xu ly.
    if (body is! Map<String, dynamic>) {
      // Nem ngoai le de bao loi len tang xu ly phia tren.
      throw Exception('Invalid response from support contact');
    }

    // Backend returns { success: true, data: { id, name, email, ... } }
    // Khai bao bien item de luu du lieu su dung trong xu ly.
    final item = body['data'];
    // Kiem tra dieu kien de re nhanh xu ly.
    if (item is! Map<String, dynamic>) {
      // Nem ngoai le de bao loi len tang xu ly phia tren.
      throw Exception('Support contact response not found');
    }

    // Tra ve ket qua cho noi goi ham.
    return SupportContactSubmissionModel.fromJson(item);
  }

  // Dinh nghia ham fetchMyRequests de xu ly nghiep vu tuong ung.
  Future<List<SupportContactSubmissionModel>> fetchMyRequests() async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    final response = await apiService.get('/support/requests');
    // Khai bao bien body de luu du lieu su dung trong xu ly.
    final body = response.data;

    // Kiem tra dieu kien de re nhanh xu ly.
    if (body is! Map<String, dynamic>) {
      // Nem ngoai le de bao loi len tang xu ly phia tren.
      throw Exception('Invalid response from support requests');
    }

    // Backend returns { success: true, data: [...] }
    // Khai bao bien items de luu du lieu su dung trong xu ly.
    final items = body['data'] as List<dynamic>? ?? const [];
    // Tra ve ket qua cho noi goi ham.
    return items
        // Thuc thi cau lenh hien tai theo luong xu ly.
        .whereType<Map<String, dynamic>>()
        // Thuc thi cau lenh hien tai theo luong xu ly.
        .map(SupportContactSubmissionModel.fromJson)
        // Thuc thi cau lenh hien tai theo luong xu ly.
        .toList(growable: false);
  }
}
