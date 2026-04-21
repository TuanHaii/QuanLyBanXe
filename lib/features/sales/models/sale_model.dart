class SaleModel {
  final String id;
  final String carName;
  final String carId;
  final String customerName;
  final String customerId;
  final String customerPhone;
  final String customerEmail;
  final double salePrice;
  final double discount;
  final double deposit;
  final DateTime? saleDate;
  final String? notes;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SaleModel({
    required this.id,
    required this.carName,
    required this.carId,
    required this.customerName,
    required this.customerId,
    required this.customerPhone,
    required this.customerEmail,
    required this.salePrice,
    required this.discount,
    required this.deposit,
    this.saleDate,
    this.notes,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory SaleModel.fromJson(Map<String, dynamic> json) {
    return SaleModel(
      id: json['id']?.toString() ?? '',
      carName: json['carName']?.toString() ?? '',
      carId: json['carId']?.toString() ?? '',
      customerName: json['customerName']?.toString() ?? '',
      customerId: json['customerId']?.toString() ?? '',
      customerPhone: json['customerPhone']?.toString() ?? '',
      customerEmail: json['customerEmail']?.toString() ?? '',
      salePrice: (json['salePrice'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      deposit: (json['deposit'] as num?)?.toDouble() ?? 0.0,
      saleDate: json['saleDate'] != null
          ? DateTime.tryParse(json['saleDate'])
          : null,
      notes: json['notes']?.toString(),
      status: json['status']?.toString() ?? 'pending',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'carName': carName,
      'carId': carId,
      'customerName': customerName,
      'customerId': customerId,
      'customerPhone': customerPhone,
      'customerEmail': customerEmail,
      'salePrice': salePrice,
      'discount': discount,
      'deposit': deposit,
      'saleDate': saleDate?.toIso8601String(),
      'notes': notes,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
