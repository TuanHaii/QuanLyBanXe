import 'package:equatable/equatable.dart';

class DashboardSummaryModel extends Equatable {
  final int totalCars;
  final int carsSold;
  final int inStock;
  final double totalRevenue;
  final String revenueTrend;
  final String totalRevenueLabel;
  final String salesTrend;
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
