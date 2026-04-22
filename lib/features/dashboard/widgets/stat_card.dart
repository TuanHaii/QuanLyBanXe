import 'package:flutter/material.dart';

import '../../../shared/themes/app_colors.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String trend;
  final bool isPositive;
  final IconData icon;
  final Color accentColor;
  final double uiScale;
  final double textScale;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.trend,
    required this.isPositive,
    required this.icon,
    required this.accentColor,
    this.uiScale = 1,
    this.textScale = 1,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBackground = isDark ? const Color(0xFF1A1C20) : Colors.white;
    final cardBorder = isDark
        ? Colors.white.withValues(alpha: 0.05)
        : Colors.black.withValues(alpha: 0.08);
    final valueColor = colorScheme.onSurface;
    final titleColor = colorScheme.onSurface.withValues(
      alpha: isDark ? 0.5 : 0.62,
    );

    double sp(double value) => value * uiScale;
    double fs(double value) => value * textScale;

    final valueTextStyle = AppTextStyles.displaySmall.copyWith(
      fontSize: fs(20).clamp(20, 24).toDouble(),
      fontWeight: FontWeight.w700,
      color: valueColor,
      height: 1,
      letterSpacing: -0.7,
    );

    return Container(
      decoration: BoxDecoration(
        color: cardBackground,
        borderRadius: BorderRadius.circular(sp(16)),
        border: Border.all(color: cardBorder, width: 1.1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.08),
            blurRadius: sp(12),
            offset: Offset(0, sp(7)),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(sp(12), sp(11), sp(12), sp(11)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(sp(7)),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.13),
                  borderRadius: BorderRadius.circular(sp(10)),
                ),
                child: Icon(icon, color: accentColor, size: sp(17.5)),
              ),
              Text(
                trend,
                style: AppTextStyles.titleSmall.copyWith(
                  color: isPositive
                      ? const Color(0xFF1BC47D)
                      : const Color(0xFFFF6B6B),
                  fontWeight: FontWeight.w700,
                  fontSize: fs(13.5),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.toUpperCase(),
                style: AppTextStyles.labelSmall.copyWith(
                  fontSize: fs(10),
                  letterSpacing: 1.05,
                  fontWeight: FontWeight.w600,
                  color: titleColor,
                ),
              ),
              SizedBox(height: sp(3)),
              SizedBox(
                height: sp(34),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(value, style: valueTextStyle),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color accentColor;
  final VoidCallback onTap;
  final double uiScale;
  final double textScale;

  const ActionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.accentColor,
    required this.onTap,
    this.uiScale = 1,
    this.textScale = 1,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBackground = isDark ? const Color(0xFF1A1C20) : Colors.white;
    final cardBorder = isDark
        ? Colors.white.withValues(alpha: 0.05)
        : Colors.black.withValues(alpha: 0.08);
    final textColor = colorScheme.onSurface.withValues(
      alpha: isDark ? 0.76 : 0.8,
    );

    double sp(double value) => value * uiScale;
    double fs(double value) => value * textScale;

    return Material(
      color: cardBackground,
      borderRadius: BorderRadius.circular(sp(15)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(sp(15)),
        splashColor: accentColor.withValues(alpha: 0.09),
        highlightColor: accentColor.withValues(alpha: 0.03),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(sp(15)),
            border: Border.all(color: cardBorder, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(sp(10)),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(sp(13)),
                  border: Border.all(
                    color: accentColor.withValues(alpha: 0.42),
                    width: 1,
                  ),
                ),
                child: Icon(icon, size: sp(22), color: accentColor),
              ),
              SizedBox(height: sp(9)),
              Text(
                title.toUpperCase(),
                style: AppTextStyles.labelMedium.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.7,
                  fontSize: fs(11),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
