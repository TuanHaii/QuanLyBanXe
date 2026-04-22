import 'package:equatable/equatable.dart';

class InventoryQuickActionData extends Equatable {
  final int totalCars;
  final int availableCars;
  final int soldCars;
  final int reservedCars;
  final List<InventoryCarItem> recentCars;

  const InventoryQuickActionData({
    required this.totalCars,
    required this.availableCars,
    required this.soldCars,
    required this.reservedCars,
    required this.recentCars,
  });

  @override
  List<Object?> get props => [
        totalCars,
        availableCars,
        soldCars,
        reservedCars,
        recentCars,
      ];
}

class InventoryCarItem extends Equatable {
  final String id;
  final String name;
  final String brand;
  final String model;
  final int year;
  final String color;
  final double price;
  final int mileage;
  final String status;
  final String? fuelType;
  final String? transmission;

  const InventoryCarItem({
    required this.id,
    required this.name,
    required this.brand,
    required this.model,
    required this.year,
    required this.color,
    required this.price,
    required this.mileage,
    required this.status,
    this.fuelType,
    this.transmission,
  });

  factory InventoryCarItem.fromJson(Map<String, dynamic> json) {
    return InventoryCarItem(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      brand: json['brand'] as String? ?? '',
      model: json['model'] as String? ?? '',
      year: (json['year'] as num?)?.toInt() ?? 0,
      color: json['color'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      mileage: (json['mileage'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'available',
      fuelType: json['fuel_type'] as String?,
      transmission: json['transmission'] as String?,
    );
  }

  String get formattedPrice {
    if (price >= 1000000000) {
      return '${(price / 1000000000).toStringAsFixed(1)} tỷ';
    } else if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(0)} triệu';
    }
    return '${price.toStringAsFixed(0)} VNĐ';
  }

  String get statusLabel {
    switch (status) {
      case 'available':
        return 'Sẵn bán';
      case 'sold':
        return 'Đã bán';
      case 'reserved':
        return 'Đã đặt';
      default:
        return status;
    }
  }

  @override
  List<Object?> get props => [id, name, brand, price, status];
}
