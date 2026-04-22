// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';

// Dinh nghia lop AuthHeader de gom nhom logic lien quan.
class AuthHeader extends StatelessWidget {
  // Khai bao bien AuthHeader de luu du lieu su dung trong xu ly.
  const AuthHeader({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.key});
  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context){
    // Khai bao bien colorScheme de luu du lieu su dung trong xu ly.
    final colorScheme = Theme.of(context).colorScheme;
    // Khai bao bien onSurface de luu du lieu su dung trong xu ly.
    final onSurface = colorScheme.onSurface;

    // Tra ve ket qua cho noi goi ham.
    return Column(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      children: [
        // icon logo boc trong hinh vuong bo goc
        // Goi ham de thuc thi tac vu can thiet.
        Container(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          padding: const EdgeInsets.all(16),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          decoration: BoxDecoration(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: colorScheme.primaryContainer,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            borderRadius: BorderRadius.circular(22),
          ),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Icon(
            // Thuc thi cau lenh hien tai theo luong xu ly.
            Icons.precision_manufacturing_outlined,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            size: 40,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: colorScheme.onPrimaryContainer,
          ),
        ),
        // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
        const SizedBox(height: 24),
        
        // Goi ham de thuc thi tac vu can thiet.
        Text(
          // Thuc thi cau lenh hien tai theo luong xu ly.
          'P R E C I S I O N',
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          style: TextStyle(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            fontSize: 28,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            fontWeight: FontWeight.w800,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: onSurface,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            letterSpacing: 6.0, // Tăng khoảng cách giữa các chữ cái
          ),
        ), 
        // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
        const SizedBox(height: 8),
        // slogan
        // Goi ham de thuc thi tac vu can thiet.
        Text(
          // Thuc thi cau lenh hien tai theo luong xu ly.
          'AUTOMOTIVE INTELLIGENCE',
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          style: TextStyle(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            fontSize: 14,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            fontWeight: FontWeight.w500,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: onSurface.withValues(alpha:0.7),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            letterSpacing: 2.0, // Tăng khoảng cách giữa các chữ cái
          ),
        )
    ],);
  }
}
