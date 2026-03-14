import 'package:equatable/equatable.dart';

enum CarStatus { available, sold, reserved }

class CarModel extends Equatable {
  final String id;
  final String name;
  final String brand;
  final String model;
  final int year;
  final String color;
  final double price;
  final int mileage;
  final String? description;
  final String? fuelType;
  final String? transmission;
  final List<String> images;
  final CarStatus status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CarModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.model,
    required this.year,
    required this.color,
    required this.price,
    this.mileage = 0,
    this.description,
    this.fuelType,
    this.transmission,
    this.images = const [],
    this.status = CarStatus.available,
    this.createdAt,
    this.updatedAt,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'] as String,
      name: json['name'] as String,
      brand: json['brand'] as String,
      model: json['model'] as String,
      year: json['year'] as int,
      color: json['color'] as String,
      price: (json['price'] as num).toDouble(),
      mileage: json['mileage'] as int? ?? 0,
      description: json['description'] as String?,
      fuelType: json['fuel_type'] as String?,
      transmission: json['transmission'] as String?,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      status: CarStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => CarStatus.available,
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
      'name': name,
      'brand': brand,
      'model': model,
      'year': year,
      'color': color,
      'price': price,
      'mileage': mileage,
      'description': description,
      'fuel_type': fuelType,
      'transmission': transmission,
      'images': images,
      'status': status.name,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  CarModel copyWith({
    String? id,
    String? name,
    String? brand,
    String? model,
    int? year,
    String? color,
    double? price,
    int? mileage,
    String? description,
    String? fuelType,
    String? transmission,
    List<String>? images,
    CarStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CarModel(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      year: year ?? this.year,
      color: color ?? this.color,
      price: price ?? this.price,
      mileage: mileage ?? this.mileage,
      description: description ?? this.description,
      fuelType: fuelType ?? this.fuelType,
      transmission: transmission ?? this.transmission,
      images: images ?? this.images,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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

  String get statusText {
    switch (status) {
      case CarStatus.available:
        return 'Còn hàng';
      case CarStatus.sold:
        return 'Đã bán';
      case CarStatus.reserved:
        return 'Đã đặt';
    }
  }

  @override
  List<Object?> get props => [
        id,
        name,
        brand,
        model,
        year,
        color,
        price,
        mileage,
        status,
      ];
}
