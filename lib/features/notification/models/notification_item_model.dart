import 'package:equatable/equatable.dart';

enum NotificationCategory {
  transaction,
  inventory,
  report,
  promotion,
  customer,
  market,
  system,
}

class NotificationItem extends Equatable {
  final String id;
  final String title;
  final String message;
  final String timeLabel;
  final NotificationCategory category;
  final bool isRead;
  final DateTime? createdAt;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.timeLabel,
    required this.category,
    this.isRead = false,
    this.createdAt,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    final createdAt = json['created_at'] != null
        ? DateTime.tryParse(json['created_at'] as String)
        : null;

    return NotificationItem(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      message: json['message'] as String? ?? '',
      timeLabel: _buildTimeLabel(createdAt),
      category: _parseCategory(json['category'] as String?),
      isRead: json['is_read'] as bool? ?? false,
      createdAt: createdAt,
    );
  }

  NotificationItem copyWith({
    String? id,
    String? title,
    String? message,
    String? timeLabel,
    NotificationCategory? category,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      timeLabel: timeLabel ?? this.timeLabel,
      category: category ?? this.category,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  static NotificationCategory _parseCategory(String? rawCategory) {
    final normalized = (rawCategory ?? '').trim().toLowerCase();

    switch (normalized) {
      case 'giao dịch':
      case 'transaction':
        return NotificationCategory.transaction;
      case 'kho hàng':
      case 'inventory':
        return NotificationCategory.inventory;
      case 'báo cáo':
      case 'report':
        return NotificationCategory.report;
      case 'khuyến mãi':
      case 'promotion':
      case 'offer':
        return NotificationCategory.promotion;
      case 'khách hàng':
      case 'customer':
        return NotificationCategory.customer;
      case 'phân tích':
      case 'market':
      case 'analytics':
        return NotificationCategory.market;
      case 'hệ thống':
      case 'system':
        return NotificationCategory.system;
      default:
        return NotificationCategory.system;
    }
  }

  static String _buildTimeLabel(DateTime? createdAt) {
    if (createdAt == null) {
      return 'Không xác định';
    }

    final diff = DateTime.now().difference(createdAt);
    if (diff.inMinutes < 1) {
      return 'Vừa xong';
    }
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} phút trước';
    }
    if (diff.inHours < 24) {
      return '${diff.inHours} giờ trước';
    }
    if (diff.inDays == 1) {
      return '1 ngày trước';
    }
    return '${diff.inDays} ngày trước';
  }

  @override
  List<Object?> get props => [
        id,
        title,
        message,
        timeLabel,
        category,
        isRead,
        createdAt,
      ];
}
