import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../authentication/services/auth_service.dart';
import '../../../shared/constants/app_constants.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/services/theme_service.dart';
import '../../../shared/themes/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const Color _backgroundColor = Color(0xFF07080A);
  static const Color _surfaceColor = Color(0xFF16181D);
  static const Color _surfaceColorSoft = Color(0xFF1A1D22);
  static const Color _accentColor = Color(0xFFD8AD48);
  static const Color _tealAccentColor = Color(0xFF09B7A3);

  late final ThemeService _themeService;
  bool _isApplyingTheme = false;

  bool get _darkModeEnabled => _themeService.darkModeEnabled;

  bool get _followSystemTheme => _themeService.followSystemTheme;

  @override
  void initState() {
    super.initState();
    _themeService = getIt<ThemeService>();
    _themeService.addListener(_handleThemeServiceChanged);
  }

  @override
  void dispose() {
    _themeService.removeListener(_handleThemeServiceChanged);
    super.dispose();
  }

  void _handleThemeServiceChanged() {
    if (!mounted) {
      return;
    }

    setState(() {});
  }

  void _onDarkModeChanged(bool enabled) {
    _applyDarkMode(enabled);
  }

  Future<void> _applyDarkMode(bool enabled) async {
    if (_isApplyingTheme) {
      return;
    }

    setState(() => _isApplyingTheme = true);
    try {
      await _themeService.setDarkModeEnabled(enabled);
    } finally {
      if (mounted) {
        setState(() => _isApplyingTheme = false);
      }
    }
  }

  void _onFollowSystemThemeChanged(bool enabled) {
    _applyFollowSystemTheme(enabled);
  }

  Future<void> _applyFollowSystemTheme(bool enabled) async {
    if (_isApplyingTheme) {
      return;
    }

    setState(() => _isApplyingTheme = true);
    try {
      await _themeService.setFollowSystemTheme(enabled);
    } finally {
      if (mounted) {
        setState(() => _isApplyingTheme = false);
      }
    }
  }

  void _onBottomTabSelected(int index) {
    switch (index) {
      case 0:
        context.go(RouteNames.dashboard);
        return;
      case 1:
        context.go(RouteNames.mall);
        return;
      case 2:
        context.go(RouteNames.notification);
        return;
      case 3:
        return;
    }
  }

  void _showFeatureComingSoon(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  Future<void> _handleLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1A1D22),
        title: const Text('Đăng xuất'),
        content: const Text('Bạn có chắc muốn đăng xuất khỏi hệ thống?'),
        titleTextStyle: AppTextStyles.titleLarge.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: Colors.white.withValues(alpha: 0.74),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(
              'Hủy',
              style: AppTextStyles.labelLarge.copyWith(
                color: Colors.white.withValues(alpha: 0.82),
              ),
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFD64545),
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Đăng xuất'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final authService = getIt<AuthService>();
      await authService.logout();
      if (mounted) {
        context.go(RouteNames.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final metrics = _ProfileMetrics.fromWidth(MediaQuery.sizeOf(context).width);

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF14161A), Color(0xFF060709)],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              metrics.px(14),
              metrics.px(10),
              metrics.px(14),
              metrics.px(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(metrics),
                SizedBox(height: metrics.px(16)),
                _buildStats(metrics),
                SizedBox(height: metrics.px(18)),
                _buildSectionTitle('TÀI KHOẢN', metrics),
                SizedBox(height: metrics.px(8)),
                _buildActionGroup(
                  metrics: metrics,
                  items: [
                    _ProfileActionItem(
                      icon: Icons.person_outline_rounded,
                      title: 'Thông Tin Cá Nhân',
                      onTap: () => context.go(RouteNames.profileInfo),
                    ),
                    _ProfileActionItem(
                      icon: Icons.shield_outlined,
                      title: 'Bảo Mật',
                      onTap: () => context.go(RouteNames.profileSecurity),
                    ),
                    _ProfileActionItem(
                      icon: Icons.notifications_none_rounded,
                      title: 'Thông Báo',
                      onTap: () => context.go(RouteNames.notification),
                    ),
                  ],
                ),
                SizedBox(height: metrics.px(14)),
                _buildSectionTitle('HIỂN THỊ', metrics),
                SizedBox(height: metrics.px(8)),
                _buildDisplayGroup(metrics),
                SizedBox(height: metrics.px(14)),
                _buildSectionTitle('HOẠT ĐỘNG', metrics),
                SizedBox(height: metrics.px(8)),
                _buildActionGroup(
                  metrics: metrics,
                  items: [
                    _ProfileActionItem(
                      icon: Icons.bar_chart_rounded,
                      title: 'Báo Cáo Của Tôi',
                      onTap: () => _showFeatureComingSoon(
                        'Báo cáo chi tiết đang được hoàn thiện.',
                      ),
                    ),
                    _ProfileActionItem(
                      icon: Icons.history_rounded,
                      title: 'Lịch Sử Giao Dịch',
                      onTap: () => context.go(RouteNames.profileHistory),
                    ),
                    _ProfileActionItem(
                      icon: Icons.track_changes_outlined,
                      title: 'Mục Tiêu Doanh Số',
                      onTap: () => _showFeatureComingSoon(
                        'Mục tiêu doanh số sẽ sớm khả dụng.',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: metrics.px(14)),
                _buildSectionTitle('HỖ TRỢ', metrics),
                SizedBox(height: metrics.px(8)),
                _buildActionGroup(
                  metrics: metrics,
                  items: [
                    _ProfileActionItem(
                      icon: Icons.help_outline_rounded,
                      title: 'Trung Tâm Hỗ Trợ',
                      onTap: () => _showFeatureComingSoon(
                        'Trung tâm hỗ trợ đang được cập nhật.',
                      ),
                    ),
                    _ProfileActionItem(
                      icon: Icons.chat_bubble_outline_rounded,
                      title: 'Liên Hệ Chúng Tôi',
                      onTap: () => _showFeatureComingSoon(
                        'Kênh liên hệ trực tiếp đang được bổ sung.',
                      ),
                    ),
                    _ProfileActionItem(
                      icon: Icons.info_outline_rounded,
                      title: 'Về Ứng Dụng',
                      onTap: () => _showFeatureComingSoon(
                        'Thông tin phiên bản chi tiết sẽ sớm có.',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: metrics.px(16)),
                _buildLogoutButton(metrics),
                SizedBox(height: metrics.px(12)),
                Center(
                  child: Text(
                    'Phiên bản ${AppConstants.appVersion} - Precision Auto',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: Colors.white.withValues(alpha: 0.42),
                      fontSize: metrics.fs(11),
                    ),
                  ),
                ),
                SizedBox(height: metrics.px(14)),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(metrics),
    );
  }

  Widget _buildProfileHeader(_ProfileMetrics metrics) {
    return Center(
      child: Column(
        children: [
          Container(
            width: metrics.px(82),
            height: metrics.px(82),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFE4C15D), Color(0xFFD6A93E)],
              ),
              border: Border.all(
                color: const Color(0xFFFFE4A4).withValues(alpha: 0.26),
              ),
              boxShadow: [
                BoxShadow(
                  color: _accentColor.withValues(alpha: 0.23),
                  blurRadius: 22,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              'A',
              style: AppTextStyles.headlineMedium.copyWith(
                color: const Color(0xFF17150F),
                fontWeight: FontWeight.w800,
                fontSize: metrics.fs(34),
              ),
            ),
          ),
          SizedBox(height: metrics.px(12)),
          Text(
            'Alex Sterling',
            style: AppTextStyles.headlineSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: metrics.fs(32),
              height: 1,
            ),
          ),
          SizedBox(height: metrics.px(4)),
          Text(
            'Giám Đốc Kinh Doanh',
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: metrics.fs(16),
            ),
          ),
          SizedBox(height: metrics.px(9)),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: metrics.px(12),
              vertical: metrics.px(5),
            ),
            decoration: BoxDecoration(
              color: _surfaceColorSoft,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: _accentColor.withValues(alpha: 0.28)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star_border_rounded,
                  color: _accentColor,
                  size: metrics.px(14),
                ),
                SizedBox(width: metrics.px(6)),
                Text(
                  'Nhân Viên Xuất Sắc',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: _accentColor,
                    fontWeight: FontWeight.w700,
                    fontSize: metrics.fs(12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(_ProfileMetrics metrics) {
    const stats = [
      _ProfileStatData(
        icon: Icons.attach_money_rounded,
        value: '124',
        label: 'Xe Đã Bán',
      ),
      _ProfileStatData(
        icon: Icons.trending_up_rounded,
        value: '\$4.2M',
        label: 'Doanh Thu',
      ),
      _ProfileStatData(
        icon: Icons.groups_2_outlined,
        value: '98',
        label: 'Khách Hàng',
      ),
    ];

    return Row(
      children: List.generate(stats.length, (index) {
        final stat = stats[index];

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 0 : metrics.px(4),
              right: index == stats.length - 1 ? 0 : metrics.px(4),
            ),
            child: _buildStatCard(metrics: metrics, stat: stat),
          ),
        );
      }),
    );
  }

  Widget _buildStatCard({
    required _ProfileMetrics metrics,
    required _ProfileStatData stat,
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        metrics.px(11),
        metrics.px(10),
        metrics.px(11),
        metrics.px(10),
      ),
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(metrics.px(14)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(stat.icon, color: _accentColor, size: metrics.px(15)),
          SizedBox(height: metrics.px(5)),
          Text(
            stat.value,
            style: AppTextStyles.titleLarge.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: metrics.fs(25),
              height: 1,
            ),
          ),
          SizedBox(height: metrics.px(3)),
          Text(
            stat.label,
            style: AppTextStyles.labelMedium.copyWith(
              color: Colors.white.withValues(alpha: 0.52),
              fontSize: metrics.fs(11),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String text, _ProfileMetrics metrics) {
    return Text(
      text,
      style: AppTextStyles.labelLarge.copyWith(
        color: Colors.white.withValues(alpha: 0.55),
        letterSpacing: metrics.px(1.05),
        fontWeight: FontWeight.w700,
        fontSize: metrics.fs(13),
      ),
    );
  }

  Widget _buildActionGroup({
    required _ProfileMetrics metrics,
    required List<_ProfileActionItem> items,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(metrics.px(17)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];

          return Column(
            children: [
              _buildActionTile(
                metrics: metrics,
                icon: item.icon,
                title: item.title,
                onTap: item.onTap,
              ),
              if (index != items.length - 1)
                Divider(
                  color: Colors.white.withValues(alpha: 0.05),
                  height: 1,
                  indent: metrics.px(13),
                  endIndent: metrics.px(13),
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildDisplayGroup(_ProfileMetrics metrics) {
    return Container(
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(metrics.px(17)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      child: Column(
        children: [
          _buildSwitchTile(
            metrics: metrics,
            icon: Icons.nights_stay_outlined,
            title: 'Chế Độ Tối',
            value: _darkModeEnabled,
            onChanged: _onDarkModeChanged,
          ),
          Divider(
            color: Colors.white.withValues(alpha: 0.05),
            height: 1,
            indent: metrics.px(13),
            endIndent: metrics.px(13),
          ),
          _buildSwitchTile(
            metrics: metrics,
            icon: Icons.smartphone_outlined,
            title: 'Theo Hệ Thống',
            value: _followSystemTheme,
            onChanged: _onFollowSystemThemeChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required _ProfileMetrics metrics,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(metrics.px(15)),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: metrics.px(12),
            vertical: metrics.px(13),
          ),
          child: Row(
            children: [
              _buildLeadingIcon(icon, metrics),
              SizedBox(width: metrics.px(9)),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.94),
                    fontWeight: FontWeight.w700,
                    fontSize: metrics.fs(15),
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: metrics.px(19),
                color: Colors.white.withValues(alpha: 0.38),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required _ProfileMetrics metrics,
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: metrics.px(12),
        vertical: metrics.px(13),
      ),
      child: Row(
        children: [
          _buildLeadingIcon(icon, metrics),
          SizedBox(width: metrics.px(9)),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.titleSmall.copyWith(
                color: Colors.white.withValues(alpha: 0.94),
                fontWeight: FontWeight.w700,
                fontSize: metrics.fs(15),
              ),
            ),
          ),
          _DualToneSwitch(
            value: value,
            onChanged: _isApplyingTheme ? null : onChanged,
            accentColor: _accentColor,
            tealAccentColor: _tealAccentColor,
          ),
        ],
      ),
    );
  }

  Widget _buildLeadingIcon(IconData icon, _ProfileMetrics metrics) {
    return Container(
      width: metrics.px(30),
      height: metrics.px(30),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(metrics.px(9)),
      ),
      alignment: Alignment.center,
      child: Icon(icon, color: _accentColor, size: metrics.px(16)),
    );
  }

  Widget _buildLogoutButton(_ProfileMetrics metrics) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: _handleLogout,
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFF32131A),
          foregroundColor: const Color(0xFFF25A65),
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: metrics.px(14)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(metrics.px(14)),
            side: BorderSide(
              color: const Color(0xFFB6424A).withValues(alpha: 0.44),
            ),
          ),
        ),
        icon: const Icon(Icons.logout_rounded, size: 18),
        label: Text(
          'Đăng Xuất',
          style: AppTextStyles.titleSmall.copyWith(
            color: const Color(0xFFF25A65),
            fontWeight: FontWeight.w700,
            fontSize: metrics.fs(16),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(_ProfileMetrics metrics) {
    const navItems = [
      _ProfileNavItem(icon: Icons.home_outlined, label: 'Trang Chủ'),
      _ProfileNavItem(icon: Icons.shopping_bag_outlined, label: 'Mall'),
      _ProfileNavItem(
        icon: Icons.notifications_none_rounded,
        label: 'Thông Báo',
      ),
      _ProfileNavItem(icon: Icons.person_outline_rounded, label: 'Tôi'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111317),
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.06),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            metrics.px(8),
            metrics.px(7),
            metrics.px(8),
            metrics.px(6),
          ),
          child: Row(
            children: List.generate(navItems.length, (index) {
              final item = navItems[index];
              const selectedIndex = 3;
              final isSelected = index == selectedIndex;

              return Expanded(
                child: InkWell(
                  onTap: () => _onBottomTabSelected(index),
                  borderRadius: BorderRadius.circular(metrics.px(12)),
                  child: AnimatedContainer(
                    duration: AppConstants.shortDuration,
                    padding: EdgeInsets.symmetric(vertical: metrics.px(8)),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF191B1F)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(metrics.px(11)),
                      border: Border.all(
                        color: isSelected
                            ? _accentColor.withValues(alpha: 0.78)
                            : Colors.transparent,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item.icon,
                          size: metrics.px(19),
                          color: isSelected
                              ? _accentColor
                              : Colors.white.withValues(alpha: 0.68),
                        ),
                        SizedBox(height: metrics.px(3)),
                        Text(
                          item.label,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: isSelected
                                ? _accentColor
                                : Colors.white.withValues(alpha: 0.62),
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            fontSize: metrics.fs(10.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _DualToneSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color accentColor;
  final Color tealAccentColor;

  const _DualToneSwitch({
    required this.value,
    required this.onChanged,
    required this.accentColor,
    required this.tealAccentColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onChanged == null ? null : () => onChanged!(!value),
      child: AnimatedContainer(
        duration: AppConstants.shortDuration,
        width: 44,
        height: 24,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: onChanged == null
                ? [const Color(0xFF363942), const Color(0xFF2A2C33)]
                : value
                ? [accentColor, tealAccentColor]
                : [const Color(0xFF42464E), const Color(0xFF2E3138)],
          ),
        ),
        child: AnimatedAlign(
          duration: AppConstants.shortDuration,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value ? const Color(0xFFF5F7FA) : const Color(0xFF9CA3AF),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileActionItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileActionItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}

class _ProfileStatData {
  final IconData icon;
  final String value;
  final String label;

  const _ProfileStatData({
    required this.icon,
    required this.value,
    required this.label,
  });
}

class _ProfileNavItem {
  final IconData icon;
  final String label;

  const _ProfileNavItem({required this.icon, required this.label});
}

class _ProfileMetrics {
  final double scale;
  final double textScale;

  const _ProfileMetrics._({required this.scale, required this.textScale});

  factory _ProfileMetrics.fromWidth(double width) {
    final rawScale = width / 390;
    return _ProfileMetrics._(
      scale: rawScale.clamp(0.88, 1.14).toDouble(),
      textScale: rawScale.clamp(0.92, 1.09).toDouble(),
    );
  }

  double px(double value) => value * scale;

  double fs(double value) => value * textScale;
}
