// Nap thu vien hoac module can thiet.
import 'package:equatable/equatable.dart';

// Dinh nghia kieu liet ke SaleStatus.
enum SaleStatus { pending, completed, cancelled }

// Dinh nghia lop SaleModel de gom nhom logic lien quan.
class SaleModel extends Equatable {
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String id;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String carName;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String? carId;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String customerName;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String? customerId;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String? customerPhone;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String? customerEmail;
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double salePrice;
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double? discount;
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double? deposit;
  // Khai bao bien DateTime de luu du lieu su dung trong xu ly.
  final DateTime saleDate;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String? notes;
  // Khai bao bien SaleStatus de luu du lieu su dung trong xu ly.
  final SaleStatus status;
  // Khai bao bien DateTime de luu du lieu su dung trong xu ly.
  final DateTime? createdAt;
  // Khai bao bien DateTime de luu du lieu su dung trong xu ly.
  final DateTime? updatedAt;

  // Khai bao bien SaleModel de luu du lieu su dung trong xu ly.
  const SaleModel({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.id,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.carName,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.carId,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.customerName,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.customerId,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.customerPhone,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.customerEmail,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.salePrice,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.discount,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.deposit,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.saleDate,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.notes,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.status = SaleStatus.pending,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.createdAt,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.updatedAt,
  });

  // Thuc thi cau lenh hien tai theo luong xu ly.
  factory SaleModel.fromJson(Map<String, dynamic> json) {
    // Tra ve ket qua cho noi goi ham.
    return SaleModel(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      id: json['id'] as String,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      carName: json['car_name'] as String,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      carId: json['car_id'] as String?,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      customerName: json['customer_name'] as String,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      customerId: json['customer_id'] as String?,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      customerPhone: json['customer_phone'] as String?,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      customerEmail: json['customer_email'] as String?,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      salePrice: (json['sale_price'] as num).toDouble(),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      discount: (json['discount'] as num?)?.toDouble(),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      deposit: (json['deposit'] as num?)?.toDouble(),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      saleDate: DateTime.parse(json['sale_date'] as String),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      notes: json['notes'] as String?,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      status: SaleStatus.values.firstWhere(
        // Thuc thi cau lenh hien tai theo luong xu ly.
        (e) => e.name == json['status'],
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        orElse: () => SaleStatus.pending,
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      createdAt: json['created_at'] != null
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? DateTime.parse(json['created_at'] as String)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : null,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      updatedAt: json['updated_at'] != null
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? DateTime.parse(json['updated_at'] as String)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : null,
    );
  }

  // Khai bao bien toJson de luu du lieu su dung trong xu ly.
  Map<String, dynamic> toJson() {
    // Tra ve ket qua cho noi goi ham.
    return {
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'id': id,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'car_name': carName,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'car_id': carId,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'customer_name': customerName,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'customer_id': customerId,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'customer_phone': customerPhone,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'customer_email': customerEmail,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'sale_price': salePrice,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'discount': discount,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'deposit': deposit,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'sale_date': saleDate.toIso8601String(),
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'notes': notes,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'status': status.name,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'created_at': createdAt?.toIso8601String(),
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  // Thuc thi cau lenh hien tai theo luong xu ly.
  SaleModel copyWith({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? id,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? carName,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? carId,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? customerName,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? customerId,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? customerPhone,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? customerEmail,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    double? salePrice,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    double? discount,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    double? deposit,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    DateTime? saleDate,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? notes,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    SaleStatus? status,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    DateTime? createdAt,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    DateTime? updatedAt,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) {
    // Tra ve ket qua cho noi goi ham.
    return SaleModel(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      id: id ?? this.id,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      carName: carName ?? this.carName,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      carId: carId ?? this.carId,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      customerName: customerName ?? this.customerName,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      customerId: customerId ?? this.customerId,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      customerPhone: customerPhone ?? this.customerPhone,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      customerEmail: customerEmail ?? this.customerEmail,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      salePrice: salePrice ?? this.salePrice,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      discount: discount ?? this.discount,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      deposit: deposit ?? this.deposit,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      saleDate: saleDate ?? this.saleDate,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      notes: notes ?? this.notes,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      status: status ?? this.status,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      createdAt: createdAt ?? this.createdAt,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      updatedAt: updatedAt ?? this.updatedAt,
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
  String get statusText {
    // Bat dau re nhanh theo nhieu truong hop gia tri.
    switch (status) {
      // Xu ly mot truong hop cu the trong switch.
      case SaleStatus.pending:
        // Tra ve ket qua cho noi goi ham.
        return 'Chờ xử lý';
      // Xu ly mot truong hop cu the trong switch.
      case SaleStatus.completed:
        // Tra ve ket qua cho noi goi ham.
        return 'Hoàn thành';
      // Xu ly mot truong hop cu the trong switch.
      case SaleStatus.cancelled:
        // Tra ve ket qua cho noi goi ham.
        return 'Đã hủy';
    }
  }

  // Khai bao bien get de luu du lieu su dung trong xu ly.
  double get finalPrice => salePrice - (discount ?? 0);

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
        saleDate,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        status,
      ];
}
