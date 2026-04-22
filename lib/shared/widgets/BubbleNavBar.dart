// Nap thu vien hoac module can thiet.
import 'dart:ui';
// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';

// Dinh nghia lop BubbleNavBar de gom nhom logic lien quan.
class BubbleNavBar extends StatelessWidget {
  // Khai bao bien int de luu du lieu su dung trong xu ly.
  final int currentIndex;
  // Khai bao bien Function de luu du lieu su dung trong xu ly.
  final Function(int) onTap;

  // Khai bao bien BubbleNavBar de luu du lieu su dung trong xu ly.
  const BubbleNavBar({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.key,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.currentIndex,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.onTap,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Tra ve ket qua cho noi goi ham.
    return SafeArea(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Container(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        margin: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        height: 65,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        decoration: BoxDecoration(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderRadius: BorderRadius.circular(35),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          boxShadow: [
            // Goi ham de thuc thi tac vu can thiet.
            BoxShadow(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: Colors.black.withValues(alpha: 0.3),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              blurRadius: 20,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              offset: const Offset(0, 10),
            ),
          ],
        ),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: ClipRRect(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderRadius: BorderRadius.circular(35),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: BackdropFilter(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Container(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: const Color(0xFF1C1E24).withValues(alpha: 0.8),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              padding: const EdgeInsets.symmetric(horizontal: 8),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              child: Row(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                children: [
                  // Goi ham de thuc thi tac vu can thiet.
                  _BubbleNavItem(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    icon: Icons.dashboard_rounded,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    label: 'Tổng quan',
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    isSelected: currentIndex == 0,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    onTap: () => onTap(0),
                  ),
                  // Goi ham de thuc thi tac vu can thiet.
                  _BubbleNavItem(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    icon: Icons.directions_car_rounded,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    label: 'Xe',
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    isSelected: currentIndex == 1,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    onTap: () => onTap(1),
                  ),
                  // Goi ham de thuc thi tac vu can thiet.
                  _BubbleNavItem(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    icon: Icons.local_offer_rounded,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    label: 'Bán hàng',
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    isSelected: currentIndex == 2,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    onTap: () => onTap(2),
                  ),
                  // Goi ham de thuc thi tac vu can thiet.
                  _BubbleNavItem(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    icon: Icons.person_rounded,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    label: 'Tài khoản',
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    isSelected: currentIndex == 3,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    onTap: () => onTap(3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Dinh nghia lop _BubbleNavItem de gom nhom logic lien quan.
class _BubbleNavItem extends StatelessWidget {
  // Khai bao bien IconData de luu du lieu su dung trong xu ly.
  final IconData icon;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String label;
  // Khai bao bien bool de luu du lieu su dung trong xu ly.
  final bool isSelected;
  // Khai bao bien VoidCallback de luu du lieu su dung trong xu ly.
  final VoidCallback onTap;

  // Khai bao bien _BubbleNavItem de luu du lieu su dung trong xu ly.
  const _BubbleNavItem({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.icon,
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
    // Tra ve ket qua cho noi goi ham.
    return GestureDetector(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      onTap: onTap,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      behavior: HitTestBehavior.opaque,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: AnimatedContainer(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        duration: const Duration(milliseconds: 300),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        curve: Curves.easeOutCubic,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        padding: EdgeInsets.symmetric(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          horizontal: isSelected ? 20 : 12,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          vertical: 12,
        ),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        decoration: BoxDecoration(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          color: isSelected
              // Thuc thi cau lenh hien tai theo luong xu ly.
              ? Colors.blueAccent.withValues(alpha: 0.15)
              // Thuc thi cau lenh hien tai theo luong xu ly.
              : Colors.transparent,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderRadius: BorderRadius.circular(24),
        ),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: Row(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          mainAxisSize: MainAxisSize.min,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          children: [
            // Goi ham de thuc thi tac vu can thiet.
            Icon(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              icon,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              size: 24,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: isSelected
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  ? Colors.blueAccent
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  : Colors.white.withValues(alpha: 0.5),
            ),
            // Kiem tra dieu kien de re nhanh xu ly.
            if (isSelected) ...[
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(width: 8),
              // Goi ham de thuc thi tac vu can thiet.
              Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                label,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: const TextStyle(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: Colors.blueAccent,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontWeight: FontWeight.w600,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontSize: 13,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
