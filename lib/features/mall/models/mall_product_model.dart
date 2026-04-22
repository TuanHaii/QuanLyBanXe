// Nap thu vien hoac module can thiet.
import 'package:equatable/equatable.dart';
// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';

// Dinh nghia lop MallProduct de gom nhom logic lien quan.
class MallProduct extends Equatable {
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String id;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String brand;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String model;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String name;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String category;
  // Khai bao bien int de luu du lieu su dung trong xu ly.
  final int year;
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double price;
  // Khai bao bien int de luu du lieu su dung trong xu ly.
  final int stock;
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double rating;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String status;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String imageUrl;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String badgeLabel;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String badgeColor;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String? description;
  // Khai bao bien DateTime de luu du lieu su dung trong xu ly.
  final DateTime? createdAt;
  // Khai bao bien DateTime de luu du lieu su dung trong xu ly.
  final DateTime? updatedAt;

  // Khai bao bien MallProduct de luu du lieu su dung trong xu ly.
  const MallProduct({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.id,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.brand,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.model,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.name,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.category,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.year,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.price,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.stock,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.rating,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.status,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.imageUrl,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.badgeLabel,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.badgeColor,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.description,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.createdAt,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.updatedAt,
  });

  // Thuc thi cau lenh hien tai theo luong xu ly.
  factory MallProduct.fromJson(Map<String, dynamic> json) {
    // Khai bao bien brand de luu du lieu su dung trong xu ly.
    final brand = json['brand'] as String? ?? '';
    // Khai bao bien model de luu du lieu su dung trong xu ly.
    final model = json['model'] as String? ?? '';
    // Tra ve ket qua cho noi goi ham.
    return MallProduct(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      id: json['id'] as String,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      brand: brand,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      model: model,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      name: '$brand $model'.trim(),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      category: json['category'] as String? ?? 'Khác',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      year: json['year'] as int? ?? 0,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      price: (json['price'] as num?)?.toDouble() ?? 0,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      stock: json['stock'] as int? ?? 0,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      status: json['status'] as String? ?? 'available',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      imageUrl: json['image_url'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      badgeLabel: json['badge_label'] as String? ?? 'Hot',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      badgeColor: json['badge_color'] as String? ?? '#E0B54E',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      description: json['description'] as String?,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      createdAt: json['created_at'] != null
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? DateTime.tryParse(json['created_at'] as String)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : null,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      updatedAt: json['updated_at'] != null
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? DateTime.tryParse(json['updated_at'] as String)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : null,
    );
  }

  // Khai bao bien get de luu du lieu su dung trong xu ly.
  Color get badgeColorValue {
    // Bao boc khoi lenh co the phat sinh loi de xu ly an toan.
    try {
      // Khai bao bien cleaned de luu du lieu su dung trong xu ly.
      final cleaned = badgeColor.replaceAll('#', '').padLeft(8, 'FF');
      // Tra ve ket qua cho noi goi ham.
      return Color(int.parse('0x$cleaned'));
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } catch (_) {
      // Tra ve ket qua cho noi goi ham.
      return const Color(0xFFE0B54E);
    }
  }

  // Khai bao bien get de luu du lieu su dung trong xu ly.
  String get priceLabel {
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

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien get de luu du lieu su dung trong xu ly.
  List<Object?> get props => [
    // Thuc thi cau lenh hien tai theo luong xu ly.
    id,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    name,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    category,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    year,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    price,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    stock,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    rating,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    status,
  ];
}
