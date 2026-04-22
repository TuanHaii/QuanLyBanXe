import 'package:equatable/equatable.dart';

enum SaleStatus { pending, completed, cancelled }

class SaleModel extends Equatable {
  final String id;
  final String carName;
  final String? carId;
  final String customerName;
  final String? customerId;
  final String? customerPhone;
  final String? customerEmail;
  final double salePrice;
  final double? discount;
  final double? deposit;
  final DateTime saleDate;
  final String? notes;
  final SaleStatus status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const SaleModel({
    required this.id,
    required this.carName,
    this.carId,
    required this.customerName,
    this.customerId,
    this.customerPhone,
    this.customerEmail,
    required this.salePrice,
    this.discount,
    this.deposit,
    required this.saleDate,
    this.notes,
    this.status = SaleStatus.pending,
    this.createdAt,
    this.updatedAt,
  });

  factory SaleModel.fromJson(Map<String, dynamic> json) {
    return SaleModel(
      id: json['id'] as String,
      carName: json['car_name'] as String,
      carId: json['car_id'] as String?,
      customerName: json['customer_name'] as String,
      customerId: json['customer_id'] as String?,
      customerPhone: json['customer_phone'] as String?,
      customerEmail: json['customer_email'] as String?,
      salePrice: (json['sale_price'] as num).toDouble(),
      discount: (json['discount'] as num?)?.toDouble(),
      deposit: (json['deposit'] as num?)?.toDouble(),
      saleDate: DateTime.parse(json['sale_date'] as String),
      notes: json['notes'] as String?,
      status: SaleStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => SaleStatus.pending,
      ),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'car_name': carName,
      'car_id': carId,
      'customer_name': customerName,
      'customer_id': customerId,
      'customer_phone': customerPhone,
      'customer_email': customerEmail,
      'sale_price': salePrice,
      'discount': discount,
      'deposit': deposit,
      'sale_date': saleDate.toIso8601String(),
      'notes': notes,
      'status': status.name,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  SaleModel copyWith({
    String? id,
    String? carName,
    String? carId,
    String? customerName,
    String? customerId,
    String? customerPhone,
    String? customerEmail,
    double? salePrice,
    double? discount,
    double? deposit,
    DateTime? saleDate,
    String? notes,
    SaleStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SaleModel(
      id: id ?? this.id,
      carName: carName ?? this.carName,
      carId: carId ?? this.carId,
      customerName: customerName ?? this.customerName,
      customerId: customerId ?? this.customerId,
      customerPhone: customerPhone ?? this.customerPhone,
      customerEmail: customerEmail ?? this.customerEmail,
      salePrice: salePrice ?? this.salePrice,
      discount: discount ?? this.discount,
      deposit: deposit ?? this.deposit,
      saleDate: saleDate ?? this.saleDate,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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

  String get statusText {
    switch (status) {
      case SaleStatus.pending:
        return 'Chờ xử lý';
      case SaleStatus.completed:
        return 'Hoàn thành';
      case SaleStatus.cancelled:
        return 'Đã hủy';
    }
  }

  double get finalPrice => salePrice - (discount ?? 0);

  @override
  List<Object?> get props => [
        id,
        carName,
        customerName,
        salePrice,
        saleDate,
        status,
      ];
}
