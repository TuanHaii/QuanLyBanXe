// Nap thu vien hoac module can thiet.
import 'package:equatable/equatable.dart';

// Dinh nghia lop HistoryItemModel de gom nhom logic lien quan.
class HistoryItemModel extends Equatable {
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String id;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String type;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String title;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String subtitle;
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double amount;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String status;
  // Khai bao bien DateTime de luu du lieu su dung trong xu ly.
  final DateTime date;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String? note;

  // Khai bao bien HistoryItemModel de luu du lieu su dung trong xu ly.
  const HistoryItemModel({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.id,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.type,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.title,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.subtitle,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.amount,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.status,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.date,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.note,
  });

  // Thuc thi cau lenh hien tai theo luong xu ly.
  factory HistoryItemModel.fromJson(Map<String, dynamic> json) {
    // Tra ve ket qua cho noi goi ham.
    return HistoryItemModel(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      id: json['id'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      type: json['type'] as String? ?? 'sale',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      title: json['title'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      subtitle: json['subtitle'] as String? ?? '',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      status: json['status'] as String? ?? 'pending',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      date: DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime.now(),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      note: json['note'] as String?,
    );
  }

  // Khai bao bien get de luu du lieu su dung trong xu ly.
  bool get isSuccess => status.toLowerCase() == 'completed';

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien get de luu du lieu su dung trong xu ly.
  List<Object?> get props => [
        // Thuc thi cau lenh hien tai theo luong xu ly.
        id,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        type,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        title,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        subtitle,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        amount,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        status,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        date,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        note,
      ];
}
