import 'package:equatable/equatable.dart';

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
    // 1. Trích xuất đúng object summary từ JSON
    final summary = json['summary'] as Map<String, dynamic>? ?? {};
    final transactions = json['recent_transactions'] as List<dynamic>? ?? [];

    return DashboardSummaryModel(
      // 2.
      totalCars: summary['totalCars'] is int
          ? summary['totalCars']
          : int.tryParse(summary['totalCars']?.toString() ?? '0') ?? 0,

      carsSold: summary['carsSold'] is int
          ? summary['carsSold']
          : int.tryParse(summary['carsSold']?.toString() ?? '0') ?? 0,

      inStock: summary['inStock'] is int
          ? summary['inStock']
          : int.tryParse(summary['inStock']?.toString() ?? '0') ?? 0,

      totalRevenue: (summary['totalRevenue'] as num?)?.toDouble() ?? 0.0,
      revenueTrend: summary['revenueTrend']?.toString() ?? '+0%',
      totalRevenueLabel: summary['totalRevenueLabel']?.toString() ?? '0',
      salesTrend: summary['salesTrend']?.toString() ?? '+0%',

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
      // 🛠 FIX: Luôn dùng .toString() thay vì 'as String?' để chống crash
      id: json['id']?.toString() ?? '',
      carName: json['car_name']?.toString() ?? '',
      customerName: json['customer_name']?.toString() ?? '',
      amount: json['amount']?.toString() ?? '0',

      // 🛠 FIX: Backend đang trả về key 'date' chứ không phải 'time_ago'
      timeAgo: json['date']?.toString() ?? json['time_ago']?.toString() ?? '',

      // 🛠 FIX: BE trả về số 0, 1, 2 nên phải dùng .toString()
      status: json['status']?.toString() ?? '0',
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
