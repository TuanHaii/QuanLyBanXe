// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';

// Nap thu vien hoac module can thiet.
import '../../../shared/constants/app_constants.dart';

// Dinh nghia lop NotificationFilterChip de gom nhom logic lien quan.
class NotificationFilterChip extends StatelessWidget {
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String label;
  // Khai bao bien bool de luu du lieu su dung trong xu ly.
  final bool isSelected;
  // Khai bao bien VoidCallback de luu du lieu su dung trong xu ly.
  final VoidCallback onTap;

  // Khai bao bien NotificationFilterChip de luu du lieu su dung trong xu ly.
  const NotificationFilterChip({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.key,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.label,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.isSelected,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.onTap,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien isDark de luu du lieu su dung trong xu ly.
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Khai bao bien onSurface de luu du lieu su dung trong xu ly.
    final onSurface = Theme.of(context).colorScheme.onSurface;
    // Khai bao bien accent de luu du lieu su dung trong xu ly.
    const accent = Color(0xFFD6A93E);

    // Khai bao bien backgroundColor de luu du lieu su dung trong xu ly.
    final backgroundColor = isSelected
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ? accent
        // Thuc thi cau lenh hien tai theo luong xu ly.
        : (isDark ? const Color(0xFF1A1D22) : const Color(0xFFF1F4FA));
    // Khai bao bien borderColor de luu du lieu su dung trong xu ly.
    final borderColor = isSelected
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ? accent
        // Thuc thi cau lenh hien tai theo luong xu ly.
        : (isDark
              // Thuc thi cau lenh hien tai theo luong xu ly.
              ? Colors.white.withValues(alpha: 0.08)
              // Thuc thi cau lenh hien tai theo luong xu ly.
              : Colors.black.withValues(alpha: 0.08));
    // Khai bao bien textColor de luu du lieu su dung trong xu ly.
    final textColor = isSelected
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ? (isDark ? const Color(0xFF111111) : const Color(0xFF2D230F))
        // Thuc thi cau lenh hien tai theo luong xu ly.
        : onSurface.withValues(alpha: isDark ? 0.7 : 0.74);

    // Tra ve ket qua cho noi goi ham.
    return Material(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      color: Colors.transparent,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: InkWell(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onTap: onTap,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(999),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: AnimatedContainer(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          duration: AppConstants.shortDuration,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          decoration: BoxDecoration(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: backgroundColor,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            borderRadius: BorderRadius.circular(999),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            border: Border.all(color: borderColor),
          ),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Text(
            // Thuc thi cau lenh hien tai theo luong xu ly.
            label,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            style: TextStyle(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: textColor,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
