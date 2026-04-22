// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';
// Nap thu vien hoac module can thiet.
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Nap thu vien hoac module can thiet.
import '../themes/app_colors.dart';

/// Loading widget with spinner
// Dinh nghia lop LoadingWidget de gom nhom logic lien quan.
class LoadingWidget extends StatelessWidget {
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double size;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color? color;

  // Khai bao bien LoadingWidget de luu du lieu su dung trong xu ly.
  const LoadingWidget({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.key,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.size = 50,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.color,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Tra ve ket qua cho noi goi ham.
    return Center(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: SpinKitFadingCircle(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: color ?? AppColors.primary,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        size: size,
      ),
    );
  }
}

/// Full screen loading overlay
// Dinh nghia lop LoadingOverlay de gom nhom logic lien quan.
class LoadingOverlay extends StatelessWidget {
  // Khai bao bien bool de luu du lieu su dung trong xu ly.
  final bool isLoading;
  // Khai bao bien Widget de luu du lieu su dung trong xu ly.
  final Widget child;

  // Khai bao bien LoadingOverlay de luu du lieu su dung trong xu ly.
  const LoadingOverlay({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.key,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.isLoading,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.child,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Tra ve ket qua cho noi goi ham.
    return Stack(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      children: [
        // Thuc thi cau lenh hien tai theo luong xu ly.
        child,
        // Kiem tra dieu kien de re nhanh xu ly.
        if (isLoading)
          // Goi ham de thuc thi tac vu can thiet.
          Container(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: Colors.black.withValues(alpha: 0.3),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: const LoadingWidget(),
          ),
      ],
    );
  }
}
