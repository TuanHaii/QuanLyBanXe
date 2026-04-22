import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class HangXeModel extends Equatable {
  final int maHang;
  final String tenHang;
  final String? quocGia;

  const HangXeModel({
    required this.maHang,
    required this.tenHang,
    this.quocGia,
  });

  factory HangXeModel.fromJson(Map<String, dynamic> json) {
    return HangXeModel(
      maHang: _asInt(json['maHang'] ?? json['MaHang']),
      tenHang: _asString(json['tenHang'] ?? json['TenHang']),
      quocGia: _asStringOrNull(json['quocGia'] ?? json['QuocGia']),
    );
  }

  Map<String, dynamic> toJson() => {
    'maHang': maHang,
    'tenHang': tenHang,
    'quocGia': quocGia,
  };

  @override
  List<Object?> get props => [maHang, tenHang, quocGia];
}

class LoaiXeModel extends Equatable {
  final int maLoaiXe;
  final String tenLoai;

  const LoaiXeModel({required this.maLoaiXe, required this.tenLoai});

  factory LoaiXeModel.fromJson(Map<String, dynamic> json) {
    return LoaiXeModel(
      maLoaiXe: _asInt(json['maLoaiXe'] ?? json['MaLoaiXe']),
      tenLoai: _asString(json['tenLoai'] ?? json['TenLoai']),
    );
  }

  Map<String, dynamic> toJson() => {'maLoaiXe': maLoaiXe, 'tenLoai': tenLoai};

  @override
  List<Object?> get props => [maLoaiXe, tenLoai];
}

class CarModel extends Equatable {
  final int maXe;
  final String tenXe;
  final double giaBan;
  final int namSanXuat;
  final String mauSac;
  final String soKhung;
  final String soMay;
  final String? dungTich;
  final int soLuongTon;
  final bool trangThai;
  final int maHang;
  final int maLoaiXe;
  final HangXeModel? hangXe;
  final LoaiXeModel? loaiXe;

  const CarModel({
    required this.maXe,
    required this.tenXe,
    required this.giaBan,
    required this.namSanXuat,
    required this.mauSac,
    required this.soKhung,
    required this.soMay,
    this.dungTich,
    required this.soLuongTon,
    required this.trangThai,
    required this.maHang,
    required this.maLoaiXe,
    this.hangXe,
    this.loaiXe,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    final rawHangXe = _asMapOrNull(json['HangXe'] ?? json['hangXe']);
    final rawLoaiXe = _asMapOrNull(json['LoaiXe'] ?? json['loaiXe']);

    return CarModel(
      maXe: _asInt(json['maXe'] ?? json['MaXe'] ?? json['id']),
      tenXe: _asString(json['tenXe'] ?? json['TenXe'] ?? json['name']),
      giaBan: _asDouble(json['giaBan'] ?? json['GiaBan'] ?? json['price']),
      namSanXuat: _asInt(
        json['namSanXuat'] ?? json['NamSanXuat'] ?? json['year'],
      ),
      mauSac: _asString(json['mauSac'] ?? json['MauSac'] ?? json['color']),
      soKhung: _asString(json['soKhung'] ?? json['SoKhung']),
      soMay: _asString(json['soMay'] ?? json['SoMay']),
      dungTich: _asStringOrNull(json['dungTich'] ?? json['DungTich']),
      soLuongTon: _asInt(
        json['soLuongTon'] ?? json['SoLuongTon'] ?? json['stock'],
      ),
      trangThai: _asBool(
        json['trangThai'] ?? json['TrangThai'] ?? json['status'],
      ),
      maHang: _asInt(json['maHang'] ?? json['MaHang']),
      maLoaiXe: _asInt(json['maLoaiXe'] ?? json['MaLoaiXe']),
      hangXe: rawHangXe != null ? HangXeModel.fromJson(rawHangXe) : null,
      loaiXe: rawLoaiXe != null ? LoaiXeModel.fromJson(rawLoaiXe) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tenXe': tenXe,
      'giaBan': giaBan,
      'namSanXuat': namSanXuat,
      'mauSac': mauSac,
      'soKhung': soKhung,
      'soMay': soMay,
      'dungTich': dungTich,
      'soLuongTon': soLuongTon,
      'trangThai': trangThai,
      'maHang': maHang,
      'maLoaiXe': maLoaiXe,
    };
  }

  String get tenHangXe => hangXe?.tenHang ?? 'Mã hãng $maHang';

  String get tenLoaiXe => loaiXe?.tenLoai ?? 'Mã loại $maLoaiXe';

  String get trangThaiText => trangThai ? 'Đang bán' : 'Ngừng bán';

  String get formattedPrice {
    return NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '₫',
      decimalDigits: 0,
    ).format(giaBan);
  }

  String get searchIndex => [
    tenXe,
    tenHangXe,
    tenLoaiXe,
    mauSac,
    soKhung,
    soMay,
    dungTich,
  ].whereType<String>().join(' ').toLowerCase();

  @override
  List<Object?> get props => [
    maXe,
    tenXe,
    giaBan,
    namSanXuat,
    mauSac,
    soKhung,
    soMay,
    dungTich,
    soLuongTon,
    trangThai,
    maHang,
    maLoaiXe,
    hangXe,
    loaiXe,
  ];
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
    return double.tryParse(value) ?? 0.0;
  }
  return 0.0;
}

bool _asBool(dynamic value) {
  if (value is bool) {
    return value;
  }
  if (value is num) {
    return value != 0;
  }
  if (value is String) {
    final normalized = value.toLowerCase().trim();
    if (normalized == 'true' ||
        normalized == 'available' ||
        normalized == '1') {
      return true;
    }
    if (normalized == 'false' || normalized == 'sold' || normalized == '0') {
      return false;
    }
  }
  return true;
}

String _asString(dynamic value) {
  if (value == null) {
    return '';
  }
  return value.toString();
}

String? _asStringOrNull(dynamic value) {
  if (value == null || value.toString().trim().isEmpty) {
    return null;
  }
  return value.toString();
}

Map<String, dynamic>? _asMapOrNull(dynamic value) {
  if (value is Map<String, dynamic>) {
    return value;
  }
  if (value is Map) {
    return Map<String, dynamic>.from(value);
  }
  return null;
}
