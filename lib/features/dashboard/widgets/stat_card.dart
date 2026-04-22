// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';

// Nap thu vien hoac module can thiet.
import '../../../shared/themes/app_colors.dart';

// Dinh nghia lop StatCard de gom nhom logic lien quan.
class StatCard extends StatelessWidget {
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String title;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String value;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String trend;
  // Khai bao bien bool de luu du lieu su dung trong xu ly.
  final bool isPositive;
  // Khai bao bien IconData de luu du lieu su dung trong xu ly.
  final IconData icon;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color accentColor;
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double uiScale;
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double textScale;

  // Khai bao bien StatCard de luu du lieu su dung trong xu ly.
  const StatCard({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.key,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.title,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.value,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.trend,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.isPositive,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.icon,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.accentColor,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.uiScale = 1,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.textScale = 1,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien colorScheme de luu du lieu su dung trong xu ly.
    final colorScheme = Theme.of(context).colorScheme;
    // Khai bao bien isDark de luu du lieu su dung trong xu ly.
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Khai bao bien cardBackground de luu du lieu su dung trong xu ly.
    final cardBackground = isDark ? const Color(0xFF1A1C20) : Colors.white;
    // Khai bao bien cardBorder de luu du lieu su dung trong xu ly.
    final cardBorder = isDark
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ? Colors.white.withValues(alpha: 0.05)
        // Thuc thi cau lenh hien tai theo luong xu ly.
        : Colors.black.withValues(alpha: 0.08);
    // Khai bao bien valueColor de luu du lieu su dung trong xu ly.
    final valueColor = colorScheme.onSurface;
    // Khai bao bien titleColor de luu du lieu su dung trong xu ly.
    final titleColor = colorScheme.onSurface.withValues(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      alpha: isDark ? 0.5 : 0.62,
    );

    // Khai bao bien sp de luu du lieu su dung trong xu ly.
    double sp(double value) => value * uiScale;
    // Khai bao bien fs de luu du lieu su dung trong xu ly.
    double fs(double value) => value * textScale;

    // Khai bao bien valueTextStyle de luu du lieu su dung trong xu ly.
    final valueTextStyle = AppTextStyles.displaySmall.copyWith(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      fontSize: fs(20).clamp(20, 24).toDouble(),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      fontWeight: FontWeight.w700,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      color: valueColor,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      height: 1,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      letterSpacing: -0.7,
    );

    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: cardBackground,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(sp(16)),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: Border.all(color: cardBorder, width: 1.1),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        boxShadow: [
          // Goi ham de thuc thi tac vu can thiet.
          BoxShadow(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.08),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            blurRadius: sp(12),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            offset: Offset(0, sp(7)),
          ),
        ],
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: EdgeInsets.fromLTRB(sp(12), sp(11), sp(12), sp(11)),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Column(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        crossAxisAlignment: CrossAxisAlignment.start,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: [
          // Goi ham de thuc thi tac vu can thiet.
          Row(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Goi ham de thuc thi tac vu can thiet.
              Container(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                padding: EdgeInsets.all(sp(7)),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                decoration: BoxDecoration(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: accentColor.withValues(alpha: 0.13),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  borderRadius: BorderRadius.circular(sp(10)),
                ),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: Icon(icon, color: accentColor, size: sp(17.5)),
              ),
              // Goi ham de thuc thi tac vu can thiet.
              Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                trend,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: AppTextStyles.titleSmall.copyWith(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: isPositive
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      ? const Color(0xFF1BC47D)
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      : const Color(0xFFFF6B6B),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontWeight: FontWeight.w700,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontSize: fs(13.5),
                ),
              ),
            ],
          ),
          // Goi ham de thuc thi tac vu can thiet.
          Column(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            crossAxisAlignment: CrossAxisAlignment.start,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Goi ham de thuc thi tac vu can thiet.
              Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                title.toUpperCase(),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: AppTextStyles.labelSmall.copyWith(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontSize: fs(10),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  letterSpacing: 1.05,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontWeight: FontWeight.w600,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: titleColor,
                ),
              ),
              // Goi ham de thuc thi tac vu can thiet.
              SizedBox(height: sp(3)),
              // Goi ham de thuc thi tac vu can thiet.
              SizedBox(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                height: sp(34),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: FittedBox(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fit: BoxFit.scaleDown,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  alignment: Alignment.centerLeft,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
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

// Dinh nghia lop ActionCard de gom nhom logic lien quan.
class ActionCard extends StatelessWidget {
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String title;
  // Khai bao bien IconData de luu du lieu su dung trong xu ly.
  final IconData icon;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color accentColor;
  // Khai bao bien VoidCallback de luu du lieu su dung trong xu ly.
  final VoidCallback onTap;
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double uiScale;
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double textScale;

  // Khai bao bien ActionCard de luu du lieu su dung trong xu ly.
  const ActionCard({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.key,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.title,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.icon,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.accentColor,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.onTap,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.uiScale = 1,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.textScale = 1,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien colorScheme de luu du lieu su dung trong xu ly.
    final colorScheme = Theme.of(context).colorScheme;
    // Khai bao bien isDark de luu du lieu su dung trong xu ly.
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Khai bao bien cardBackground de luu du lieu su dung trong xu ly.
    final cardBackground = isDark ? const Color(0xFF1C2026) : Colors.white;
    // Khai bao bien cardBorder de luu du lieu su dung trong xu ly.
    final cardBorder = Color.lerp(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? Colors.white.withValues(alpha: 0.05)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : Colors.black.withValues(alpha: 0.08),
      // Thuc thi cau lenh hien tai theo luong xu ly.
      accentColor.withValues(alpha: isDark ? 0.36 : 0.24),
      // Thuc thi cau lenh hien tai theo luong xu ly.
      0.35,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    )!;
    // Khai bao bien textColor de luu du lieu su dung trong xu ly.
    final textColor = isDark
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ? Colors.white.withValues(alpha: 0.95)
        // Thuc thi cau lenh hien tai theo luong xu ly.
        : colorScheme.onSurface.withValues(alpha: 0.92);

    // Khai bao bien sp de luu du lieu su dung trong xu ly.
    double sp(double value) => value * uiScale;
    // Khai bao bien fs de luu du lieu su dung trong xu ly.
    double fs(double value) => value * textScale;

    // Tra ve ket qua cho noi goi ham.
    return Material(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      color: cardBackground,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      borderRadius: BorderRadius.circular(sp(15)),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: InkWell(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onTap: onTap,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(sp(15)),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        splashColor: accentColor.withValues(alpha: 0.09),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        highlightColor: accentColor.withValues(alpha: 0.03),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: Container(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          decoration: BoxDecoration(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: cardBackground,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            borderRadius: BorderRadius.circular(sp(15)),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            border: Border.all(color: cardBorder, width: 1),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            boxShadow: [
              // Goi ham de thuc thi tac vu can thiet.
              BoxShadow(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                color: Colors.black.withValues(alpha: isDark ? 0.24 : 0.08),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                blurRadius: sp(12),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                offset: Offset(0, sp(6)),
              ),
            ],
          ),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Column(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            mainAxisAlignment: MainAxisAlignment.center,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Goi ham de thuc thi tac vu can thiet.
              Container(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                padding: EdgeInsets.all(sp(10)),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                decoration: BoxDecoration(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: accentColor.withValues(alpha: isDark ? 0.18 : 0.12),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  borderRadius: BorderRadius.circular(sp(13)),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  border: Border.all(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: accentColor.withValues(alpha: 0.42),
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    width: 1,
                  ),
                ),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: Icon(icon, size: sp(22), color: accentColor),
              ),
              // Goi ham de thuc thi tac vu can thiet.
              SizedBox(height: sp(9)),
              // Goi ham de thuc thi tac vu can thiet.
              Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                title,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: AppTextStyles.labelMedium.copyWith(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: textColor,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontWeight: FontWeight.w800,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  letterSpacing: 0.25,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontSize: fs(11.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
