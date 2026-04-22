class CatalogOption {
  final int id;
  final String name;

  const CatalogOption({required this.id, required this.name});

  factory CatalogOption.fromBrandJson(Map<String, dynamic> json) {
    return CatalogOption(
      id: _asInt(json['maHang'] ?? json['MaHang'] ?? json['id']),
      name: _asString(json['tenHang'] ?? json['TenHang'] ?? json['name']),
    );
  }

  factory CatalogOption.fromCategoryJson(Map<String, dynamic> json) {
    return CatalogOption(
      id: _asInt(json['maLoaiXe'] ?? json['MaLoaiXe'] ?? json['id']),
      name: _asString(json['tenLoai'] ?? json['TenLoai'] ?? json['name']),
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
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

String _asString(dynamic value) {
  return value?.toString() ?? '';
}
