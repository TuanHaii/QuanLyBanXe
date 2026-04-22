import 'package:equatable/equatable.dart';

class SalesQuickActionData extends Equatable {
  final int totalSales;
  final int completedSales;
  final int pendingSales;
  final double totalRevenue;
  final String formattedRevenue;
  final List<SaleOverviewItem> recentSales;

  const SalesQuickActionData({
    required this.totalSales,
    required this.completedSales,
    required this.pendingSales,
    required this.totalRevenue,
    required this.formattedRevenue,
    required this.recentSales,
  });

  @override
  List<Object?> get props => [
        totalSales,
        completedSales,
        pendingSales,
        totalRevenue,
        formattedRevenue,
        recentSales,
      ];
}

class SaleOverviewItem extends Equatable {
  final String id;
  final String carName;
  final String customerName;
  final String customerPhone;
  final double salePrice;
  final double discount;
  final String status;
  final String saleDate;

  const SaleOverviewItem({
    required this.id,
    required this.carName,
    required this.customerName,
    required this.customerPhone,
    required this.salePrice,
    required this.discount,
    required this.status,
    required this.saleDate,
  });

  factory SaleOverviewItem.fromJson(Map<String, dynamic> json) {
    return SaleOverviewItem(
      id: json['id'] as String? ?? '',
      carName: json['car_name'] as String? ?? '',
      customerName: json['customer_name'] as String? ?? '',
      customerPhone: json['customer_phone'] as String? ?? '',
      salePrice: (json['sale_price'] as num?)?.toDouble() ?? 0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0,
      status: json['status'] as String? ?? 'pending',
      saleDate: json['sale_date'] as String? ?? '',
    );
  }

  String get formattedPrice {
    if (salePrice >= 1000000000) {
      return '${(salePrice / 1000000000).toStringAsFixed(1)} tỷ';
    } else if (salePrice >= 1000000) {
      return '${(salePrice / 1000000).toStringAsFixed(0)} triệu';
    }
    return '${salePrice.toStringAsFixed(0)} VNĐ';
  }

  String get statusLabel {
    switch (status) {
      case 'completed':
        return 'Hoàn thành';
      case 'pending':
        return 'Đang chờ';
      case 'cancelled':
        return 'Đã hủy';
      default:
        return status;
    }
  }

  @override
  List<Object?> get props => [
        id,
        carName,
        customerName,
        salePrice,
        status,
      ];
}
