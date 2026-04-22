// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';

// Nap thu vien hoac module can thiet.
import '../themes/app_colors.dart';

/// Empty state widget
// Dinh nghia lop EmptyStateWidget de gom nhom logic lien quan.
class EmptyStateWidget extends StatelessWidget {
  // Khai bao bien IconData de luu du lieu su dung trong xu ly.
  final IconData icon;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String title;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String? subtitle;
  // Khai bao bien Widget de luu du lieu su dung trong xu ly.
  final Widget? action;

  // Khai bao bien EmptyStateWidget de luu du lieu su dung trong xu ly.
  const EmptyStateWidget({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.key,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.icon = Icons.inbox_outlined,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.title,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.subtitle,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.action,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Tra ve ket qua cho noi goi ham.
    return Center(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Padding(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        padding: const EdgeInsets.all(32),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: Column(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          mainAxisAlignment: MainAxisAlignment.center,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          children: [
            // Goi ham de thuc thi tac vu can thiet.
            Icon(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              icon,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              size: 80,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: AppColors.disabled,
            ),
            // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
            const SizedBox(height: 16),
            // Goi ham de thuc thi tac vu can thiet.
            Text(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              title,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: AppColors.textSecondary,
                  ),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              textAlign: TextAlign.center,
            ),
            // Kiem tra dieu kien de re nhanh xu ly.
            if (subtitle != null) ...[
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 8),
              // Goi ham de thuc thi tac vu can thiet.
              Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                subtitle!,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      color: AppColors.disabled,
                    ),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                textAlign: TextAlign.center,
              ),
            ],
            // Kiem tra dieu kien de re nhanh xu ly.
            if (action != null) ...[
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 24),
              // Thuc thi cau lenh hien tai theo luong xu ly.
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

/// Error state widget
// Dinh nghia lop ErrorStateWidget de gom nhom logic lien quan.
class ErrorStateWidget extends StatelessWidget {
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String message;
  // Khai bao bien VoidCallback de luu du lieu su dung trong xu ly.
  final VoidCallback? onRetry;

  // Khai bao bien ErrorStateWidget de luu du lieu su dung trong xu ly.
  const ErrorStateWidget({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.key,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.message,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.onRetry,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Tra ve ket qua cho noi goi ham.
    return Center(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Padding(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        padding: const EdgeInsets.all(32),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: Column(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          mainAxisAlignment: MainAxisAlignment.center,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          children: [
            // Khai bao bien Icon de luu du lieu su dung trong xu ly.
            const Icon(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              Icons.error_outline,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              size: 80,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: AppColors.error,
            ),
            // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
            const SizedBox(height: 16),
            // Goi ham de thuc thi tac vu can thiet.
            Text(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              message,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: AppColors.textSecondary,
                  ),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              textAlign: TextAlign.center,
            ),
            // Kiem tra dieu kien de re nhanh xu ly.
            if (onRetry != null) ...[
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 24),
              // Thuc thi cau lenh hien tai theo luong xu ly.
              ElevatedButton.icon(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                onPressed: onRetry,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                icon: const Icon(Icons.refresh),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                label: const Text('Thử lại'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
