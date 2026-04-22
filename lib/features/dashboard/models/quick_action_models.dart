import 'package:equatable/equatable.dart';

import 'dashboard_summary_model.dart';

class ReportQuickActionData extends Equatable {
  final DashboardSummaryModel summary;
  final ReportGoalsModel goals;

  const ReportQuickActionData({
    required this.summary,
    required this.goals,
  });

  @override
  List<Object?> get props => [summary, goals];
}

class ReportGoalsModel extends Equatable {
  final String revenueTarget;
  final String achievedRate;
  final String progressText;
  final List<String> suggestions;

  const ReportGoalsModel({
    required this.revenueTarget,
    required this.achievedRate,
    required this.progressText,
    required this.suggestions,
  });

  factory ReportGoalsModel.fromJson(Map<String, dynamic> json) {
    final suggestions = json['suggestions'] as List<dynamic>? ?? const [];

    return ReportGoalsModel(
      revenueTarget: json['revenue_target'] as String? ?? '0',
      achievedRate: json['achieved_rate'] as String? ?? '0%',
      progressText:
          json['progress_text'] as String? ?? 'Tiến độ đang được cập nhật',
      suggestions: suggestions.whereType<String>().toList(growable: false),
    );
  }

  double get progressValue {
    final normalized = achievedRate.replaceAll('%', '').replaceAll(',', '.');
    final parsed = double.tryParse(normalized.trim()) ?? 0;
    return (parsed / 100).clamp(0.0, 1.0).toDouble();
  }

  @override
  List<Object?> get props => [
        revenueTarget,
        achievedRate,
        progressText,
        suggestions,
      ];
}

class SupportItemModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String type;

  const SupportItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
  });

  factory SupportItemModel.fromJson(Map<String, dynamic> json) {
    return SupportItemModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      type: json['type'] as String? ?? 'contact',
    );
  }

  @override
  List<Object?> get props => [id, title, description, type];
}

class SupportContactSubmissionModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String message;
  final String status;
  final DateTime? createdAt;

  const SupportContactSubmissionModel({
    required this.id,
    required this.name,
    required this.email,
    required this.message,
    required this.status,
    required this.createdAt,
  });

  factory SupportContactSubmissionModel.fromJson(Map<String, dynamic> json) {
    return SupportContactSubmissionModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      message: json['message'] as String? ?? '',
      status: json['status'] as String? ?? 'pending',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
    );
  }

  @override
  List<Object?> get props => [id, name, email, message, status, createdAt];
}