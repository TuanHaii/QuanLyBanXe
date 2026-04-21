class CarModel {
  final String id;
  final String name;
  final String brand;
  final String model;
  final String category;
  final int year;
  final double price;
  final String status;
  final int stock;
  final double rating;
  final String imageUrl;
  final String? badgeLabel;
  final String? badgeColor;
  final String? description;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CarModel({
    required this.id,
    required this.brand,
    required this.name,
    required this.model,
    required this.category,
    required this.year,
    required this.price,
    required this.status,
    required this.stock,
    required this.rating,
    required this.imageUrl,
    this.badgeLabel,
    this.badgeColor,
    this.description,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id']?.toString() ?? '',
      brand: json['brand']?.toString() ?? '',
      model: json['model']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      category: json['category']?.toString() ?? 'Sedan',
      year: int.tryParse(json['year']?.toString() ?? '') ?? 0,
      // Sử dụng `num` để parse an toàn phòng khi BE trả về int thay vì double
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      status: json['status']?.toString() ?? 'available',
      stock: int.tryParse(json['stock']?.toString() ?? '') ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['imageUrl']?.toString() ?? '',
      badgeLabel: json['badgeLabel']?.toString(),
      badgeColor: json['badgeColor']?.toString(),
      description: json['description']?.toString(),
      createdBy: json['createdBy']?.toString(),
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
      'brand': brand,
      'model': model,
      'category': category,
      'year': year,
      'price': price,
      'status': status,
      'stock': stock,
      'rating': rating,
      'imageUrl': imageUrl,
      'badgeLabel': badgeLabel,
      'badgeColor': badgeColor,
      'description': description,
      'createdBy': createdBy,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
