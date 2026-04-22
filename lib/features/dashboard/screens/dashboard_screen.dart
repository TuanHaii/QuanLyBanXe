import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/constants/app_constants.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/themes/app_colors.dart';
import '../../authentication/services/auth_service.dart';
import '../models/dashboard_summary_model.dart';
import '../services/dashboard_service.dart';
import '../widgets/stat_card.dart';
import '../widgets/quick_action_sheets.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final DashboardService _dashboardService = getIt<DashboardService>();
  final AuthService _authService = getIt<AuthService>();

  DashboardSummaryModel? _summary;
  bool _isLoading = true;
  String? _errorMessage;

  _DashboardPalette _palette(BuildContext context) {
    return _DashboardPalette.fromTheme(Theme.of(context));
  }

  @override
  void initState() {
    super.initState();
    _loadDashboard();
  }

  Future<void> _loadDashboard() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final summary = await _dashboardService.fetchDashboardSummary();
      if (!mounted) return;
      setState(() {
        _summary = summary;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Không thể tải dữ liệu. Vui lòng thử lại.';
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String get _userName {
    return _authService.currentUser?.name ?? 'Người dùng';
  }

  @override
  Widget build(BuildContext context) {
    final metrics = _DashboardMetrics.fromWidth(
      MediaQuery.sizeOf(context).width,
    );
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
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                    metrics.px(14),
                    metrics.px(8),
                    metrics.px(14),
                    metrics.px(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTopBar(metrics),
                      SizedBox(height: metrics.px(12)),
                      _buildHeroBanner(metrics),
                      SizedBox(height: metrics.px(12)),
                      _buildStatsGrid(metrics),
                      SizedBox(height: metrics.px(16)),
                      _buildSectionTitle('• Hành Động Nhanh', metrics),
                      SizedBox(height: metrics.px(10)),
                      _buildQuickActionsGrid(metrics),
                      SizedBox(height: metrics.px(14)),
                      _buildSectionTitle('• Giao Dịch Gần Đây', metrics),
                      SizedBox(height: metrics.px(10)),
                      _buildRecentTransactions(metrics),
                      SizedBox(height: metrics.px(8)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(metrics),
    );
  }

  Widget _buildTopBar(_DashboardMetrics metrics) {
    final palette = _palette(context);

    return SizedBox(
      height: metrics.px(34),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            'PRECISION',
            style: AppTextStyles.titleLarge.copyWith(
              color: palette.accent,
              fontWeight: FontWeight.w700,
              letterSpacing: metrics.px(2.5),
              fontSize: metrics.fs(21.5),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTopBarButton(
                  metrics: metrics,
                  icon: Icons.notifications_none_rounded,
                  onTap: () => context.go(RouteNames.notification),
                ),
                SizedBox(width: metrics.px(6)),
                _buildTopBarButton(
                  metrics: metrics,
                  icon: Icons.person_outline_rounded,
                  onTap: () => context.go(RouteNames.profile),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBarButton({
    required _DashboardMetrics metrics,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final palette = _palette(context);

    return Material(
      color: Colors.transparent,
      child: InkResponse(
        onTap: onTap,
        radius: metrics.px(20),
        highlightShape: BoxShape.circle,
        splashColor: palette.topBarSplash,
        child: SizedBox(
          width: metrics.px(30),
          height: metrics.px(30),
          child: Icon(icon, color: palette.topBarIcon, size: metrics.px(20)),
        ),
      ),
    );
  }

  Widget _buildHeroBanner(_DashboardMetrics metrics) {
    final palette = _palette(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(metrics.px(18)),
      child: SizedBox(
        height: metrics.heroHeight,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/images/MustangBg.webp', fit: BoxFit.cover),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.22),
                    Colors.black.withValues(alpha: 0.5),
                    Colors.black.withValues(alpha: 0.87),
                  ],
                  stops: const [0.0, 0.58, 1.0],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                metrics.px(15),
                metrics.px(14),
                metrics.px(15),
                metrics.px(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TỔNG QUAN HOẠT ĐỘNG',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: palette.accent,
                      fontWeight: FontWeight.w700,
                      fontSize: metrics.fs(10),
                      letterSpacing: metrics.px(1.6),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Xin chào,\n$_userName',
                    style: AppTextStyles.displayMedium.copyWith(
                      fontSize: metrics.fs(40),
                      height: 0.93,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: metrics.px(7)),
                  Text(
                    _summary != null
                        ? 'Doanh thu ${_summary!.totalRevenueLabel}, ${_summary!.revenueTrend} so với tuần trước.'
                        : 'Đang tải dữ liệu...',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: metrics.fs(11.2),
                      height: 1.3,
                      color: Colors.white.withValues(alpha: 0.78),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, _DashboardMetrics metrics) {
    final palette = _palette(context);

    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: AppTextStyles.headlineMedium.copyWith(
          fontSize: metrics.fs(14),
          fontWeight: FontWeight.w700,
          color: palette.sectionTitle,
          letterSpacing: metrics.px(-0.25),
          height: 1,
        ),
      ),
    );
  }

  List<_DashboardStat> get _statsFromSummary {
    final s = _summary;
    if (s == null) {
      return [];
    }

    final stockTrend = s.inStock < s.totalCars
        ? '-${((1 - s.inStock / s.totalCars) * 100).toStringAsFixed(1)}%'
        : '0%';

    return [
      _DashboardStat(
        title: 'Tổng xe',
        value: _formatNumber(s.totalCars),
        trend: '+4%',
        isPositive: true,
        icon: Icons.directions_car_filled_outlined,
        accentColor: const Color(0xFF4792FF),
      ),
      _DashboardStat(
        title: 'Xe đã bán',
        value: _formatNumber(s.carsSold),
        trend: s.salesTrend,
        isPositive: !s.salesTrend.startsWith('-'),
        icon: Icons.sell_outlined,
        accentColor: const Color(0xFFE0B54E),
      ),
      _DashboardStat(
        title: 'Trong kho',
        value: _formatNumber(s.inStock),
        trend: stockTrend,
        isPositive: false,
        icon: Icons.inventory_2_outlined,
        accentColor: const Color(0xFFFF6B6B),
      ),
      _DashboardStat(
        title: 'Tổng doanh thu',
        value: s.totalRevenueLabel,
        trend: s.revenueTrend,
        isPositive: !s.revenueTrend.startsWith('-'),
        icon: Icons.bar_chart_rounded,
        accentColor: const Color(0xFF1BC47D),
      ),
    ];
  }

  String _formatNumber(int n) {
    if (n >= 1000) {
      return '${(n / 1000).toStringAsFixed(n % 1000 == 0 ? 0 : 1)}K';
    }
    return n.toString();
  }

  Widget _buildStatsGrid(_DashboardMetrics metrics) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          children: [
            Text(_errorMessage!, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _loadDashboard,
              child: const Text('Thử lại'),
            ),
          ],
        ),
      );
    }

    final stats = _statsFromSummary;
    if (stats.isEmpty) {
      return const Center(child: Text('Không có dữ liệu'));
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stats.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: metrics.gridSpacing,
        crossAxisSpacing: metrics.gridSpacing,
        childAspectRatio: metrics.statsAspectRatio,
      ),
      itemBuilder: (context, index) {
        final stat = stats[index];
        return StatCard(
          title: stat.title,
          value: stat.value,
          trend: stat.trend,
          isPositive: stat.isPositive,
          icon: stat.icon,
          accentColor: stat.accentColor,
          uiScale: metrics.scale,
          textScale: metrics.fontScale,
        );
      },
    );
  }

  Widget _buildQuickActionsGrid(_DashboardMetrics metrics) {
    final actions = [
      _QuickActionItem(
        title: 'Thêm xe mới',
        icon: Icons.add_circle_outline_rounded,
        accentColor: const Color(0xFF2FA58A),
        onTap: _openAddCarFlow,
      ),
      _QuickActionItem(
        title: 'Kho hàng',
        icon: Icons.inventory_2_outlined,
        accentColor: const Color(0xFF4E83F5),
        onTap: _openCarList,
      ),
      _QuickActionItem(
        title: 'Giao dịch',
        icon: Icons.receipt_long_rounded,
        accentColor: const Color(0xFFE0A442),
        onTap: _openSalesList,
      ),
      _QuickActionItem(
        title: 'Báo cáo',
        icon: Icons.pie_chart_outline_rounded,
        accentColor: const Color(0xFF5F86D9),
        onTap: _openReportSheet,
      ),
      _QuickActionItem(
        title: 'Hỗ trợ',
        icon: Icons.support_agent_rounded,
        accentColor: const Color(0xFFE57E6D),
        onTap: _openSupportSheet,
      ),
      _QuickActionItem(
        title: 'Thông báo',
        icon: Icons.notifications_none_rounded,
        accentColor: const Color(0xFF6E90A9),
        onTap: _openNotifications,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: actions.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: metrics.gridSpacing,
        crossAxisSpacing: metrics.gridSpacing,
        childAspectRatio: metrics.actionsAspectRatio,
      ),
      itemBuilder: (context, index) {
        final action = actions[index];
        return ActionCard(
          title: action.title,
          icon: action.icon,
          accentColor: action.accentColor,
          onTap: action.onTap,
          uiScale: metrics.scale,
          textScale: metrics.fontScale,
        );
      },
    );
  }

  Future<void> _openAddCarFlow() async {
    context.go(RouteNames.carList);
  }

  Future<T?> _showQuickActionSheet<T>({
    required WidgetBuilder builder,
    bool isScrollControlled = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.72),
      builder: builder,
    );
  }

  Future<void> _openCarList() async {
    await _showQuickActionSheet<void>(
      builder: (sheetContext) => const InventoryQuickActionSheet(),
    );
  }

  Future<void> _openSalesList() async {
    await _showQuickActionSheet<void>(
      builder: (sheetContext) => const SalesQuickActionSheet(),
    );
  }

  Future<void> _openReportSheet() async {
    await _showQuickActionSheet<void>(
      builder: (sheetContext) => const ReportQuickActionSheet(),
    );
  }

  Future<void> _openSupportSheet() async {
    final user = _authService.currentUser;

    final submitted = await _showQuickActionSheet<bool>(
      builder: (sheetContext) => SupportQuickActionSheet(
        initialName: user?.name ?? '',
        initialEmail: user?.email ?? '',
      ),
    );

    if (submitted == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Yêu cầu hỗ trợ đã được gửi.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _openNotifications() {
    context.go(RouteNames.notification);
  }

  Widget _buildRecentTransactions(_DashboardMetrics metrics) {
    final recentTx = _summary?.recentTransactions ?? [];

    if (recentTx.isEmpty) {
      return Center(
        child: Text(
          'Chưa có giao dịch nào.',
          style: AppTextStyles.bodySmall.copyWith(
            color: _palette(context).textSecondary,
          ),
        ),
      );
    }

    final transactions = recentTx
        .map(
          (tx) => _RecentTransaction(
            customerName: tx.customerName,
            carName: tx.carName,
            amount: tx.amount,
            timeAgo: tx.timeAgo,
          ),
        )
        .toList();

    return Column(
      children: transactions
          .map(
            (transaction) => _buildRecentTransactionItem(transaction, metrics),
          )
          .toList(),
    );
  }

  Widget _buildRecentTransactionItem(
    _RecentTransaction transaction,
    _DashboardMetrics metrics,
  ) {
    final palette = _palette(context);
    final initials = transaction.customerName.substring(0, 1).toUpperCase();

    return Container(
      margin: EdgeInsets.only(bottom: metrics.px(8)),
      padding: EdgeInsets.fromLTRB(
        metrics.px(12),
        metrics.px(10),
        metrics.px(12),
        metrics.px(10),
      ),
      decoration: BoxDecoration(
        color: palette.cardBackground,
        borderRadius: BorderRadius.circular(metrics.px(16)),
        border: Border.all(color: palette.cardBorder, width: 1),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: metrics.px(19),
            backgroundColor: palette.accent,
            child: Text(
              initials,
              style: AppTextStyles.titleMedium.copyWith(
                color: palette.avatarText,
                fontWeight: FontWeight.w700,
                fontSize: metrics.fs(17),
              ),
            ),
          ),
          SizedBox(width: metrics.px(10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.customerName,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: palette.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: metrics.fs(14.5),
                  ),
                ),
                SizedBox(height: metrics.px(1)),
                Text(
                  transaction.carName,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: palette.textSecondary,
                    fontSize: metrics.fs(11),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                transaction.amount,
                style: AppTextStyles.titleSmall.copyWith(
                  color: const Color(0xFF1BC47D),
                  fontWeight: FontWeight.w700,
                  fontSize: metrics.fs(14),
                ),
              ),
              SizedBox(height: metrics.px(1)),
              Text(
                transaction.timeAgo,
                style: AppTextStyles.labelSmall.copyWith(
                  color: palette.textMuted,
                  fontSize: metrics.fs(10.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(_DashboardMetrics metrics) {
    final palette = _palette(context);

    const navItems = [
      _DashboardNavItem(icon: Icons.home_outlined, label: 'Trang Chủ'),
      _DashboardNavItem(icon: Icons.storefront_outlined, label: 'Mall'),
      _DashboardNavItem(
        icon: Icons.notifications_none_rounded,
        label: 'Thông Báo',
      ),
      _DashboardNavItem(icon: Icons.person_outline_rounded, label: 'Tôi'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: palette.navBackground,
        border: Border(top: BorderSide(color: palette.navBorder, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            metrics.px(4),
            metrics.px(7),
            metrics.px(4),
            metrics.px(8),
          ),
          child: Row(
            children: List.generate(navItems.length, (index) {
              final item = navItems[index];
              final isSelected = _selectedIndex == index;

              return Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(metrics.px(12)),
                  onTap: () => _onBottomTabSelected(index),
                  child: AnimatedContainer(
                    duration: AppConstants.shortDuration,
                    padding: EdgeInsets.symmetric(vertical: metrics.px(7)),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? palette.navSelectedBackground
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(metrics.px(10)),
                      border: Border.all(
                        color: isSelected
                            ? palette.navSelectedBorder
                            : Colors.transparent,
                        width: 1,
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
                            fontSize: metrics.fs(10),
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: isSelected
                                ? palette.accent
                                : palette.navUnselected,
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

  void _onBottomTabSelected(int index) {
    if (index == _selectedIndex) {
      return;
    }

    switch (index) {
      case 0:
        setState(() => _selectedIndex = index);
        return;
      case 1:
        context.go(RouteNames.mall);
        return;
      case 2:
        context.go(RouteNames.notification);
        return;
      case 3:
        context.go(RouteNames.profile);
        return;
    }
  }
}

class _DashboardStat {
  final String title;
  final String value;
  final String trend;
  final bool isPositive;
  final IconData icon;
  final Color accentColor;

  const _DashboardStat({
    required this.title,
    required this.value,
    required this.trend,
    required this.isPositive,
    required this.icon,
    required this.accentColor,
  });
}

class _QuickActionItem {
  final String title;
  final IconData icon;
  final Color accentColor;
  final VoidCallback onTap;

  const _QuickActionItem({
    required this.title,
    required this.icon,
    required this.accentColor,
    required this.onTap,
  });
}

class _RecentTransaction {
  final String customerName;
  final String carName;
  final String amount;
  final String timeAgo;

  const _RecentTransaction({
    required this.customerName,
    required this.carName,
    required this.amount,
    required this.timeAgo,
  });
}

class _DashboardNavItem {
  final IconData icon;
  final String label;

  const _DashboardNavItem({required this.icon, required this.label});
}

class _DashboardMetrics {
  final double screenWidth;
  final double scale;
  final double fontScale;

  const _DashboardMetrics._({
    required this.screenWidth,
    required this.scale,
    required this.fontScale,
  });

  factory _DashboardMetrics.fromWidth(double width) {
    final rawScale = width / 390;

    return _DashboardMetrics._(
      screenWidth: width,
      scale: rawScale.clamp(0.88, 1.12).toDouble(),
      fontScale: rawScale.clamp(0.92, 1.08).toDouble(),
    );
  }

  bool get isCompact => screenWidth < 370;

  bool get isWide => screenWidth >= 430;

  double px(double value) => value * scale;

  double fs(double value) => value * fontScale;

  double get heroHeight => px(214).clamp(196, 246).toDouble();

  double get gridSpacing => px(10).clamp(8, 12).toDouble();

  double get statsAspectRatio {
    if (isCompact) {
      return 1.16;
    }
    if (isWide) {
      return 1.33;
    }
    return 1.24;
  }

  double get actionsAspectRatio {
    if (isCompact) {
      return 1.32;
    }
    if (isWide) {
      return 1.56;
    }
    return 1.44;
  }
}

class _DashboardPalette {
  final Color background;
  final Color gradientTop;
  final Color gradientBottom;
  final Color accent;
  final Color topBarIcon;
  final Color topBarSplash;
  final Color sectionTitle;
  final Color cardBackground;
  final Color cardBorder;
  final Color avatarText;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color navBackground;
  final Color navBorder;
  final Color navSelectedBackground;
  final Color navSelectedBorder;
  final Color navUnselected;

  const _DashboardPalette({
    required this.background,
    required this.gradientTop,
    required this.gradientBottom,
    required this.accent,
    required this.topBarIcon,
    required this.topBarSplash,
    required this.sectionTitle,
    required this.cardBackground,
    required this.cardBorder,
    required this.avatarText,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.navBackground,
    required this.navBorder,
    required this.navSelectedBackground,
    required this.navSelectedBorder,
    required this.navUnselected,
  });

  factory _DashboardPalette.fromTheme(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;

    return _DashboardPalette(
      background: theme.scaffoldBackgroundColor,
      gradientTop: isDark ? const Color(0xFF15171B) : const Color(0xFFF6F8FC),
      gradientBottom: isDark
          ? const Color(0xFF08090B)
          : const Color(0xFFECEFF6),
      accent: const Color(0xFFE0B54E),
      topBarIcon: isDark ? Colors.white.withValues(alpha: 0.95) : onSurface,
      topBarSplash: isDark
          ? Colors.white.withValues(alpha: 0.08)
          : Colors.black.withValues(alpha: 0.06),
      sectionTitle: isDark
          ? Colors.white.withValues(alpha: 0.92)
          : onSurface.withValues(alpha: 0.86),
      cardBackground: isDark ? const Color(0xFF1A1C20) : Colors.white,
      cardBorder: isDark
          ? Colors.white.withValues(alpha: 0.05)
          : Colors.black.withValues(alpha: 0.08),
      avatarText: isDark ? const Color(0xFF1A1A1A) : const Color(0xFF3A2B0E),
      textPrimary: onSurface,
      textSecondary: onSurface.withValues(alpha: isDark ? 0.65 : 0.72),
      textMuted: onSurface.withValues(alpha: isDark ? 0.55 : 0.62),
      navBackground: isDark ? const Color(0xFF121316) : const Color(0xFFF9FBFF),
      navBorder: isDark
          ? Colors.white.withValues(alpha: 0.06)
          : Colors.black.withValues(alpha: 0.08),
      navSelectedBackground: isDark
          ? const Color(0xFF191B1F)
          : const Color(0xFFEFE2C3),
      navSelectedBorder: const Color(
        0xFFE0B54E,
      ).withValues(alpha: isDark ? 0.9 : 0.56),
      navUnselected: onSurface.withValues(alpha: isDark ? 0.68 : 0.62),
    );
  }
}
