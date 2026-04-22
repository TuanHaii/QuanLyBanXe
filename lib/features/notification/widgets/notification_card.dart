import 'package:flutter/material.dart';

import '../../../shared/constants/app_constants.dart';
import '../../../shared/themes/app_colors.dart';
import '../models/notification_item_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final style = _NotificationStyle.fromCategory(notification.category);
    final isUnread = !notification.isRead;

    final cardBackground = isDark ? const Color(0xFF171A1F) : Colors.white;
    final unreadBorder = const Color(
      0xFFD6A93E,
    ).withValues(alpha: isDark ? 0.65 : 0.58);
    final defaultBorder = isDark
        ? Colors.white.withValues(alpha: 0.06)
        : Colors.black.withValues(alpha: 0.08);
    final titleColor = onSurface;
    final messageColor = onSurface.withValues(alpha: isDark ? 0.63 : 0.7);
    final timeColor = onSurface.withValues(alpha: isDark ? 0.55 : 0.6);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: AppConstants.shortDuration,
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
          decoration: BoxDecoration(
            color: cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isUnread ? unreadBorder : defaultBorder),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: style.iconBackground(isDark),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(style.icon, color: style.iconColor, size: 20),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.titleMedium.copyWith(
                              color: titleColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 17,
                              height: 1,
                            ),
                          ),
                        ),
                        if (isUnread)
                          Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD6A93E),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.message,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: messageColor,
                        fontSize: 13,
                        height: 1.28,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      notification.timeLabel,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: timeColor,
                        fontWeight: FontWeight.w500,
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

class _NotificationStyle {
  final IconData icon;
  final Color iconColor;
  final Color _darkBackground;
  final Color _lightBackground;

  const _NotificationStyle({
    required this.icon,
    required this.iconColor,
    required Color darkBackground,
    required Color lightBackground,
  }) : _darkBackground = darkBackground,
       _lightBackground = lightBackground;

  Color iconBackground(bool isDark) {
    return isDark ? _darkBackground : _lightBackground;
  }

  factory _NotificationStyle.fromCategory(NotificationCategory category) {
    switch (category) {
      case NotificationCategory.transaction:
        return const _NotificationStyle(
          icon: Icons.attach_money_rounded,
          iconColor: Color(0xFF28D37A),
          darkBackground: Color(0xFF143022),
          lightBackground: Color(0xFFE4F7ED),
        );
      case NotificationCategory.inventory:
        return const _NotificationStyle(
          icon: Icons.warning_amber_rounded,
          iconColor: Color(0xFFFF6D6D),
          darkBackground: Color(0xFF341F21),
          lightBackground: Color(0xFFFFE7E9),
        );
      case NotificationCategory.report:
        return const _NotificationStyle(
          icon: Icons.bar_chart_rounded,
          iconColor: Color(0xFF6AA7FF),
          darkBackground: Color(0xFF1D2A40),
          lightBackground: Color(0xFFE9F1FF),
        );
      case NotificationCategory.promotion:
        return const _NotificationStyle(
          icon: Icons.local_offer_outlined,
          iconColor: Color(0xFFD6A93E),
          darkBackground: Color(0xFF2D271A),
          lightBackground: Color(0xFFFBF1DD),
        );
      case NotificationCategory.customer:
        return const _NotificationStyle(
          icon: Icons.person_outline_rounded,
          iconColor: Color(0xFFB06EFF),
          darkBackground: Color(0xFF2A2038),
          lightBackground: Color(0xFFF0E6FD),
        );
      case NotificationCategory.market:
        return const _NotificationStyle(
          icon: Icons.pie_chart_outline_rounded,
          iconColor: Color(0xFF6AA7FF),
          darkBackground: Color(0xFF1D2A40),
          lightBackground: Color(0xFFE9F1FF),
        );
      case NotificationCategory.system:
        return const _NotificationStyle(
          icon: Icons.settings_outlined,
          iconColor: Color(0xFFB6BBC7),
          darkBackground: Color(0xFF272B32),
          lightBackground: Color(0xFFF0F3F8),
        );
    }
  }
}
