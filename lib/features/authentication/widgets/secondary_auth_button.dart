// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';

// Dinh nghia lop SecondaryAuthButton de gom nhom logic lien quan.
class SecondaryAuthButton extends StatelessWidget {
  // Khai bao bien IconData de luu du lieu su dung trong xu ly.
  final IconData icon;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String label;
  // Khai bao bien VoidCallback de luu du lieu su dung trong xu ly.
  final VoidCallback onTap;

  // Khai bao bien SecondaryAuthButton de luu du lieu su dung trong xu ly.
  const SecondaryAuthButton({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.key,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.icon,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.label,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.onTap,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien colorScheme de luu du lieu su dung trong xu ly.
    final colorScheme = Theme.of(context).colorScheme;
    // Khai bao bien onSurface de luu du lieu su dung trong xu ly.
    final onSurface = colorScheme.onSurface;

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
        onTap: onTap,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: borderRadius,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        splashColor: Colors.white.withValues(alpha: 0.14),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        highlightColor: Colors.white.withValues(alpha: 0.06),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: Ink(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          padding: const EdgeInsets.all(12),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          decoration: BoxDecoration(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: colorScheme.surface,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            borderRadius: borderRadius,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            border: Border.all(color: onSurface.withValues(alpha: 0.1)),
          ),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Row(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            mainAxisAlignment: MainAxisAlignment.center,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Goi ham de thuc thi tac vu can thiet.
              Icon(icon, size: 20, color: onSurface.withValues(alpha: 0.82)),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(width: 8),
              // Goi ham de thuc thi tac vu can thiet.
              Flexible(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: Text(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  label,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  overflow: TextOverflow.ellipsis,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: TextStyle(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: onSurface.withValues(alpha: 0.86),
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontSize: 11,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontWeight: FontWeight.w600,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
