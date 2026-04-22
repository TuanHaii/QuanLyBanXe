// Nap thu vien hoac module can thiet.
import 'package:equatable/equatable.dart';

// Dinh nghia lop UserModel de gom nhom logic lien quan.
class UserModel extends Equatable {
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String id;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String name;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String email;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String? phone;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String? avatar;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String? role;
  // Khai bao bien DateTime de luu du lieu su dung trong xu ly.
  final DateTime? createdAt;
  // Khai bao bien DateTime de luu du lieu su dung trong xu ly.
  final DateTime? updatedAt;

  // Khai bao bien UserModel de luu du lieu su dung trong xu ly.
  const UserModel({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.id,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.name,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.email,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.phone,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.avatar,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.role,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.createdAt,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.updatedAt,
  });

  // Thuc thi cau lenh hien tai theo luong xu ly.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Tra ve ket qua cho noi goi ham.
    return UserModel(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      id: json['id'] as String,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      name: json['name'] as String,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      email: json['email'] as String,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      phone: json['phone'] as String?,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      avatar: json['avatar'] as String?,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      role: json['role'] as String?,
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
      'email': email,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'phone': phone,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'avatar': avatar,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'role': role,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'created_at': createdAt?.toIso8601String(),
      // Thuc thi cau lenh hien tai theo luong xu ly.
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  // Thuc thi cau lenh hien tai theo luong xu ly.
  UserModel copyWith({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? id,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? name,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? email,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? phone,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? avatar,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    String? role,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    DateTime? createdAt,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    DateTime? updatedAt,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) {
    // Tra ve ket qua cho noi goi ham.
    return UserModel(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      id: id ?? this.id,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      name: name ?? this.name,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      email: email ?? this.email,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      phone: phone ?? this.phone,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      avatar: avatar ?? this.avatar,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      role: role ?? this.role,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      createdAt: createdAt ?? this.createdAt,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien get de luu du lieu su dung trong xu ly.
  List<Object?> get props => [id, name, email, phone, avatar, role];
}
