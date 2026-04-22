// Nap thu vien hoac module can thiet.
import 'package:equatable/equatable.dart';

// Nap thu vien hoac module can thiet.
import 'dashboard_summary_model.dart';

// Dinh nghia lop ReportQuickActionData de gom nhom logic lien quan.
class ReportQuickActionData extends Equatable {
  // Khai bao bien DashboardSummaryModel de luu du lieu su dung trong xu ly.
  final DashboardSummaryModel summary;
  // Khai bao bien ReportGoalsModel de luu du lieu su dung trong xu ly.
  final ReportGoalsModel goals;

  // Khai bao bien ReportQuickActionData de luu du lieu su dung trong xu ly.
  const ReportQuickActionData({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.summary,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.goals,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien get de luu du lieu su dung trong xu ly.
  List<Object?> get props => [summary, goals];
}

// Dinh nghia lop ReportGoalsModel de gom nhom logic lien quan.
class ReportGoalsModel extends Equatable {
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String revenueTarget;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String achievedRate;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String progressText;
  // Khai bao bien List de luu du lieu su dung trong xu ly.
  final List<String> suggestions;

  // Khai bao bien ReportGoalsModel de luu du lieu su dung trong xu ly.
  const ReportGoalsModel({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.revenueTarget,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.achievedRate,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.progressText,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.suggestions,
  });

  // Thuc thi cau lenh hien tai theo luong xu ly.
  factory ReportGoalsModel.fromJson(Map<String, dynamic> json) {
    // Khai bao bien suggestions de luu du lieu su dung trong xu ly.
    final suggestions = json['suggestions'] as List<dynamic>? ?? const [];

    // Tra ve ket qua cho noi goi ham.
    return ReportGoalsModel(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      revenueTarget: json['revenue_target'] as String? ?? '0',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      achievedRate: json['achieved_rate'] as String? ?? '0%',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      progressText:
          // Thuc thi cau lenh hien tai theo luong xu ly.
          json['progress_text'] as String? ?? 'Tiến độ đang được cập nhật',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      suggestions: suggestions.whereType<String>().toList(growable: false),
    );
  }

  // Khai bao bien get de luu du lieu su dung trong xu ly.
  double get progressValue {
    // Khai bao bien normalized de luu du lieu su dung trong xu ly.
    final normalized = achievedRate.replaceAll('%', '').replaceAll(',', '.');
    // Khai bao bien parsed de luu du lieu su dung trong xu ly.
    final parsed = double.tryParse(normalized.trim()) ?? 0;
    // Tra ve ket qua cho noi goi ham.
    return (parsed / 100).clamp(0.0, 1.0).toDouble();
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien get de luu du lieu su dung trong xu ly.
  List<Object?> get props => [
        // Thuc thi cau lenh hien tai theo luong xu ly.
        revenueTarget,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        achievedRate,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        progressText,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        suggestions,
      ];
}

// Dinh nghia lop SupportItemModel de gom nhom logic lien quan.
class SupportItemModel extends Equatable {
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String id;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String title;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String description;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String type;

  // Khai bao bien SupportItemModel de luu du lieu su dung trong xu ly.
  const SupportItemModel({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.id,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.title,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.description,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.type,
  });

  // Thuc thi cau lenh hien tai theo luong xu ly.
  factory SupportItemModel.fromJson(Map<String, dynamic> json) {
    // Tra ve ket qua cho noi goi ham.
    return SupportItemModel(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      id: json['id'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      title: json['title'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      description: json['description'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      type: json['type'] as String? ?? 'contact',
    );
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien get de luu du lieu su dung trong xu ly.
  List<Object?> get props => [id, title, description, type];
}

// Dinh nghia lop SupportContactSubmissionModel de gom nhom logic lien quan.
class SupportContactSubmissionModel extends Equatable {
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String id;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String name;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String email;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String message;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String status;
  // Khai bao bien DateTime de luu du lieu su dung trong xu ly.
  final DateTime? createdAt;

  // Khai bao bien SupportContactSubmissionModel de luu du lieu su dung trong xu ly.
  const SupportContactSubmissionModel({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.id,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.name,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.email,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.message,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.status,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.createdAt,
  });

  // Thuc thi cau lenh hien tai theo luong xu ly.
  factory SupportContactSubmissionModel.fromJson(Map<String, dynamic> json) {
    // Tra ve ket qua cho noi goi ham.
    return SupportContactSubmissionModel(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      id: json['id'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      name: json['name'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      email: json['email'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      message: json['message'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      status: json['status'] as String? ?? 'pending',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      createdAt: json['created_at'] != null
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? DateTime.tryParse(json['created_at'] as String)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : null,
    );
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien get de luu du lieu su dung trong xu ly.
  List<Object?> get props => [id, name, email, message, status, createdAt];
}
