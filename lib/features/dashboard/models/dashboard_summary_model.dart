// ============================================================
// FILE: dashboard_summary_model.dart
// MÔ TẢ: Model chứa dữ liệu tổng quan dashboard.
//        Parse từ JSON response của API GET /api/dashboard/summary.
//        Lưu thông tin: Tổng xe, Bán được, Trong kho, Doanh thu,
//        xu hướng, và danh sách giao dịch gần đây.
// ============================================================

import 'package:equatable/equatable.dart';

/// Class này đại diện cho dữ liệu tổng quan dashboard.
/// Được parse từ API response và dùng để hiển thị 4 StatCard + giao dịch gần đây.
class DashboardSummaryModel extends Equatable {
  // Tổng số xe có trong kho
  final int totalCars;

  // Số xe đã bán cho khách hàng
  final int carsSold;

  // Số xe còn trong kho (= totalCars - carsSold)
  final int inStock;

  // Tổng doanh thu (số tiền bán hàng) theo đơn vị là VND (Việt Nam Đồng)
  final double totalRevenue;

  // Xu hướng doanh thu so với kỳ trước (vd: "+15%", "-5%")
  final String revenueTrend;

  // Nhãn doanh thu định dạng (vd: "1.2B", "500M" cho dễ đọc)
  final String totalRevenueLabel;

  // Xu hướng sales (số lần bán) so với kỳ trước (vd: "+10%")
  final String salesTrend;

  // Danh sách các giao dịch gần đây (bán xe lần cuối)
  final List<RecentTransactionModel> recentTransactions;

  const DashboardSummaryModel({
    required this.totalCars,
    required this.carsSold,
    required this.inStock,
    required this.totalRevenue,
    required this.revenueTrend,
    required this.totalRevenueLabel,
    required this.salesTrend,
    required this.recentTransactions,
  });

  factory DashboardSummaryModel.fromJson(Map<String, dynamic> json) {
    final summary = json['summary'] as Map<String, dynamic>? ?? const {};
    final transactions =
        json['recent_transactions'] as List<dynamic>? ?? const [];

    return DashboardSummaryModel(
      totalCars: (summary['totalCars'] as num?)?.toInt() ?? 0,
      carsSold: (summary['carsSold'] as num?)?.toInt() ?? 0,
      inStock: (summary['inStock'] as num?)?.toInt() ?? 0,
      totalRevenue: (summary['totalRevenue'] as num?)?.toDouble() ?? 0,
      revenueTrend: summary['revenueTrend'] as String? ?? '0%',
      totalRevenueLabel: summary['totalRevenueLabel'] as String? ?? '0',
      salesTrend: summary['salesTrend'] as String? ?? '0%',
      recentTransactions: transactions
          .whereType<Map<String, dynamic>>()
          .map(RecentTransactionModel.fromJson)
          .toList(growable: false),
    );
  }

  @override
  List<Object?> get props => [
    totalCars,
    carsSold,
    inStock,
    totalRevenue,
    revenueTrend,
    totalRevenueLabel,
    salesTrend,
    recentTransactions,
  ];
}

class RecentTransactionModel extends Equatable {
  final String id;
  final String customerName;
  final String carName;
  final String amount;
  final String timeAgo;
  final String status;

  const RecentTransactionModel({
    required this.id,
    required this.customerName,
    required this.carName,
    required this.amount,
    required this.timeAgo,
    required this.status,
  });

  factory RecentTransactionModel.fromJson(Map<String, dynamic> json) {
    return RecentTransactionModel(
      id: json['id'] as String? ?? '',
      customerName: json['customer_name'] as String? ?? '',
      carName: json['car_name'] as String? ?? '',
      amount: json['amount'] as String? ?? '',
      timeAgo: json['time_ago'] as String? ?? '',
      status: json['status'] as String? ?? '',
    );
  }

  @override
  List<Object?> get props => [
    id,
    customerName,
    carName,
    amount,
    timeAgo,
    status,
  ];
}
