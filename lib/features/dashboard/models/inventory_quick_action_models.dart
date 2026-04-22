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
    final rawStatus = json['status'] ?? json['trangThai'] ?? json['TrangThai'];

    return InventoryCarItem(
      id: _asString(json['id'] ?? json['maXe'] ?? json['MaXe']),
      name: _asString(json['name'] ?? json['tenXe'] ?? json['TenXe']),
      brand: _asString(
        json['brand'] ??
            json['tenHang'] ??
            json['HangXe']?['tenHang'] ??
            json['HangXe']?['TenHang'],
      ),
      model: _asString(
        json['model'] ??
            json['tenLoai'] ??
            json['LoaiXe']?['tenLoai'] ??
            json['LoaiXe']?['TenLoai'],
      ),
      year: _asInt(json['year'] ?? json['namSanXuat'] ?? json['NamSanXuat']),
      color: _asString(json['color'] ?? json['mauSac'] ?? json['MauSac']),
      price: _asDouble(json['price'] ?? json['giaBan'] ?? json['GiaBan']),
      mileage: _asInt(
        json['mileage'] ?? json['soLuongTon'] ?? json['SoLuongTon'],
      ),
      status: _normalizeStatus(rawStatus),
      fuelType: _asNullableString(
        json['fuel_type'] ?? json['dungTich'] ?? json['DungTich'],
      ),
      transmission: _asNullableString(json['transmission']),
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

String _asString(dynamic value) {
  if (value == null) {
    return '';
  }
  return value.toString();
}

String? _asNullableString(dynamic value) {
  final text = _asString(value).trim();
  if (text.isEmpty) {
    return null;
  }
  return text;
}

int _asInt(dynamic value) {
  if (value is int) {
    return value;
  }
  if (value is double) {
    return value.toInt();
  }
  if (value is String) {
    return int.tryParse(value) ?? 0;
  }
  return 0;
}

double _asDouble(dynamic value) {
  if (value is double) {
    return value;
  }
  if (value is int) {
    return value.toDouble();
  }
  if (value is String) {
    return double.tryParse(value) ?? 0;
  }
  return 0;
}

String _normalizeStatus(dynamic value) {
  if (value is bool) {
    return value ? 'available' : 'sold';
  }

  final raw = _asString(value).toLowerCase().trim();
  if (raw.isEmpty) {
    return 'available';
  }

  if (raw == 'true' || raw == '1' || raw == 'available' || raw == 'active') {
    return 'available';
  }

  if (raw == 'reserved') {
    return 'reserved';
  }

  if (raw == 'sold' || raw == 'false' || raw == '0' || raw == 'inactive') {
    return 'sold';
  }

  return raw;
}
