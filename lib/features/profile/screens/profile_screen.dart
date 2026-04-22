import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../authentication/services/auth_service.dart';
import '../../authentication/models/user_model.dart';
import '../../../shared/constants/app_constants.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/services/theme_service.dart';
import '../../../shared/themes/app_colors.dart';
import '../../dashboard/models/dashboard_summary_model.dart';
import '../../dashboard/services/dashboard_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ThemeService _themeService;
  late final AuthService _authService;
  late final DashboardService _dashboardService;
  bool _isApplyingTheme = false;

  UserModel? _user;
  DashboardSummaryModel? _summary;

  _ProfilePalette _palette(BuildContext context) {
    return _ProfilePalette.fromTheme(Theme.of(context));
  }

  bool get _darkModeEnabled => _themeService.darkModeEnabled;

  bool get _followSystemTheme => _themeService.followSystemTheme;

  @override
  void initState() {
    super.initState();
    _themeService = getIt<ThemeService>();
    _authService = getIt<AuthService>();
    _dashboardService = getIt<DashboardService>();
    _themeService.addListener(_handleThemeServiceChanged);
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    setState(() {
      _user = _authService.currentUser;
    });

    try {
      final summary = await _dashboardService.fetchDashboardSummary();
      if (!mounted) return;
      setState(() => _summary = summary);
    } catch (_) {
      // Silently ignore - stats will show fallback values
    }
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
    final palette = _palette(context);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: palette.dialogBackground,
        title: const Text('Đăng xuất'),
        content: const Text('Bạn có chắc muốn đăng xuất khỏi hệ thống?'),
        titleTextStyle: AppTextStyles.titleLarge.copyWith(
          color: palette.textPrimary,
          fontWeight: FontWeight.w700,
        ),
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: palette.textSecondary,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(
              'Hủy',
              style: AppTextStyles.labelLarge.copyWith(
                color: palette.textSecondary,
              ),
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: palette.logoutForeground,
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
    final palette = _palette(context);

    return Scaffold(
      backgroundColor: palette.background,
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [palette.gradientTop, palette.gradientBottom],
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
                      onTap: () => context.push(RouteNames.profileInfo),
                    ),
                    _ProfileActionItem(
                      icon: Icons.shield_outlined,
                      title: 'Bảo Mật',
                      onTap: () => context.push(RouteNames.profileSecurity),
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
                      onTap: () => context.push(RouteNames.profileHistory),
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
                      color: palette.textMuted,
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
    final palette = _palette(context);

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
                  color: palette.accent.withValues(alpha: 0.23),
                  blurRadius: 22,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              (_user?.name ?? 'Người dùng').substring(0, 1).toUpperCase(),
              style: AppTextStyles.headlineMedium.copyWith(
                color: const Color(0xFF17150F),
                fontWeight: FontWeight.w800,
                fontSize: metrics.fs(34),
              ),
            ),
          ),
          SizedBox(height: metrics.px(12)),
          Text(
            _user?.name ?? 'Người dùng',
            style: AppTextStyles.headlineSmall.copyWith(
              color: palette.textPrimary,
              fontWeight: FontWeight.w800,
              fontSize: metrics.fs(32),
              height: 1,
            ),
          ),
          SizedBox(height: metrics.px(4)),
          Text(
            _roleLabel,
            style: AppTextStyles.bodyMedium.copyWith(
              color: palette.textSecondary,
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
              color: palette.surfaceSoft,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: palette.accent.withValues(alpha: 0.28)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star_border_rounded,
                  color: palette.accent,
                  size: metrics.px(14),
                ),
                SizedBox(width: metrics.px(6)),
                Text(
                  'Nhân Viên Xuất Sắc',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: palette.accent,
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

  String get _roleLabel {
    final role = _user?.role?.toLowerCase() ?? '';
    switch (role) {
      case 'admin':
        return 'Quản trị viên';
      case 'manager':
        return 'Giám Đốc Kinh Doanh';
      case 'user':
        return 'Nhân viên';
      default:
        return 'Nhân viên';
    }
  }

  Widget _buildStats(_ProfileMetrics metrics) {
    final stats = [
      _ProfileStatData(
        icon: Icons.attach_money_rounded,
        value: _summary != null ? '${_summary!.carsSold}' : '--',
        label: 'Xe Đã Bán',
      ),
      _ProfileStatData(
        icon: Icons.trending_up_rounded,
        value: _summary?.totalRevenueLabel ?? '--',
        label: 'Doanh Thu',
      ),
      _ProfileStatData(
        icon: Icons.groups_2_outlined,
        value: _summary != null ? '${_summary!.inStock}' : '--',
        label: 'Trong Kho',
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
    final palette = _palette(context);

    return Container(
      padding: EdgeInsets.fromLTRB(
        metrics.px(11),
        metrics.px(10),
        metrics.px(11),
        metrics.px(10),
      ),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(metrics.px(14)),
        border: Border.all(color: palette.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(stat.icon, color: palette.accent, size: metrics.px(15)),
          SizedBox(height: metrics.px(5)),
          Text(
            stat.value,
            style: AppTextStyles.titleLarge.copyWith(
              color: palette.textPrimary,
              fontWeight: FontWeight.w800,
              fontSize: metrics.fs(25),
              height: 1,
            ),
          ),
          SizedBox(height: metrics.px(3)),
          Text(
            stat.label,
            style: AppTextStyles.labelMedium.copyWith(
              color: palette.textMuted,
              fontSize: metrics.fs(11),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String text, _ProfileMetrics metrics) {
    final palette = _palette(context);

    return Text(
      text,
      style: AppTextStyles.labelLarge.copyWith(
        color: palette.textSecondary,
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
    final palette = _palette(context);

    return Container(
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(metrics.px(17)),
        border: Border.all(color: palette.cardBorder),
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
                  color: palette.divider,
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
    final palette = _palette(context);

    return Container(
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(metrics.px(17)),
        border: Border.all(color: palette.cardBorder),
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
            color: palette.divider,
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
    final palette = _palette(context);

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
                    color: palette.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: metrics.fs(15),
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: metrics.px(19),
                color: palette.textMuted,
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
    final palette = _palette(context);

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
                color: palette.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: metrics.fs(15),
              ),
            ),
          ),
          _DualToneSwitch(
            value: value,
            onChanged: _isApplyingTheme ? null : onChanged,
            accentColor: palette.accent,
            tealAccentColor: palette.tealAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildLeadingIcon(IconData icon, _ProfileMetrics metrics) {
    final palette = _palette(context);

    return Container(
      width: metrics.px(30),
      height: metrics.px(30),
      decoration: BoxDecoration(
        color: palette.iconContainer,
        borderRadius: BorderRadius.circular(metrics.px(9)),
      ),
      alignment: Alignment.center,
      child: Icon(icon, color: palette.accent, size: metrics.px(16)),
    );
  }

  Widget _buildLogoutButton(_ProfileMetrics metrics) {
    final palette = _palette(context);

    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: _handleLogout,
        style: FilledButton.styleFrom(
          backgroundColor: palette.logoutBackground,
          foregroundColor: palette.logoutForeground,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: metrics.px(14)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(metrics.px(14)),
            side: BorderSide(color: palette.logoutBorder),
          ),
        ),
        icon: const Icon(Icons.logout_rounded, size: 18),
        label: Text(
          'Đăng Xuất',
          style: AppTextStyles.titleSmall.copyWith(
            color: palette.logoutForeground,
            fontWeight: FontWeight.w700,
            fontSize: metrics.fs(16),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(_ProfileMetrics metrics) {
    final palette = _palette(context);

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
        color: palette.bottomNavBackground,
        border: Border(
          top: BorderSide(color: palette.bottomNavBorder, width: 1),
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
                          ? palette.bottomNavSelectedBackground
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(metrics.px(11)),
                      border: Border.all(
                        color: isSelected
                            ? palette.bottomNavSelectedBorder
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
                              ? palette.accent
                              : palette.navUnselected,
                        ),
                        SizedBox(height: metrics.px(3)),
                        Text(
                          item.label,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: isSelected
                                ? palette.accent
                                : palette.navUnselected,
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final disabledTrackColors = isDark
        ? const [Color(0xFF363942), Color(0xFF2A2C33)]
        : const [Color(0xFFE1E6EE), Color(0xFFD5DCE8)];
    final offTrackColors = isDark
        ? const [Color(0xFF42464E), Color(0xFF2E3138)]
        : const [Color(0xFFDCE2EB), Color(0xFFCAD3E0)];
    final thumbColor = value
        ? (isDark ? const Color(0xFFF5F7FA) : Colors.white)
        : (isDark ? const Color(0xFF9CA3AF) : const Color(0xFF7D8896));

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
                ? disabledTrackColors
                : value
                ? [accentColor, tealAccentColor]
                : offTrackColors,
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
              color: thumbColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.12),
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

class _ProfilePalette {
  final Color background;
  final Color gradientTop;
  final Color gradientBottom;
  final Color surface;
  final Color surfaceSoft;
  final Color accent;
  final Color tealAccent;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color cardBorder;
  final Color divider;
  final Color iconContainer;
  final Color bottomNavBackground;
  final Color bottomNavBorder;
  final Color bottomNavSelectedBackground;
  final Color bottomNavSelectedBorder;
  final Color navUnselected;
  final Color logoutBackground;
  final Color logoutForeground;
  final Color logoutBorder;
  final Color dialogBackground;

  const _ProfilePalette({
    required this.background,
    required this.gradientTop,
    required this.gradientBottom,
    required this.surface,
    required this.surfaceSoft,
    required this.accent,
    required this.tealAccent,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.cardBorder,
    required this.divider,
    required this.iconContainer,
    required this.bottomNavBackground,
    required this.bottomNavBorder,
    required this.bottomNavSelectedBackground,
    required this.bottomNavSelectedBorder,
    required this.navUnselected,
    required this.logoutBackground,
    required this.logoutForeground,
    required this.logoutBorder,
    required this.dialogBackground,
  });

  factory _ProfilePalette.fromTheme(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;

    return _ProfilePalette(
      background: isDark ? const Color(0xFF07080A) : const Color(0xFFF4F7FB),
      gradientTop: isDark ? const Color(0xFF14161A) : const Color(0xFFFBFCFF),
      gradientBottom: isDark
          ? const Color(0xFF060709)
          : const Color(0xFFEEF2F8),
      surface: isDark ? const Color(0xFF16181D) : Colors.white,
      surfaceSoft: isDark ? const Color(0xFF1A1D22) : const Color(0xFFF2F5FA),
      accent: const Color(0xFFD8AD48),
      tealAccent: const Color(0xFF09B7A3),
      textPrimary: onSurface,
      textSecondary: onSurface.withValues(alpha: isDark ? 0.7 : 0.74),
      textMuted: onSurface.withValues(alpha: isDark ? 0.52 : 0.58),
      cardBorder: isDark
          ? Colors.white.withValues(alpha: 0.07)
          : Colors.black.withValues(alpha: 0.08),
      divider: isDark
          ? Colors.white.withValues(alpha: 0.05)
          : Colors.black.withValues(alpha: 0.06),
      iconContainer: isDark
          ? Colors.white.withValues(alpha: 0.03)
          : Colors.black.withValues(alpha: 0.03),
      bottomNavBackground: isDark
          ? const Color(0xFF111317)
          : const Color(0xFFF9FBFF),
      bottomNavBorder: isDark
          ? Colors.white.withValues(alpha: 0.06)
          : Colors.black.withValues(alpha: 0.08),
      bottomNavSelectedBackground: isDark
          ? const Color(0xFF191B1F)
          : const Color(0xFFF5ECD6),
      bottomNavSelectedBorder: const Color(
        0xFFD8AD48,
      ).withValues(alpha: isDark ? 0.78 : 0.56),
      navUnselected: onSurface.withValues(alpha: isDark ? 0.62 : 0.58),
      logoutBackground: isDark
          ? const Color(0xFF32131A)
          : const Color(0xFFFFEEF0),
      logoutForeground: const Color(0xFFF25A65),
      logoutBorder: isDark
          ? const Color(0xFFB6424A).withValues(alpha: 0.44)
          : const Color(0xFFDA7D84).withValues(alpha: 0.44),
      dialogBackground: isDark ? const Color(0xFF1A1D22) : Colors.white,
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
