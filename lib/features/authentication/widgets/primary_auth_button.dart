// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';

// Dinh nghia lop PrimaryAuthButton de gom nhom logic lien quan.
class PrimaryAuthButton extends StatelessWidget {
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String text;
  // Khai bao bien VoidCallback de luu du lieu su dung trong xu ly.
  final VoidCallback onTap;
  // Khai bao bien bool de luu du lieu su dung trong xu ly.
  final bool isLoading;

  // Khai bao bien PrimaryAuthButton de luu du lieu su dung trong xu ly.
  const PrimaryAuthButton({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.key,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.text,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.onTap,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.isLoading = false,
  });
  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien colorScheme de luu du lieu su dung trong xu ly.
    final colorScheme = Theme.of(context).colorScheme;
    // Khai bao bien isDark de luu du lieu su dung trong xu ly.
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Khai bao bien startColor de luu du lieu su dung trong xu ly.
    final startColor = isDark ? colorScheme.primary : colorScheme.primaryContainer;
    // Khai bao bien endColor de luu du lieu su dung trong xu ly.
    final endColor = isDark
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ? colorScheme.primary.withValues(alpha: 0.82)
        // Thuc thi cau lenh hien tai theo luong xu ly.
        : colorScheme.primary;
    // Khai bao bien foregroundColor de luu du lieu su dung trong xu ly.
    final foregroundColor = isDark
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ? colorScheme.onPrimary
        // Thuc thi cau lenh hien tai theo luong xu ly.
        : colorScheme.onPrimaryContainer;

    // Khai bao bien borderRadius de luu du lieu su dung trong xu ly.
    final borderRadius = BorderRadius.circular(8);
    // Tra ve ket qua cho noi goi ham.
    return Material(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      color: Colors.transparent,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      borderRadius: borderRadius,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      clipBehavior: Clip.antiAlias,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: InkWell(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onTap: isLoading ? null : onTap,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: borderRadius,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: InkWell(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          onTap: isLoading ? null : onTap,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderRadius: borderRadius,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: InkWell(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onTap: isLoading ? null : onTap,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            borderRadius: borderRadius,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Ink(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              width: double.infinity,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              padding: const EdgeInsets.symmetric(vertical: 16),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              decoration: BoxDecoration(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                borderRadius: borderRadius,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                gradient: LinearGradient(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  colors: [startColor, endColor],
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  begin: Alignment.topLeft,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  end: Alignment.bottomRight,
                ),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                boxShadow: [
                  // Goi ham de thuc thi tac vu can thiet.
                  BoxShadow(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: endColor.withValues(alpha: 0.24),
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    blurRadius: 10,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              child: Center(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: isLoading
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    ? SizedBox(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        width: 20,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        height: 20,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        child: CircularProgressIndicator(
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          color: foregroundColor,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          strokeWidth: 2,
                        ),
                      )
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    : Text(
                        // Thuc thi cau lenh hien tai theo luong xu ly.
                        text,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        style: TextStyle(
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          color: foregroundColor,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          fontSize: 14,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          fontWeight: FontWeight.bold,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          letterSpacing: 1.5,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
