// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';

// Dinh nghia lop DashboardCard de gom nhom logic lien quan.
class DashboardCard extends StatelessWidget {
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String title;
  // Khai bao bien IconData de luu du lieu su dung trong xu ly.
  final IconData icon;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color color;
  // Khai bao bien VoidCallback de luu du lieu su dung trong xu ly.
  final VoidCallback onTap;

  // Khai bao bien DashboardCard de luu du lieu su dung trong xu ly.
  const DashboardCard({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.key,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.title,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.icon,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.color,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.onTap,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Tra ve ket qua cho noi goi ham.
    return Card(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      elevation: 2,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: InkWell(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onTap: onTap,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(12),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: Container(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          padding: const EdgeInsets.all(16),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Column(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            mainAxisAlignment: MainAxisAlignment.center,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Goi ham de thuc thi tac vu can thiet.
              Container(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                padding: const EdgeInsets.all(12),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                decoration: BoxDecoration(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: color.withValues(alpha: 0.1),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  borderRadius: BorderRadius.circular(12),
                ),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: Icon(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  icon,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  size: 32,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: color,
                ),
              ),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 12),
              // Goi ham de thuc thi tac vu can thiet.
              Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                title,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      fontWeight: FontWeight.w600,
                    ),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
