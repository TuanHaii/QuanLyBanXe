import 'dart:ui';
import 'package:flutter/material.dart';

class BubbleNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BubbleNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // Cách lề 2 bên 24px, cách đáy 16px tạo độ lơ lửng
        margin: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
        height: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        // Hiệu ứng kính mờ (Glassmorphism)
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              color: const Color(0xFF1C1E24).withValues(alpha: 0.8),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _BubbleNavItem(
                    icon: Icons.dashboard_rounded,
                    label: 'Tổng quan',
                    isSelected: currentIndex == 0,
                    onTap: () => onTap(0),
                  ),
                  _BubbleNavItem(
                    icon: Icons.directions_car_rounded,
                    label: 'Xe',
                    isSelected: currentIndex == 1,
                    onTap: () => onTap(1),
                  ),
                  _BubbleNavItem(
                    icon: Icons.local_offer_rounded,
                    label: 'Bán hàng',
                    isSelected: currentIndex == 2,
                    onTap: () => onTap(2),
                  ),
                  _BubbleNavItem(
                    icon: Icons.person_rounded,
                    label: 'Tài khoản',
                    isSelected: currentIndex == 3,
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

class _BubbleNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _BubbleNavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 20 : 12,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          // Hiển thị màu nền nổi bật khi Item được chọn
          color: isSelected
              ? Colors.blueAccent.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected
                  ? Colors.blueAccent
                  : Colors.white.withValues(alpha: 0.5),
            ),
            // Chữ chỉ hiện ra khi Item đang được active
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w600,
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
