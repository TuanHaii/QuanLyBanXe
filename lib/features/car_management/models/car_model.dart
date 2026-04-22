// Nap thu vien hoac module can thiet.
import 'package:equatable/equatable.dart';

// Dinh nghia kieu liet ke CarStatus.
enum CarStatus { available, sold, reserved }

// Dinh nghia lop CarModel de gom nhom logic lien quan.
class CarModel extends Equatable {
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String id;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String name;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String brand;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String model;
  // Khai bao bien int de luu du lieu su dung trong xu ly.
  final int year;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String color;
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double price;
  // Khai bao bien int de luu du lieu su dung trong xu ly.
  final int mileage;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String? description;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String? fuelType;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String? transmission;
  // Khai bao bien List de luu du lieu su dung trong xu ly.
  final List<String> images;
  // Khai bao bien CarStatus de luu du lieu su dung trong xu ly.
  final CarStatus status;
  // Khai bao bien DateTime de luu du lieu su dung trong xu ly.
  final DateTime? createdAt;
  // Khai bao bien DateTime de luu du lieu su dung trong xu ly.
  final DateTime? updatedAt;

  // Khai bao bien CarModel de luu du lieu su dung trong xu ly.
  const CarModel({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.id,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.name,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.brand,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.model,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.year,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.color,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.price,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.mileage = 0,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.description,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.fuelType,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.transmission,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.images = const [],
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.status = CarStatus.available,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.createdAt,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.updatedAt,
  });

  // Thuc thi cau lenh hien tai theo luong xu ly.
  factory CarModel.fromJson(Map<String, dynamic> json) {
    // Tra ve ket qua cho noi goi ham.
    return CarModel(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      id: json['id'] as String,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      name: json['name'] as String,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      brand: json['brand'] as String,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      model: json['model'] as String,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      year: json['year'] as int,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      color: json['color'] as String,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      price: (json['price'] as num).toDouble(),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      mileage: json['mileage'] as int? ?? 0,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      description: json['description'] as String?,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      fuelType: json['fuel_type'] as String?,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      transmission: json['transmission'] as String?,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      images: (json['images'] as List<dynamic>?)
              // Thuc thi cau lenh hien tai theo luong xu ly.
              ?.map((e) => e as String)
              // Thuc thi cau lenh hien tai theo luong xu ly.
              .toList() ??
          // Thuc thi cau lenh hien tai theo luong xu ly.
          [],
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      status: CarStatus.values.firstWhere(
        // Thuc thi cau lenh hien tai theo luong xu ly.
        (e) => e.name == json['status'],
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        orElse: () => CarStatus.available,
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
      'name': name,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'brand': brand,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'model': model,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'year': year,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'color': color,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'price': price,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'mileage': mileage,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'description': description,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'fuel_type': fuelType,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'transmission': transmission,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'images': images,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'status': status.name,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'created_at': createdAt?.toIso8601String(),
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  // Thuc thi cau lenh hien tai theo luong xu ly.
  CarModel copyWith({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? id,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? name,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? brand,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? model,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    int? year,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? color,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    double? price,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    int? mileage,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? description,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? fuelType,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? transmission,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    List<String>? images,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    CarStatus? status,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    DateTime? createdAt,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    DateTime? updatedAt,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) {
    // Tra ve ket qua cho noi goi ham.
    return CarModel(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      id: id ?? this.id,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      name: name ?? this.name,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      brand: brand ?? this.brand,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      model: model ?? this.model,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      year: year ?? this.year,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      color: color ?? this.color,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      price: price ?? this.price,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      mileage: mileage ?? this.mileage,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      description: description ?? this.description,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      fuelType: fuelType ?? this.fuelType,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      transmission: transmission ?? this.transmission,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      images: images ?? this.images,
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
    if (price >= 1000000000) {
      // Tra ve ket qua cho noi goi ham.
      return '${(price / 1000000000).toStringAsFixed(1)} tỷ';
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } else if (price >= 1000000) {
      // Tra ve ket qua cho noi goi ham.
      return '${(price / 1000000).toStringAsFixed(0)} triệu';
    }
    // Tra ve ket qua cho noi goi ham.
    return '${price.toStringAsFixed(0)} VNĐ';
  }

  // Khai bao bien get de luu du lieu su dung trong xu ly.
  String get statusText {
    // Bat dau re nhanh theo nhieu truong hop gia tri.
    switch (status) {
      // Xu ly mot truong hop cu the trong switch.
      case CarStatus.available:
        // Tra ve ket qua cho noi goi ham.
        return 'Còn hàng';
      // Xu ly mot truong hop cu the trong switch.
      case CarStatus.sold:
        // Tra ve ket qua cho noi goi ham.
        return 'Đã bán';
      // Xu ly mot truong hop cu the trong switch.
      case CarStatus.reserved:
        // Tra ve ket qua cho noi goi ham.
        return 'Đã đặt';
    }
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien get de luu du lieu su dung trong xu ly.
  List<Object?> get props => [
        // Thuc thi cau lenh hien tai theo luong xu ly.
        id,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        name,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        brand,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        model,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        year,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        color,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        price,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        mileage,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        status,
      ];
}
