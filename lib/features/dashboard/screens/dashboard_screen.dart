import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/constants/app_constants.dart';
import '../../../shared/themes/app_colors.dart';
import '../../../shared/services/service_locator.dart';
import '../../authentication/services/auth_service.dart';
import '../widgets/stat_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final metrics = _DashboardMetrics.fromWidth(
      MediaQuery.sizeOf(context).width,
    );
    final baseDarkTheme = ThemeData.dark();

    return Theme(
      data: baseDarkTheme.copyWith(
        textTheme: baseDarkTheme.textTheme.apply(fontFamily: 'Roboto'),
        primaryTextTheme: baseDarkTheme.primaryTextTheme.apply(
          fontFamily: 'Roboto',
        ),
        scaffoldBackgroundColor: const Color(0xFF0A0B0D),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE0B54E),
          surface: Color(0xFF17191D),
        ),
      ),
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF15171B), Color(0xFF08090B)],
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
      ),
    );
  }

  Widget _buildTopBar(_DashboardMetrics metrics) {
    return SizedBox(
      height: metrics.px(34),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: _buildTopBarButton(
              metrics: metrics,
              icon: Icons.menu_rounded,
              onTap: () => _showFeatureComingSoon('Menu đang được cập nhật.'),
            ),
          ),
          Text(
            'PRECISION',
            style: AppTextStyles.titleLarge.copyWith(
              color: const Color(0xFFE0B54E),
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
                  onTap: _showNotifications,
                ),
                SizedBox(width: metrics.px(6)),
                _buildTopBarButton(
                  metrics: metrics,
                  icon: Icons.person_outline_rounded,
                  onTap: _handleLogout,
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
    return Material(
      color: Colors.transparent,
      child: InkResponse(
        onTap: onTap,
        radius: metrics.px(20),
        highlightShape: BoxShape.circle,
        splashColor: Colors.white.withValues(alpha: 0.08),
        child: SizedBox(
          width: metrics.px(30),
          height: metrics.px(30),
          child: Icon(
            icon,
            color: Colors.white.withValues(alpha: 0.95),
            size: metrics.px(20),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroBanner(_DashboardMetrics metrics) {
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
                      color: const Color(0xFFE0B54E),
                      fontWeight: FontWeight.w700,
                      fontSize: metrics.fs(10),
                      letterSpacing: metrics.px(1.6),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Xin chào,\nAlex Sterling',
                    style: AppTextStyles.displayMedium.copyWith(
                      fontSize: metrics.fs(40),
                      height: 0.93,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: metrics.px(7)),
                  Text(
                    'Hiệu suất showroom của bạn tăng 12% tuần này. Đây là dữ liệu thực tế của bạn.',
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
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: AppTextStyles.headlineMedium.copyWith(
          fontSize: metrics.fs(14),
          fontWeight: FontWeight.w700,
          color: Colors.white.withValues(alpha: 0.92),
          letterSpacing: metrics.px(-0.25),
          height: 1,
        ),
      ),
    );
  }

  Widget _buildStatsGrid(_DashboardMetrics metrics) {
    const stats = [
      _DashboardStat(
        title: 'Tổng xe',
        value: '1.248',
        trend: '+4%',
        isPositive: true,
        icon: Icons.directions_car_filled_outlined,
        accentColor: Color(0xFF4792FF),
      ),
      _DashboardStat(
        title: 'Xe đã bán',
        value: '412',
        trend: '+8.2%',
        isPositive: true,
        icon: Icons.sell_outlined,
        accentColor: Color(0xFFE0B54E),
      ),
      _DashboardStat(
        title: 'Trong kho',
        value: '836',
        trend: '-1.5%',
        isPositive: false,
        icon: Icons.inventory_2_outlined,
        accentColor: Color(0xFFFF6B6B),
      ),
      _DashboardStat(
        title: 'Tổng doanh thu',
        value: '\$4.2M',
        trend: '+14%',
        isPositive: true,
        icon: Icons.bar_chart_rounded,
        accentColor: Color(0xFF1BC47D),
      ),
    ];

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
        onTap: () => context.go(RouteNames.addCar),
      ),
      _QuickActionItem(
        title: 'Tạo hóa đơn',
        icon: Icons.attach_money_rounded,
        onTap: () => context.go(RouteNames.sales),
      ),
      _QuickActionItem(
        title: 'Kho hàng',
        icon: Icons.inventory_2_outlined,
        onTap: () => context.go(RouteNames.carList),
      ),
      _QuickActionItem(
        title: 'Báo cáo',
        icon: Icons.pie_chart_outline_rounded,
        onTap: () =>
            _showFeatureComingSoon('Mục báo cáo sẽ có trong bản cập nhật tới.'),
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
          accentColor: const Color(0xFFE0B54E),
          onTap: action.onTap,
          uiScale: metrics.scale,
          textScale: metrics.fontScale,
        );
      },
    );
  }

  Widget _buildRecentTransactions(_DashboardMetrics metrics) {
    const transactions = [
      _RecentTransaction(
        customerName: 'Nguyễn Văn A',
        carName: 'Toyota Camry 2024',
        amount: '1.2 tỷ',
        timeAgo: '2 giờ trước',
      ),
      _RecentTransaction(
        customerName: 'Trần Thị B',
        carName: 'Honda CR-V 2024',
        amount: '990 triệu',
        timeAgo: '5 giờ trước',
      ),
      _RecentTransaction(
        customerName: 'Lê Văn C',
        carName: 'Mazda CX-5 2024',
        amount: '880 triệu',
        timeAgo: 'Hôm qua',
      ),
    ];

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
        color: const Color(0xFF1A1C20),
        borderRadius: BorderRadius.circular(metrics.px(16)),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: metrics.px(19),
            backgroundColor: const Color(0xFFE0B54E),
            child: Text(
              initials,
              style: AppTextStyles.titleMedium.copyWith(
                color: const Color(0xFF1A1A1A),
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
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: metrics.fs(14.5),
                  ),
                ),
                SizedBox(height: metrics.px(1)),
                Text(
                  transaction.carName,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.65),
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
                  color: Colors.white.withValues(alpha: 0.55),
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
        color: const Color(0xFF121316),
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
                          ? const Color(0xFF191B1F)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(metrics.px(10)),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFFE0B54E).withValues(alpha: 0.9)
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
                              ? const Color(0xFFE0B54E)
                              : Colors.white.withValues(alpha: 0.68),
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
                                ? const Color(0xFFE0B54E)
                                : Colors.white.withValues(alpha: 0.62),
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
        context.go(RouteNames.sales);
        return;
      case 2:
        _showNotifications();
        return;
      case 3:
        _showFeatureComingSoon('Trang cá nhân sẽ sớm được cập nhật.');
        return;
    }
  }

  void _showFeatureComingSoon(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showNotifications() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Chưa có thông báo mới!')));
  }

  Future<void> _handleLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Đăng xuất'),
        content: const Text('Bạn có chắc muốn đăng xuất?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
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
  final VoidCallback onTap;

  const _QuickActionItem({
    required this.title,
    required this.icon,
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
