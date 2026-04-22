// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';

// Nap thu vien hoac module can thiet.
import '../../../shared/constants/app_constants.dart';
// Nap thu vien hoac module can thiet.
import '../../../shared/themes/app_colors.dart';
// Nap thu vien hoac module can thiet.
import '../models/notification_item_model.dart';

// Dinh nghia lop NotificationCard de gom nhom logic lien quan.
class NotificationCard extends StatelessWidget {
  // Khai bao bien NotificationItem de luu du lieu su dung trong xu ly.
  final NotificationItem notification;
  // Khai bao bien VoidCallback de luu du lieu su dung trong xu ly.
  final VoidCallback onTap;

  // Khai bao bien NotificationCard de luu du lieu su dung trong xu ly.
  const NotificationCard({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.key,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.notification,
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
    // Khai bao bien style de luu du lieu su dung trong xu ly.
    final style = _NotificationStyle.fromCategory(notification.category);
    // Khai bao bien isUnread de luu du lieu su dung trong xu ly.
    final isUnread = !notification.isRead;

    // Khai bao bien cardBackground de luu du lieu su dung trong xu ly.
    final cardBackground = isDark ? const Color(0xFF171A1F) : Colors.white;
    // Khai bao bien unreadBorder de luu du lieu su dung trong xu ly.
    final unreadBorder = const Color(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      0xFFD6A93E,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    ).withValues(alpha: isDark ? 0.65 : 0.58);
    // Khai bao bien defaultBorder de luu du lieu su dung trong xu ly.
    final defaultBorder = isDark
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ? Colors.white.withValues(alpha: 0.06)
        // Thuc thi cau lenh hien tai theo luong xu ly.
        : Colors.black.withValues(alpha: 0.08);
    // Khai bao bien titleColor de luu du lieu su dung trong xu ly.
    final titleColor = onSurface;
    // Khai bao bien messageColor de luu du lieu su dung trong xu ly.
    final messageColor = onSurface.withValues(alpha: isDark ? 0.63 : 0.7);
    // Khai bao bien timeColor de luu du lieu su dung trong xu ly.
    final timeColor = onSurface.withValues(alpha: isDark ? 0.55 : 0.6);

    // Tra ve ket qua cho noi goi ham.
    return Material(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      color: Colors.transparent,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: InkWell(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onTap: onTap,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(16),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: AnimatedContainer(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          duration: AppConstants.shortDuration,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          decoration: BoxDecoration(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: cardBackground,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            borderRadius: BorderRadius.circular(16),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            border: Border.all(color: isUnread ? unreadBorder : defaultBorder),
          ),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Row(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            crossAxisAlignment: CrossAxisAlignment.start,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Goi ham de thuc thi tac vu can thiet.
              Container(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                width: 38,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                height: 38,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                decoration: BoxDecoration(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: style.iconBackground(isDark),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  borderRadius: BorderRadius.circular(11),
                ),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: Icon(style.icon, color: style.iconColor, size: 20),
              ),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(width: 11),
              // Goi ham de thuc thi tac vu can thiet.
              Expanded(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: Column(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  children: [
                    // Goi ham de thuc thi tac vu can thiet.
                    Row(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      children: [
                        // Goi ham de thuc thi tac vu can thiet.
                        Expanded(
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          child: Text(
                            // Thuc thi cau lenh hien tai theo luong xu ly.
                            notification.title,
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            maxLines: 1,
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            overflow: TextOverflow.ellipsis,
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            style: AppTextStyles.titleMedium.copyWith(
                              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                              color: titleColor,
                              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                              fontWeight: FontWeight.w800,
                              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                              fontSize: 17,
                              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                              height: 1,
                            ),
                          ),
                        ),
                        // Kiem tra dieu kien de re nhanh xu ly.
                        if (isUnread)
                          // Goi ham de thuc thi tac vu can thiet.
                          Container(
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            width: 7,
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            height: 7,
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            decoration: const BoxDecoration(
                              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                              color: Color(0xFFD6A93E),
                              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                    const SizedBox(height: 4),
                    // Goi ham de thuc thi tac vu can thiet.
                    Text(
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      notification.message,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      maxLines: 2,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      overflow: TextOverflow.ellipsis,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      style: AppTextStyles.bodySmall.copyWith(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        color: messageColor,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        fontSize: 13,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        height: 1.28,
                      ),
                    ),
                    // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                    const SizedBox(height: 7),
                    // Goi ham de thuc thi tac vu can thiet.
                    Text(
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      notification.timeLabel,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      style: AppTextStyles.labelSmall.copyWith(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        color: timeColor,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        fontWeight: FontWeight.w500,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dinh nghia lop _NotificationStyle de gom nhom logic lien quan.
class _NotificationStyle {
  // Khai bao bien IconData de luu du lieu su dung trong xu ly.
  final IconData icon;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color iconColor;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color _darkBackground;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color _lightBackground;

  // Khai bao bien _NotificationStyle de luu du lieu su dung trong xu ly.
  const _NotificationStyle({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.icon,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.iconColor,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required Color darkBackground,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required Color lightBackground,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) : _darkBackground = darkBackground,
       // Gan gia tri cho bien _lightBackground.
       _lightBackground = lightBackground;

  // Khai bao bien iconBackground de luu du lieu su dung trong xu ly.
  Color iconBackground(bool isDark) {
    // Tra ve ket qua cho noi goi ham.
    return isDark ? _darkBackground : _lightBackground;
  }

  // Thuc thi cau lenh hien tai theo luong xu ly.
  factory _NotificationStyle.fromCategory(NotificationCategory category) {
    // Bat dau re nhanh theo nhieu truong hop gia tri.
    switch (category) {
      // Xu ly mot truong hop cu the trong switch.
      case NotificationCategory.transaction:
        // Tra ve ket qua cho noi goi ham.
        return const _NotificationStyle(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          icon: Icons.attach_money_rounded,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          iconColor: Color(0xFF28D37A),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          darkBackground: Color(0xFF143022),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          lightBackground: Color(0xFFE4F7ED),
        );
      // Xu ly mot truong hop cu the trong switch.
      case NotificationCategory.inventory:
        // Tra ve ket qua cho noi goi ham.
        return const _NotificationStyle(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          icon: Icons.warning_amber_rounded,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          iconColor: Color(0xFFFF6D6D),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          darkBackground: Color(0xFF341F21),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          lightBackground: Color(0xFFFFE7E9),
        );
      // Xu ly mot truong hop cu the trong switch.
      case NotificationCategory.report:
        // Tra ve ket qua cho noi goi ham.
        return const _NotificationStyle(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          icon: Icons.bar_chart_rounded,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          iconColor: Color(0xFF6AA7FF),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          darkBackground: Color(0xFF1D2A40),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          lightBackground: Color(0xFFE9F1FF),
        );
      // Xu ly mot truong hop cu the trong switch.
      case NotificationCategory.promotion:
        // Tra ve ket qua cho noi goi ham.
        return const _NotificationStyle(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          icon: Icons.local_offer_outlined,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          iconColor: Color(0xFFD6A93E),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          darkBackground: Color(0xFF2D271A),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          lightBackground: Color(0xFFFBF1DD),
        );
      // Xu ly mot truong hop cu the trong switch.
      case NotificationCategory.customer:
        // Tra ve ket qua cho noi goi ham.
        return const _NotificationStyle(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          icon: Icons.person_outline_rounded,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          iconColor: Color(0xFFB06EFF),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          darkBackground: Color(0xFF2A2038),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          lightBackground: Color(0xFFF0E6FD),
        );
      // Xu ly mot truong hop cu the trong switch.
      case NotificationCategory.market:
        // Tra ve ket qua cho noi goi ham.
        return const _NotificationStyle(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          icon: Icons.pie_chart_outline_rounded,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          iconColor: Color(0xFF6AA7FF),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          darkBackground: Color(0xFF1D2A40),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          lightBackground: Color(0xFFE9F1FF),
        );
      // Xu ly mot truong hop cu the trong switch.
      case NotificationCategory.system:
        // Tra ve ket qua cho noi goi ham.
        return const _NotificationStyle(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          icon: Icons.settings_outlined,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          iconColor: Color(0xFFB6BBC7),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          darkBackground: Color(0xFF272B32),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          lightBackground: Color(0xFFF0F3F8),
        );
    }
  }
}
