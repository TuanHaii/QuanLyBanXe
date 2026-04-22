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
    final style = _NotificationStyle.fromCategory(notification.category);
    final isUnread = !notification.isRead;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: AppConstants.shortDuration,
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
          decoration: BoxDecoration(
            color: const Color(0xFF171A1F),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isUnread
                  ? const Color(0xFFD6A93E).withValues(alpha: 0.65)
                  : Colors.white.withValues(alpha: 0.06),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: style.iconBackground,
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
                              color: Colors.white,
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
                        color: Colors.white.withValues(alpha: 0.63),
                        fontSize: 13,
                        height: 1.28,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      notification.timeLabel,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: Colors.white.withValues(alpha: 0.55),
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
  final Color iconBackground;

  const _NotificationStyle({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
  });

  factory _NotificationStyle.fromCategory(NotificationCategory category) {
    switch (category) {
      case NotificationCategory.transaction:
        return const _NotificationStyle(
          icon: Icons.attach_money_rounded,
          iconColor: Color(0xFF28D37A),
          iconBackground: Color(0xFF143022),
        );
      case NotificationCategory.inventory:
        return const _NotificationStyle(
          icon: Icons.warning_amber_rounded,
          iconColor: Color(0xFFFF6D6D),
          iconBackground: Color(0xFF341F21),
        );
      case NotificationCategory.report:
        return const _NotificationStyle(
          icon: Icons.bar_chart_rounded,
          iconColor: Color(0xFF6AA7FF),
          iconBackground: Color(0xFF1D2A40),
        );
      case NotificationCategory.promotion:
        return const _NotificationStyle(
          icon: Icons.local_offer_outlined,
          iconColor: Color(0xFFD6A93E),
          iconBackground: Color(0xFF2D271A),
        );
      case NotificationCategory.customer:
        return const _NotificationStyle(
          icon: Icons.person_outline_rounded,
          iconColor: Color(0xFFB06EFF),
          iconBackground: Color(0xFF2A2038),
        );
      case NotificationCategory.market:
        return const _NotificationStyle(
          icon: Icons.pie_chart_outline_rounded,
          iconColor: Color(0xFF6AA7FF),
          iconBackground: Color(0xFF1D2A40),
        );
      case NotificationCategory.system:
        return const _NotificationStyle(
          icon: Icons.settings_outlined,
          iconColor: Color(0xFFB6BBC7),
          iconBackground: Color(0xFF272B32),
        );
    }
  }
}
