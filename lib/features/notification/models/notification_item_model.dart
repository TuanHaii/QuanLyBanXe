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

  const NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.timeLabel,
    required this.category,
    this.isRead = false,
  });

  NotificationItem copyWith({
    String? id,
    String? title,
    String? message,
    String? timeLabel,
    NotificationCategory? category,
    bool? isRead,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      timeLabel: timeLabel ?? this.timeLabel,
      category: category ?? this.category,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  List<Object?> get props => [id, title, message, timeLabel, category, isRead];
}
