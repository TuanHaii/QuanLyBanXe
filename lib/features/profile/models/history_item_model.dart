import 'package:equatable/equatable.dart';

class HistoryItemModel extends Equatable {
  final String id;
  final String type;
  final String title;
  final String subtitle;
  final double amount;
  final String status;
  final DateTime date;
  final String? note;

  const HistoryItemModel({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.status,
    required this.date,
    this.note,
  });

  factory HistoryItemModel.fromJson(Map<String, dynamic> json) {
    return HistoryItemModel(
      id: json['id'] as String? ?? '',
      type: json['type'] as String? ?? 'sale',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      status: json['status'] as String? ?? 'pending',
      date: DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime.now(),
      note: json['note'] as String?,
    );
  }

  bool get isSuccess => status.toLowerCase() == 'completed';

  @override
  List<Object?> get props => [
        id,
        type,
        title,
        subtitle,
        amount,
        status,
        date,
        note,
      ];
}
