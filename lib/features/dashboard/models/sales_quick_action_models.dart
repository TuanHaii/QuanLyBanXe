// Nap thu vien hoac module can thiet.
import 'package:equatable/equatable.dart';

// Dinh nghia lop SalesQuickActionData de gom nhom logic lien quan.
class SalesQuickActionData extends Equatable {
  // Khai bao bien int de luu du lieu su dung trong xu ly.
  final int totalSales;
  // Khai bao bien int de luu du lieu su dung trong xu ly.
  final int completedSales;
  // Khai bao bien int de luu du lieu su dung trong xu ly.
  final int pendingSales;
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double totalRevenue;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String formattedRevenue;
  // Khai bao bien List de luu du lieu su dung trong xu ly.
  final List<SaleOverviewItem> recentSales;

  // Khai bao bien SalesQuickActionData de luu du lieu su dung trong xu ly.
  const SalesQuickActionData({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.totalSales,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.completedSales,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.pendingSales,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.totalRevenue,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.formattedRevenue,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.recentSales,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien get de luu du lieu su dung trong xu ly.
  List<Object?> get props => [
        // Thuc thi cau lenh hien tai theo luong xu ly.
        totalSales,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        completedSales,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        pendingSales,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        totalRevenue,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        formattedRevenue,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        recentSales,
      ];
}

// Dinh nghia lop SaleOverviewItem de gom nhom logic lien quan.
class SaleOverviewItem extends Equatable {
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String id;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String carName;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String customerName;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String customerPhone;
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double salePrice;
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double discount;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String status;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String saleDate;

  // Khai bao bien SaleOverviewItem de luu du lieu su dung trong xu ly.
  const SaleOverviewItem({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.id,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.carName,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.customerName,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.customerPhone,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.salePrice,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.discount,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.status,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.saleDate,
  });

  // Thuc thi cau lenh hien tai theo luong xu ly.
  factory SaleOverviewItem.fromJson(Map<String, dynamic> json) {
    // Tra ve ket qua cho noi goi ham.
    return SaleOverviewItem(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      id: json['id'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      carName: json['car_name'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      customerName: json['customer_name'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      customerPhone: json['customer_phone'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      salePrice: (json['sale_price'] as num?)?.toDouble() ?? 0,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      discount: (json['discount'] as num?)?.toDouble() ?? 0,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      status: json['status'] as String? ?? 'pending',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      saleDate: json['sale_date'] as String? ?? '',
    );
  }

  // Khai bao bien get de luu du lieu su dung trong xu ly.
  String get formattedPrice {
    // Kiem tra dieu kien de re nhanh xu ly.
    if (salePrice >= 1000000000) {
      // Tra ve ket qua cho noi goi ham.
      return '${(salePrice / 1000000000).toStringAsFixed(1)} tỷ';
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } else if (salePrice >= 1000000) {
      // Tra ve ket qua cho noi goi ham.
      return '${(salePrice / 1000000).toStringAsFixed(0)} triệu';
    }
    // Tra ve ket qua cho noi goi ham.
    return '${salePrice.toStringAsFixed(0)} VNĐ';
  }

  // Khai bao bien get de luu du lieu su dung trong xu ly.
  String get statusLabel {
    // Bat dau re nhanh theo nhieu truong hop gia tri.
    switch (status) {
      // Xu ly mot truong hop cu the trong switch.
      case 'completed':
        // Tra ve ket qua cho noi goi ham.
        return 'Hoàn thành';
      // Xu ly mot truong hop cu the trong switch.
      case 'pending':
        // Tra ve ket qua cho noi goi ham.
        return 'Đang chờ';
      // Xu ly mot truong hop cu the trong switch.
      case 'cancelled':
        // Tra ve ket qua cho noi goi ham.
        return 'Đã hủy';
      // Xu ly mac dinh khi khong khop case nao.
      default:
        // Tra ve ket qua cho noi goi ham.
        return status;
    }
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien get de luu du lieu su dung trong xu ly.
  List<Object?> get props => [
        // Thuc thi cau lenh hien tai theo luong xu ly.
        id,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        carName,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        customerName,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        salePrice,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        status,
      ];
}
