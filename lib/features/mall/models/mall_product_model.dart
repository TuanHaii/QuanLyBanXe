import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class MallProduct extends Equatable {
  final String id;
  final String brand;
  final String model;
  final String name;
  final String category;
  final int year;
  final double price;
  final int stock;
  final double rating;
  final String status;
  final String imageUrl;
  final String badgeLabel;
  final String badgeColor;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const MallProduct({
    required this.id,
    required this.brand,
    required this.model,
    required this.name,
    required this.category,
    required this.year,
    required this.price,
    required this.stock,
    required this.rating,
    required this.status,
    required this.imageUrl,
    required this.badgeLabel,
    required this.badgeColor,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory MallProduct.fromJson(Map<String, dynamic> json) {
    final brand = json['brand'] as String? ?? '';
    final model = json['model'] as String? ?? '';
    return MallProduct(
      id: json['id'] as String,
      brand: brand,
      model: model,
      name: '$brand $model'.trim(),
      category: json['category'] as String? ?? 'Khác',
      year: json['year'] as int? ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      stock: json['stock'] as int? ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      status: json['status'] as String? ?? 'available',
      imageUrl: json['image_url'] as String? ?? '',
      badgeLabel: json['badge_label'] as String? ?? 'Hot',
      badgeColor: json['badge_color'] as String? ?? '#E0B54E',
      description: json['description'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String)
          : null,
    );
  }

  Color get badgeColorValue {
    try {
      final cleaned = badgeColor.replaceAll('#', '').padLeft(8, 'FF');
      return Color(int.parse('0x$cleaned'));
    } catch (_) {
      return const Color(0xFFE0B54E);
    }
  }

  String get priceLabel {
    if (price >= 1000000000) {
      return '${(price / 1000000000).toStringAsFixed(1)} tỷ';
    } else if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(0)} triệu';
    }
    return '${price.toStringAsFixed(0)} VNĐ';
  }

  @override
  List<Object?> get props => [
    id,
    name,
    category,
    year,
    price,
    stock,
    rating,
    status,
  ];
}
