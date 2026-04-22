// Nap thu vien hoac module can thiet.
import 'package:equatable/equatable.dart';

// Dinh nghia lop DashboardSummaryModel de gom nhom logic lien quan.
class DashboardSummaryModel extends Equatable {
  // Khai bao bien int de luu du lieu su dung trong xu ly.
  final int totalCars;
  // Khai bao bien int de luu du lieu su dung trong xu ly.
  final int carsSold;
  // Khai bao bien int de luu du lieu su dung trong xu ly.
  final int inStock;
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double totalRevenue;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String revenueTrend;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String totalRevenueLabel;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String salesTrend;
  // Khai bao bien List de luu du lieu su dung trong xu ly.
  final List<RecentTransactionModel> recentTransactions;

  // Khai bao bien DashboardSummaryModel de luu du lieu su dung trong xu ly.
  const DashboardSummaryModel({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.totalCars,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.carsSold,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.inStock,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.totalRevenue,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.revenueTrend,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.totalRevenueLabel,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.salesTrend,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.recentTransactions,
  });

  // Thuc thi cau lenh hien tai theo luong xu ly.
  factory DashboardSummaryModel.fromJson(Map<String, dynamic> json) {
    // Khai bao bien summary de luu du lieu su dung trong xu ly.
    final summary = json['summary'] as Map<String, dynamic>? ?? const {};
    // Khai bao bien transactions de luu du lieu su dung trong xu ly.
    final transactions =
        // Thuc thi cau lenh hien tai theo luong xu ly.
        json['recent_transactions'] as List<dynamic>? ?? const [];

    // Tra ve ket qua cho noi goi ham.
    return DashboardSummaryModel(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      totalCars: (summary['totalCars'] as num?)?.toInt() ?? 0,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      carsSold: (summary['carsSold'] as num?)?.toInt() ?? 0,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      inStock: (summary['inStock'] as num?)?.toInt() ?? 0,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      totalRevenue: (summary['totalRevenue'] as num?)?.toDouble() ?? 0,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      revenueTrend: summary['revenueTrend'] as String? ?? '0%',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      totalRevenueLabel: summary['totalRevenueLabel'] as String? ?? '0',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      salesTrend: summary['salesTrend'] as String? ?? '0%',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      recentTransactions: transactions
          // Thuc thi cau lenh hien tai theo luong xu ly.
          .whereType<Map<String, dynamic>>()
          // Thuc thi cau lenh hien tai theo luong xu ly.
          .map(RecentTransactionModel.fromJson)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          .toList(growable: false),
    );
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien get de luu du lieu su dung trong xu ly.
  List<Object?> get props => [
        // Thuc thi cau lenh hien tai theo luong xu ly.
        totalCars,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        carsSold,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        inStock,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        totalRevenue,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        revenueTrend,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        totalRevenueLabel,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        salesTrend,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        recentTransactions,
      ];
}

// Dinh nghia lop RecentTransactionModel de gom nhom logic lien quan.
class RecentTransactionModel extends Equatable {
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String id;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String customerName;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String carName;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String amount;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String timeAgo;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String status;

  // Khai bao bien RecentTransactionModel de luu du lieu su dung trong xu ly.
  const RecentTransactionModel({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.id,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.customerName,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.carName,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.amount,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.timeAgo,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.status,
  });

  // Thuc thi cau lenh hien tai theo luong xu ly.
  factory RecentTransactionModel.fromJson(Map<String, dynamic> json) {
    // Tra ve ket qua cho noi goi ham.
    return RecentTransactionModel(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      id: json['id'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      customerName: json['customer_name'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      carName: json['car_name'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      amount: json['amount'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      timeAgo: json['time_ago'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      status: json['status'] as String? ?? '',
    );
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien get de luu du lieu su dung trong xu ly.
  List<Object?> get props => [
        // Thuc thi cau lenh hien tai theo luong xu ly.
        id,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        customerName,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        carName,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        amount,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        timeAgo,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        status,
      ];
}
