import '../../../shared/services/api_service.dart';
import '../models/notification_item_model.dart';

class NotificationService {
  final ApiService apiService;

  NotificationService({required this.apiService});

  Future<List<NotificationItem>> fetchNotifications({
    NotificationCategory? category,
    bool? isRead,
  }) async {
    final response = await apiService.get(
      '/notifications',
      queryParameters: {
        if (category != null) 'category': _toCategoryQuery(category),
        if (isRead != null) 'is_read': isRead.toString(),
      },
    );

    final body = response.data;
    if (body is! Map<String, dynamic>) {
      throw Exception('Invalid response from notification service');
    }

    final items = body['data'] as List<dynamic>? ?? const [];
    return items
        .whereType<Map<String, dynamic>>()
        .map(NotificationItem.fromJson)
        .toList(growable: false);
  }

  Future<void> markAsRead(String id) async {
    await apiService.put('/notifications/$id/read');
  }

  String _toCategoryQuery(NotificationCategory category) {
    switch (category) {
      case NotificationCategory.transaction:
        return 'Giao dịch';
      case NotificationCategory.inventory:
        return 'Kho hàng';
      case NotificationCategory.report:
        return 'Báo cáo';
      case NotificationCategory.promotion:
        return 'Khuyến mãi';
      case NotificationCategory.customer:
        return 'Khách hàng';
      case NotificationCategory.market:
        return 'Phân tích';
      case NotificationCategory.system:
        return 'Hệ thống';
    }
  }
}
