// Nap thu vien hoac module can thiet.
import '../../../shared/services/api_service.dart';
// Nap thu vien hoac module can thiet.
import '../models/notification_item_model.dart';

// Dinh nghia lop NotificationService de gom nhom logic lien quan.
class NotificationService {
  // Khai bao bien ApiService de luu du lieu su dung trong xu ly.
  final ApiService apiService;

  // Khai bao constructor NotificationService de khoi tao doi tuong.
  NotificationService({required this.apiService});

  // Thuc thi cau lenh hien tai theo luong xu ly.
  Future<List<NotificationItem>> fetchNotifications({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    NotificationCategory? category,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    bool? isRead,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    final response = await apiService.get(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      '/notifications',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      queryParameters: {
        // Kiem tra dieu kien de re nhanh xu ly.
        if (category != null) 'category': _toCategoryQuery(category),
        // Kiem tra dieu kien de re nhanh xu ly.
        if (isRead != null) 'is_read': isRead.toString(),
      },
    );

    // Khai bao bien body de luu du lieu su dung trong xu ly.
    final body = response.data;
    // Kiem tra dieu kien de re nhanh xu ly.
    if (body is! Map<String, dynamic>) {
      // Nem ngoai le de bao loi len tang xu ly phia tren.
      throw Exception('Invalid response from notification service');
    }

    // Khai bao bien items de luu du lieu su dung trong xu ly.
    final items = body['data'] as List<dynamic>? ?? const [];
    // Tra ve ket qua cho noi goi ham.
    return items
        // Thuc thi cau lenh hien tai theo luong xu ly.
        .whereType<Map<String, dynamic>>()
        // Thuc thi cau lenh hien tai theo luong xu ly.
        .map(NotificationItem.fromJson)
        // Thuc thi cau lenh hien tai theo luong xu ly.
        .toList(growable: false);
  }

  // Khai bao bien markAsRead de luu du lieu su dung trong xu ly.
  Future<void> markAsRead(String id) async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await apiService.put('/notifications/$id/read');
  }

  // Khai bao bien _toCategoryQuery de luu du lieu su dung trong xu ly.
  String _toCategoryQuery(NotificationCategory category) {
    // Bat dau re nhanh theo nhieu truong hop gia tri.
    switch (category) {
      // Xu ly mot truong hop cu the trong switch.
      case NotificationCategory.transaction:
        // Tra ve ket qua cho noi goi ham.
        return 'Giao dịch';
      // Xu ly mot truong hop cu the trong switch.
      case NotificationCategory.inventory:
        // Tra ve ket qua cho noi goi ham.
        return 'Kho hàng';
      // Xu ly mot truong hop cu the trong switch.
      case NotificationCategory.report:
        // Tra ve ket qua cho noi goi ham.
        return 'Báo cáo';
      // Xu ly mot truong hop cu the trong switch.
      case NotificationCategory.promotion:
        // Tra ve ket qua cho noi goi ham.
        return 'Khuyến mãi';
      // Xu ly mot truong hop cu the trong switch.
      case NotificationCategory.customer:
        // Tra ve ket qua cho noi goi ham.
        return 'Khách hàng';
      // Xu ly mot truong hop cu the trong switch.
      case NotificationCategory.market:
        // Tra ve ket qua cho noi goi ham.
        return 'Phân tích';
      // Xu ly mot truong hop cu the trong switch.
      case NotificationCategory.system:
        // Tra ve ket qua cho noi goi ham.
        return 'Hệ thống';
    }
  }
}
