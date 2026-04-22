// Nap thu vien hoac module can thiet.
import 'package:equatable/equatable.dart';

// Dinh nghia lop InventoryQuickActionData de gom nhom logic lien quan.
class InventoryQuickActionData extends Equatable {
  // Khai bao bien int de luu du lieu su dung trong xu ly.
  final int totalCars;
  // Khai bao bien int de luu du lieu su dung trong xu ly.
  final int availableCars;
  // Khai bao bien int de luu du lieu su dung trong xu ly.
  final int soldCars;
  // Khai bao bien int de luu du lieu su dung trong xu ly.
  final int reservedCars;
  // Khai bao bien List de luu du lieu su dung trong xu ly.
  final List<InventoryCarItem> recentCars;

  // Khai bao bien InventoryQuickActionData de luu du lieu su dung trong xu ly.
  const InventoryQuickActionData({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.totalCars,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.availableCars,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.soldCars,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.reservedCars,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.recentCars,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien get de luu du lieu su dung trong xu ly.
  List<Object?> get props => [
        // Thuc thi cau lenh hien tai theo luong xu ly.
        totalCars,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        availableCars,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        soldCars,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        reservedCars,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        recentCars,
      ];
}

// Dinh nghia lop InventoryCarItem de gom nhom logic lien quan.
class InventoryCarItem extends Equatable {
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
  final String status;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String? fuelType;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String? transmission;

  // Khai bao bien InventoryCarItem de luu du lieu su dung trong xu ly.
  const InventoryCarItem({
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
    required this.mileage,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.status,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.fuelType,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.transmission,
  });

  // Thuc thi cau lenh hien tai theo luong xu ly.
  factory InventoryCarItem.fromJson(Map<String, dynamic> json) {
    // Tra ve ket qua cho noi goi ham.
    return InventoryCarItem(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      id: json['id'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      name: json['name'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      brand: json['brand'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      model: json['model'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      year: (json['year'] as num?)?.toInt() ?? 0,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      color: json['color'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      price: (json['price'] as num?)?.toDouble() ?? 0,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      mileage: (json['mileage'] as num?)?.toInt() ?? 0,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      status: json['status'] as String? ?? 'available',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      fuelType: json['fuel_type'] as String?,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      transmission: json['transmission'] as String?,
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
  String get statusLabel {
    // Bat dau re nhanh theo nhieu truong hop gia tri.
    switch (status) {
      // Xu ly mot truong hop cu the trong switch.
      case 'available':
        // Tra ve ket qua cho noi goi ham.
        return 'Sẵn bán';
      // Xu ly mot truong hop cu the trong switch.
      case 'sold':
        // Tra ve ket qua cho noi goi ham.
        return 'Đã bán';
      // Xu ly mot truong hop cu the trong switch.
      case 'reserved':
        // Tra ve ket qua cho noi goi ham.
        return 'Đã đặt';
      // Xu ly mac dinh khi khong khop case nao.
      default:
        // Tra ve ket qua cho noi goi ham.
        return status;
    }
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien get de luu du lieu su dung trong xu ly.
  List<Object?> get props => [id, name, brand, price, status];
}
