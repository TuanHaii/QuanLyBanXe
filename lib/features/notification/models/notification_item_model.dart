// Nap thu vien hoac module can thiet.
import 'package:equatable/equatable.dart';

// Dinh nghia kieu liet ke NotificationCategory.
enum NotificationCategory {
  // Thuc thi cau lenh hien tai theo luong xu ly.
  transaction,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  inventory,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  report,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  promotion,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  customer,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  market,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  system,
}

// Dinh nghia lop NotificationItem de gom nhom logic lien quan.
class NotificationItem extends Equatable {
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String id;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String title;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String message;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String timeLabel;
  // Khai bao bien NotificationCategory de luu du lieu su dung trong xu ly.
  final NotificationCategory category;
  // Khai bao bien bool de luu du lieu su dung trong xu ly.
  final bool isRead;
  // Khai bao bien DateTime de luu du lieu su dung trong xu ly.
  final DateTime? createdAt;

  // Khai bao bien NotificationItem de luu du lieu su dung trong xu ly.
  const NotificationItem({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.id,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.title,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.message,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.timeLabel,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.category,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.isRead = false,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.createdAt,
  });

  // Thuc thi cau lenh hien tai theo luong xu ly.
  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    // Khai bao bien createdAt de luu du lieu su dung trong xu ly.
    final createdAt = json['created_at'] != null
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ? DateTime.tryParse(json['created_at'] as String)
        // Thuc thi cau lenh hien tai theo luong xu ly.
        : null;

    // Tra ve ket qua cho noi goi ham.
    return NotificationItem(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      id: json['id'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      title: json['title'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      message: json['message'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      timeLabel: _buildTimeLabel(createdAt),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      category: _parseCategory(json['category'] as String?),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      isRead: json['is_read'] as bool? ?? false,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      createdAt: createdAt,
    );
  }

  // Thuc thi cau lenh hien tai theo luong xu ly.
  NotificationItem copyWith({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? id,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? title,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? message,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? timeLabel,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    NotificationCategory? category,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    bool? isRead,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    DateTime? createdAt,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) {
    // Tra ve ket qua cho noi goi ham.
    return NotificationItem(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      id: id ?? this.id,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      title: title ?? this.title,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      message: message ?? this.message,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      timeLabel: timeLabel ?? this.timeLabel,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      category: category ?? this.category,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      isRead: isRead ?? this.isRead,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // Khai bao bien NotificationCategory de luu du lieu su dung trong xu ly.
  static NotificationCategory _parseCategory(String? rawCategory) {
    // Khai bao bien normalized de luu du lieu su dung trong xu ly.
    final normalized = (rawCategory ?? '').trim().toLowerCase();

    // Bat dau re nhanh theo nhieu truong hop gia tri.
    switch (normalized) {
      // Xu ly mot truong hop cu the trong switch.
      case 'giao dịch':
      // Xu ly mot truong hop cu the trong switch.
      case 'transaction':
        // Tra ve ket qua cho noi goi ham.
        return NotificationCategory.transaction;
      // Xu ly mot truong hop cu the trong switch.
      case 'kho hàng':
      // Xu ly mot truong hop cu the trong switch.
      case 'inventory':
        // Tra ve ket qua cho noi goi ham.
        return NotificationCategory.inventory;
      // Xu ly mot truong hop cu the trong switch.
      case 'báo cáo':
      // Xu ly mot truong hop cu the trong switch.
      case 'report':
        // Tra ve ket qua cho noi goi ham.
        return NotificationCategory.report;
      // Xu ly mot truong hop cu the trong switch.
      case 'khuyến mãi':
      // Xu ly mot truong hop cu the trong switch.
      case 'promotion':
      // Xu ly mot truong hop cu the trong switch.
      case 'offer':
        // Tra ve ket qua cho noi goi ham.
        return NotificationCategory.promotion;
      // Xu ly mot truong hop cu the trong switch.
      case 'khách hàng':
      // Xu ly mot truong hop cu the trong switch.
      case 'customer':
        // Tra ve ket qua cho noi goi ham.
        return NotificationCategory.customer;
      // Xu ly mot truong hop cu the trong switch.
      case 'phân tích':
      // Xu ly mot truong hop cu the trong switch.
      case 'market':
      // Xu ly mot truong hop cu the trong switch.
      case 'analytics':
        // Tra ve ket qua cho noi goi ham.
        return NotificationCategory.market;
      // Xu ly mot truong hop cu the trong switch.
      case 'hệ thống':
      // Xu ly mot truong hop cu the trong switch.
      case 'system':
        // Tra ve ket qua cho noi goi ham.
        return NotificationCategory.system;
      // Xu ly mac dinh khi khong khop case nao.
      default:
        // Tra ve ket qua cho noi goi ham.
        return NotificationCategory.system;
    }
  }

  // Khai bao bien String de luu du lieu su dung trong xu ly.
  static String _buildTimeLabel(DateTime? createdAt) {
    // Kiem tra dieu kien de re nhanh xu ly.
    if (createdAt == null) {
      // Tra ve ket qua cho noi goi ham.
      return 'Không xác định';
    }

    // Khai bao bien diff de luu du lieu su dung trong xu ly.
    final diff = DateTime.now().difference(createdAt);
    // Kiem tra dieu kien de re nhanh xu ly.
    if (diff.inMinutes < 1) {
      // Tra ve ket qua cho noi goi ham.
      return 'Vừa xong';
    }
    // Kiem tra dieu kien de re nhanh xu ly.
    if (diff.inMinutes < 60) {
      // Tra ve ket qua cho noi goi ham.
      return '${diff.inMinutes} phút trước';
    }
    // Kiem tra dieu kien de re nhanh xu ly.
    if (diff.inHours < 24) {
      // Tra ve ket qua cho noi goi ham.
      return '${diff.inHours} giờ trước';
    }
    // Kiem tra dieu kien de re nhanh xu ly.
    if (diff.inDays == 1) {
      // Tra ve ket qua cho noi goi ham.
      return '1 ngày trước';
    }
    // Tra ve ket qua cho noi goi ham.
    return '${diff.inDays} ngày trước';
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien get de luu du lieu su dung trong xu ly.
  List<Object?> get props => [
        // Thuc thi cau lenh hien tai theo luong xu ly.
        id,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        title,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        message,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        timeLabel,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        category,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        isRead,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        createdAt,
      ];
}
