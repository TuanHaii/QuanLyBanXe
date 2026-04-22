// Nap thu vien hoac module can thiet.
import 'dart:async';

// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';
// Nap thu vien hoac module can thiet.
import 'package:go_router/go_router.dart';

// Nap thu vien hoac module can thiet.
import '../../../shared/constants/app_constants.dart';
// Nap thu vien hoac module can thiet.
import '../../../shared/services/service_locator.dart';
// Nap thu vien hoac module can thiet.
import '../../../shared/themes/app_colors.dart';
// Nap thu vien hoac module can thiet.
import '../../authentication/services/auth_service.dart';
// Nap thu vien hoac module can thiet.
import '../models/dashboard_summary_model.dart';
// Nap thu vien hoac module can thiet.
import '../services/dashboard_service.dart';
// Nap thu vien hoac module can thiet.
import '../widgets/stat_card.dart';
// Nap thu vien hoac module can thiet.
import '../widgets/quick_action_sheets.dart';

// Dinh nghia lop DashboardScreen de gom nhom logic lien quan.
class DashboardScreen extends StatefulWidget {
  // Khai bao bien DashboardScreen de luu du lieu su dung trong xu ly.
  const DashboardScreen({super.key});

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Thuc thi cau lenh hien tai theo luong xu ly.
  State<DashboardScreen> createState() => _DashboardScreenState();
}

// Dinh nghia lop _DashboardScreenState de gom nhom logic lien quan.
class _DashboardScreenState extends State<DashboardScreen> {
  // Khai bao bien _selectedIndex de luu du lieu su dung trong xu ly.
  int _selectedIndex = 0;

  // Khai bao bien DashboardService de luu du lieu su dung trong xu ly.
  final DashboardService _dashboardService = getIt<DashboardService>();
  // Khai bao bien AuthService de luu du lieu su dung trong xu ly.
  final AuthService _authService = getIt<AuthService>();

  // Thuc thi cau lenh hien tai theo luong xu ly.
  DashboardSummaryModel? _summary;
  // Khai bao bien _isLoading de luu du lieu su dung trong xu ly.
  bool _isLoading = true;
  // Thuc thi cau lenh hien tai theo luong xu ly.
  String? _errorMessage;

  // Dinh nghia ham _palette de xu ly nghiep vu tuong ung.
  _DashboardPalette _palette(BuildContext context) {
    // Tra ve ket qua cho noi goi ham.
    return _DashboardPalette.fromTheme(Theme.of(context));
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Dinh nghia ham initState de xu ly nghiep vu tuong ung.
  void initState() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.initState();
    // Khai bao constructor _loadDashboard de khoi tao doi tuong.
    _loadDashboard();
  }

  // Khai bao bien _loadDashboard de luu du lieu su dung trong xu ly.
  Future<void> _loadDashboard() async {
    // Cap nhat state de giao dien duoc render lai.
    setState(() {
      // Gan gia tri cho bien _isLoading.
      _isLoading = true;
      // Gan gia tri cho bien _errorMessage.
      _errorMessage = null;
    });

    // Bao boc khoi lenh co the phat sinh loi de xu ly an toan.
    try {
      // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
      final summary = await _dashboardService.fetchDashboardSummary();
      // Kiem tra dieu kien de re nhanh xu ly.
      if (!mounted) return;
      // Cap nhat state de giao dien duoc render lai.
      setState(() {
        // Gan gia tri cho bien _summary.
        _summary = summary;
      });
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } catch (_) {
      // Kiem tra dieu kien de re nhanh xu ly.
      if (!mounted) return;
      // Cap nhat state de giao dien duoc render lai.
      setState(() {
        // Gan gia tri cho bien _errorMessage.
        _errorMessage = 'Không thể tải dữ liệu. Vui lòng thử lại.';
      });
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } finally {
      // Kiem tra dieu kien de re nhanh xu ly.
      if (mounted) {
        // Cap nhat state de giao dien duoc render lai.
        setState(() => _isLoading = false);
      }
    }
  }

  // Khai bao bien get de luu du lieu su dung trong xu ly.
  String get _userName {
    // Tra ve ket qua cho noi goi ham.
    return _authService.currentUser?.name ?? 'Người dùng';
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien metrics de luu du lieu su dung trong xu ly.
    final metrics = _DashboardMetrics.fromWidth(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      MediaQuery.sizeOf(context).width,
    );
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return Scaffold(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      backgroundColor: palette.background,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      body: DecoratedBox(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        decoration: BoxDecoration(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          gradient: LinearGradient(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            begin: Alignment.topCenter,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            end: Alignment.bottomCenter,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            colors: [palette.gradientTop, palette.gradientBottom],
          ),
        ),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: SafeArea(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          bottom: false,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Column(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Goi ham de thuc thi tac vu can thiet.
              Expanded(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: SingleChildScrollView(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  physics: const BouncingScrollPhysics(),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  padding: EdgeInsets.fromLTRB(
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    metrics.px(14),
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    metrics.px(8),
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    metrics.px(14),
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    metrics.px(20),
                  ),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  child: Column(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    children: [
                      // Goi ham de thuc thi tac vu can thiet.
                      _buildTopBar(metrics),
                      // Goi ham de thuc thi tac vu can thiet.
                      SizedBox(height: metrics.px(12)),
                      // Goi ham de thuc thi tac vu can thiet.
                      _buildHeroBanner(metrics),
                      // Goi ham de thuc thi tac vu can thiet.
                      SizedBox(height: metrics.px(12)),
                      // Goi ham de thuc thi tac vu can thiet.
                      _buildStatsGrid(metrics),
                      // Goi ham de thuc thi tac vu can thiet.
                      SizedBox(height: metrics.px(16)),
                      // Goi ham de thuc thi tac vu can thiet.
                      _buildSectionTitle('• Hành Động Nhanh', metrics),
                      // Goi ham de thuc thi tac vu can thiet.
                      SizedBox(height: metrics.px(10)),
                      // Goi ham de thuc thi tac vu can thiet.
                      _buildQuickActionsGrid(metrics),
                      // Goi ham de thuc thi tac vu can thiet.
                      SizedBox(height: metrics.px(14)),
                      // Goi ham de thuc thi tac vu can thiet.
                      _buildSectionTitle('• Giao Dịch Gần Đây', metrics),
                      // Goi ham de thuc thi tac vu can thiet.
                      SizedBox(height: metrics.px(10)),
                      // Goi ham de thuc thi tac vu can thiet.
                      _buildRecentTransactions(metrics),
                      // Goi ham de thuc thi tac vu can thiet.
                      SizedBox(height: metrics.px(8)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      bottomNavigationBar: _buildBottomNavigationBar(metrics),
    );
  }

  // Khai bao bien _buildTopBar de luu du lieu su dung trong xu ly.
  Widget _buildTopBar(_DashboardMetrics metrics) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return SizedBox(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      height: metrics.px(34),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Stack(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        alignment: Alignment.center,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: [
          // Goi ham de thuc thi tac vu can thiet.
          Align(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            alignment: Alignment.centerLeft,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: _buildTopBarButton(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              metrics: metrics,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              icon: Icons.menu_rounded,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              onTap: () => _openActionMenu(),
            ),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          Text(
            // Thuc thi cau lenh hien tai theo luong xu ly.
            'PRECISION',
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            style: AppTextStyles.titleLarge.copyWith(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: palette.accent,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              fontWeight: FontWeight.w700,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              letterSpacing: metrics.px(2.5),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              fontSize: metrics.fs(21.5),
            ),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          Align(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            alignment: Alignment.centerRight,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Row(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              mainAxisSize: MainAxisSize.min,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              children: [
                // Goi ham de thuc thi tac vu can thiet.
                _buildTopBarButton(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  metrics: metrics,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  icon: Icons.notifications_none_rounded,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  onTap: () => context.go(RouteNames.notification),
                ),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(width: metrics.px(6)),
                // Goi ham de thuc thi tac vu can thiet.
                _buildTopBarButton(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  metrics: metrics,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  icon: Icons.person_outline_rounded,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  onTap: () => context.go(RouteNames.profile),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Khai bao bien _buildTopBarButton de luu du lieu su dung trong xu ly.
  Widget _buildTopBarButton({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required _DashboardMetrics metrics,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required IconData icon,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required VoidCallback onTap,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return Material(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      color: Colors.transparent,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: InkResponse(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onTap: onTap,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        radius: metrics.px(20),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        highlightShape: BoxShape.circle,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        splashColor: palette.topBarSplash,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: SizedBox(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          width: metrics.px(30),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          height: metrics.px(30),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Icon(icon, color: palette.topBarIcon, size: metrics.px(20)),
        ),
      ),
    );
  }

  // Khai bao bien _buildHeroBanner de luu du lieu su dung trong xu ly.
  Widget _buildHeroBanner(_DashboardMetrics metrics) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return ClipRRect(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      borderRadius: BorderRadius.circular(metrics.px(18)),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: SizedBox(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        height: metrics.heroHeight,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: Stack(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          fit: StackFit.expand,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          children: [
            // Thuc thi cau lenh hien tai theo luong xu ly.
            Image.asset('assets/images/MustangBg.webp', fit: BoxFit.cover),
            // Goi ham de thuc thi tac vu can thiet.
            DecoratedBox(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              decoration: BoxDecoration(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                gradient: LinearGradient(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  begin: Alignment.topCenter,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  end: Alignment.bottomCenter,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  colors: [
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    Colors.black.withValues(alpha: 0.22),
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    Colors.black.withValues(alpha: 0.5),
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    Colors.black.withValues(alpha: 0.87),
                  ],
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  stops: const [0.0, 0.58, 1.0],
                ),
              ),
            ),
            // Goi ham de thuc thi tac vu can thiet.
            Padding(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              padding: EdgeInsets.fromLTRB(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                metrics.px(15),
                // Thuc thi cau lenh hien tai theo luong xu ly.
                metrics.px(14),
                // Thuc thi cau lenh hien tai theo luong xu ly.
                metrics.px(15),
                // Thuc thi cau lenh hien tai theo luong xu ly.
                metrics.px(14),
              ),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              child: Column(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                crossAxisAlignment: CrossAxisAlignment.start,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                children: [
                  // Goi ham de thuc thi tac vu can thiet.
                  Text(
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    'TỔNG QUAN HOẠT ĐỘNG',
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    style: AppTextStyles.labelSmall.copyWith(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      color: palette.accent,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      fontWeight: FontWeight.w700,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      fontSize: metrics.fs(10),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      letterSpacing: metrics.px(1.6),
                    ),
                  ),
                  // Khai bao bien Spacer de luu du lieu su dung trong xu ly.
                  const Spacer(),
                  // Goi ham de thuc thi tac vu can thiet.
                  Text(
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    'Xin chào,\n$_userName',
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    style: AppTextStyles.displayMedium.copyWith(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      fontSize: metrics.fs(40),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      height: 0.93,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      fontWeight: FontWeight.w700,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      color: Colors.white,
                    ),
                  ),
                  // Goi ham de thuc thi tac vu can thiet.
                  SizedBox(height: metrics.px(7)),
                  // Goi ham de thuc thi tac vu can thiet.
                  Text(
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    _summary != null
                        // Thuc thi cau lenh hien tai theo luong xu ly.
                        ? 'Doanh thu ${_summary!.totalRevenueLabel}, ${_summary!.revenueTrend} so với tuần trước.'
                        // Thuc thi cau lenh hien tai theo luong xu ly.
                        : 'Đang tải dữ liệu...',
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    style: AppTextStyles.bodySmall.copyWith(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      fontSize: metrics.fs(11.2),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      height: 1.3,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
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

  // Khai bao bien _buildSectionTitle de luu du lieu su dung trong xu ly.
  Widget _buildSectionTitle(String title, _DashboardMetrics metrics) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return FittedBox(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      fit: BoxFit.scaleDown,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      alignment: Alignment.centerLeft,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Text(
        // Thuc thi cau lenh hien tai theo luong xu ly.
        title,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        style: AppTextStyles.headlineMedium.copyWith(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          fontSize: metrics.fs(14),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          fontWeight: FontWeight.w700,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          color: palette.sectionTitle,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          letterSpacing: metrics.px(-0.25),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          height: 1,
        ),
      ),
    );
  }

  // Khai bao bien get de luu du lieu su dung trong xu ly.
  List<_DashboardStat> get _statsFromSummary {
    // Khai bao bien s de luu du lieu su dung trong xu ly.
    final s = _summary;
    // Kiem tra dieu kien de re nhanh xu ly.
    if (s == null) {
      // Tra ve ket qua cho noi goi ham.
      return [];
    }

    // Khai bao bien stockTrend de luu du lieu su dung trong xu ly.
    final stockTrend = s.inStock < s.totalCars ? '-${((1 - s.inStock / s.totalCars) * 100).toStringAsFixed(1)}%' : '0%';

    // Tra ve ket qua cho noi goi ham.
    return [
      // Goi ham de thuc thi tac vu can thiet.
      _DashboardStat(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        title: 'Tổng xe',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        value: _formatNumber(s.totalCars),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        trend: '+4%',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        isPositive: true,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.directions_car_filled_outlined,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        accentColor: const Color(0xFF4792FF),
      ),
      // Goi ham de thuc thi tac vu can thiet.
      _DashboardStat(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        title: 'Xe đã bán',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        value: _formatNumber(s.carsSold),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        trend: s.salesTrend,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        isPositive: !s.salesTrend.startsWith('-'),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.sell_outlined,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        accentColor: const Color(0xFFE0B54E),
      ),
      // Goi ham de thuc thi tac vu can thiet.
      _DashboardStat(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        title: 'Trong kho',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        value: _formatNumber(s.inStock),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        trend: stockTrend,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        isPositive: false,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.inventory_2_outlined,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        accentColor: const Color(0xFFFF6B6B),
      ),
      // Goi ham de thuc thi tac vu can thiet.
      _DashboardStat(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        title: 'Tổng doanh thu',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        value: s.totalRevenueLabel,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        trend: s.revenueTrend,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        isPositive: !s.revenueTrend.startsWith('-'),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.bar_chart_rounded,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        accentColor: const Color(0xFF1BC47D),
      ),
    ];
  }

  // Khai bao bien _formatNumber de luu du lieu su dung trong xu ly.
  String _formatNumber(int n) {
    // Kiem tra dieu kien de re nhanh xu ly.
    if (n >= 1000) {
      // Tra ve ket qua cho noi goi ham.
      return '${(n / 1000).toStringAsFixed(n % 1000 == 0 ? 0 : 1)}K';
    }
    // Tra ve ket qua cho noi goi ham.
    return n.toString();
  }

  // Khai bao bien _buildStatsGrid de luu du lieu su dung trong xu ly.
  Widget _buildStatsGrid(_DashboardMetrics metrics) {
    // Kiem tra dieu kien de re nhanh xu ly.
    if (_isLoading) {
      // Tra ve ket qua cho noi goi ham.
      return const Center(child: CircularProgressIndicator());
    }

    // Kiem tra dieu kien de re nhanh xu ly.
    if (_errorMessage != null) {
      // Tra ve ket qua cho noi goi ham.
      return Center(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: Column(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          children: [
            // Goi ham de thuc thi tac vu can thiet.
            Text(_errorMessage!, textAlign: TextAlign.center),
            // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
            const SizedBox(height: 8),
            // Goi ham de thuc thi tac vu can thiet.
            ElevatedButton(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              onPressed: _loadDashboard,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              child: const Text('Thử lại'),
            ),
          ],
        ),
      );
    }

    // Khai bao bien stats de luu du lieu su dung trong xu ly.
    final stats = _statsFromSummary;
    // Kiem tra dieu kien de re nhanh xu ly.
    if (stats.isEmpty) {
      // Tra ve ket qua cho noi goi ham.
      return const Center(child: Text('Không có dữ liệu'));
    }

    // Tra ve ket qua cho noi goi ham.
    return GridView.builder(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      shrinkWrap: true,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      physics: const NeverScrollableScrollPhysics(),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      itemCount: stats.length,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        crossAxisCount: 2,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        mainAxisSpacing: metrics.gridSpacing,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        crossAxisSpacing: metrics.gridSpacing,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        childAspectRatio: metrics.statsAspectRatio,
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      itemBuilder: (context, index) {
        // Khai bao bien stat de luu du lieu su dung trong xu ly.
        final stat = stats[index];
        // Tra ve ket qua cho noi goi ham.
        return StatCard(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          title: stat.title,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          value: stat.value,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          trend: stat.trend,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          isPositive: stat.isPositive,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          icon: stat.icon,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          accentColor: stat.accentColor,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          uiScale: metrics.scale,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          textScale: metrics.fontScale,
        );
      },
    );
  }

  // Khai bao bien _buildQuickActionsGrid de luu du lieu su dung trong xu ly.
  Widget _buildQuickActionsGrid(_DashboardMetrics metrics) {
    // Khai bao bien actions de luu du lieu su dung trong xu ly.
    final actions = [
      // Goi ham de thuc thi tac vu can thiet.
      _QuickActionItem(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        title: 'Thêm xe mới',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.add_circle_outline_rounded,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        accentColor: const Color(0xFF2FA58A),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onTap: _openAddCarFlow,
      ),
      // Goi ham de thuc thi tac vu can thiet.
      _QuickActionItem(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        title: 'Kho hàng',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.inventory_2_outlined,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        accentColor: const Color(0xFF4E83F5),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onTap: _openCarList,
      ),
      // Goi ham de thuc thi tac vu can thiet.
      _QuickActionItem(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        title: 'Giao dịch',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.receipt_long_rounded,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        accentColor: const Color(0xFFE0A442),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onTap: _openSalesList,
      ),
      // Goi ham de thuc thi tac vu can thiet.
      _QuickActionItem(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        title: 'Báo cáo',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.pie_chart_outline_rounded,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        accentColor: const Color(0xFF5F86D9),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onTap: _openReportSheet,
      ),
      // Goi ham de thuc thi tac vu can thiet.
      _QuickActionItem(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        title: 'Hỗ trợ',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.support_agent_rounded,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        accentColor: const Color(0xFFE57E6D),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onTap: _openSupportSheet,
      ),
      // Goi ham de thuc thi tac vu can thiet.
      _QuickActionItem(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        title: 'Thông báo',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.notifications_none_rounded,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        accentColor: const Color(0xFF6E90A9),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onTap: _openNotifications,
      ),
    ];

    // Tra ve ket qua cho noi goi ham.
    return GridView.builder(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      shrinkWrap: true,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      physics: const NeverScrollableScrollPhysics(),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      itemCount: actions.length,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        crossAxisCount: 2,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        mainAxisSpacing: metrics.gridSpacing,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        crossAxisSpacing: metrics.gridSpacing,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        childAspectRatio: metrics.actionsAspectRatio,
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      itemBuilder: (context, index) {
        // Khai bao bien action de luu du lieu su dung trong xu ly.
        final action = actions[index];
        // Tra ve ket qua cho noi goi ham.
        return ActionCard(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          title: action.title,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          icon: action.icon,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          accentColor: action.accentColor,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          onTap: action.onTap,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          uiScale: metrics.scale,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          textScale: metrics.fontScale,
        );
      },
    );
  }

  // Khai bao bien _openAddCarFlow de luu du lieu su dung trong xu ly.
  Future<void> _openAddCarFlow() async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    final created = await context.push<bool>(RouteNames.addCar);
    // Kiem tra dieu kien de re nhanh xu ly.
    if (created == true && mounted) {
      // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
      await _loadDashboard();
    }
  }

  // Khai bao bien _openCarList de luu du lieu su dung trong xu ly.
  Future<void> _openCarList() async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await showModalBottomSheet<void>(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      context: context,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      isScrollControlled: true,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      useSafeArea: true,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      barrierColor: Colors.transparent,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      backgroundColor: Colors.transparent,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      builder: (sheetContext) => const InventoryQuickActionSheet(),
    );
  }

  // Khai bao bien _openSalesList de luu du lieu su dung trong xu ly.
  Future<void> _openSalesList() async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await showModalBottomSheet<void>(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      context: context,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      isScrollControlled: true,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      useSafeArea: true,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      barrierColor: Colors.transparent,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      backgroundColor: Colors.transparent,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      builder: (sheetContext) => const SalesQuickActionSheet(),
    );
  }

  // Khai bao bien _openReportSheet de luu du lieu su dung trong xu ly.
  Future<void> _openReportSheet() async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await showModalBottomSheet<void>(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      context: context,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      isScrollControlled: true,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      useSafeArea: true,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      barrierColor: Colors.transparent,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      backgroundColor: Colors.transparent,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      builder: (sheetContext) => const ReportQuickActionSheet(),
    );
  }

  // Khai bao bien _openSupportSheet de luu du lieu su dung trong xu ly.
  Future<void> _openSupportSheet() async {
    // Khai bao bien user de luu du lieu su dung trong xu ly.
    final user = _authService.currentUser;

    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    final submitted = await showModalBottomSheet<bool>(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      context: context,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      isScrollControlled: true,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      useSafeArea: true,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      barrierColor: Colors.transparent,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      backgroundColor: Colors.transparent,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      builder: (sheetContext) => SupportQuickActionSheet(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        initialName: user?.name ?? '',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        initialEmail: user?.email ?? '',
      ),
    );

    // Kiem tra dieu kien de re nhanh xu ly.
    if (submitted == true && mounted) {
      // Thuc thi cau lenh hien tai theo luong xu ly.
      ScaffoldMessenger.of(context).showSnackBar(
        // Khai bao bien SnackBar de luu du lieu su dung trong xu ly.
        const SnackBar(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          content: Text('Yêu cầu hỗ trợ đã được gửi.'),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // Dinh nghia ham _openNotifications de xu ly nghiep vu tuong ung.
  void _openNotifications() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    context.go(RouteNames.notification);
  }

  // Dinh nghia ham _openActionMenu de xu ly nghiep vu tuong ung.
  void _openActionMenu() {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Thuc thi cau lenh hien tai theo luong xu ly.
    showModalBottomSheet<void>(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      context: context,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      useSafeArea: true,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      backgroundColor: Colors.transparent,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      builder: (sheetContext) {
        // Tra ve ket qua cho noi goi ham.
        return Container(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          decoration: BoxDecoration(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: palette.navBackground,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            border: Border.all(color: palette.navBorder, width: 1),
          ),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: SafeArea(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            top: false,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Padding(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 18),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              child: Column(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                mainAxisSize: MainAxisSize.min,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                crossAxisAlignment: CrossAxisAlignment.start,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                children: [
                  // Goi ham de thuc thi tac vu can thiet.
                  Center(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    child: Container(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      width: 42,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      height: 5,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      decoration: BoxDecoration(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        color: palette.navBorder,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                  const SizedBox(height: 14),
                  // Goi ham de thuc thi tac vu can thiet.
                  Text(
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    'Trung tâm thao tác',
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    style: AppTextStyles.titleLarge.copyWith(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      color: palette.textPrimary,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                  const SizedBox(height: 4),
                  // Goi ham de thuc thi tac vu can thiet.
                  Text(
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    'Truy cập nhanh các tác vụ quan trọng nhất.',
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    style: AppTextStyles.bodySmall.copyWith(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      color: palette.textSecondary,
                    ),
                  ),
                  // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                  const SizedBox(height: 12),
                  // Goi ham de thuc thi tac vu can thiet.
                  _ActionMenuTile(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    icon: Icons.add_circle_outline_rounded,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    title: 'Thêm xe mới',
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    subtitle: 'Tạo nhanh hồ sơ xe vào kho',
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    accentColor: const Color(0xFF2FA58A),
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    textColor: palette.textPrimary,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    subtitleColor: palette.textSecondary,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    onTap: () {
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      Navigator.of(sheetContext).pop();
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      Future.microtask(() {
                        // Goi ham de thuc thi tac vu can thiet.
                        unawaited(_openAddCarFlow());
                      });
                    },
                  ),
                  // Goi ham de thuc thi tac vu can thiet.
                  _ActionMenuTile(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    icon: Icons.inventory_2_outlined,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    title: 'Kho hàng',
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    subtitle: 'Xem tổng quan kho xe và tình trạng',
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    accentColor: const Color(0xFF4E83F5),
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    textColor: palette.textPrimary,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    subtitleColor: palette.textSecondary,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    onTap: () {
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      Navigator.of(sheetContext).pop();
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      Future.microtask(() {
                        // Goi ham de thuc thi tac vu can thiet.
                        unawaited(_openCarList());
                      });
                    },
                  ),
                  // Goi ham de thuc thi tac vu can thiet.
                  _ActionMenuTile(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    icon: Icons.receipt_long_rounded,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    title: 'Giao dịch',
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    subtitle: 'Tổng quan tình hình bán hàng',
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    accentColor: const Color(0xFFE0A442),
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    textColor: palette.textPrimary,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    subtitleColor: palette.textSecondary,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    onTap: () {
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      Navigator.of(sheetContext).pop();
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      Future.microtask(() {
                        // Goi ham de thuc thi tac vu can thiet.
                        unawaited(_openSalesList());
                      });
                    },
                  ),
                  // Goi ham de thuc thi tac vu can thiet.
                  _ActionMenuTile(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    icon: Icons.pie_chart_outline_rounded,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    title: 'Báo cáo nhanh',
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    subtitle: 'Xem doanh thu, mục tiêu và giao dịch mới',
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    accentColor: const Color(0xFF5F86D9),
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    textColor: palette.textPrimary,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    subtitleColor: palette.textSecondary,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    onTap: () {
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      Navigator.of(sheetContext).pop();
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      Future.microtask(() {
                        // Goi ham de thuc thi tac vu can thiet.
                        unawaited(_openReportSheet());
                      });
                    },
                  ),
                  // Goi ham de thuc thi tac vu can thiet.
                  _ActionMenuTile(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    icon: Icons.support_agent_rounded,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    title: 'Liên hệ hỗ trợ',
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    subtitle: 'Gửi yêu cầu hoặc xem kênh hỗ trợ',
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    accentColor: const Color(0xFFE57E6D),
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    textColor: palette.textPrimary,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    subtitleColor: palette.textSecondary,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    onTap: () {
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      Navigator.of(sheetContext).pop();
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      Future.microtask(() {
                        // Goi ham de thuc thi tac vu can thiet.
                        unawaited(_openSupportSheet());
                      });
                    },
                  ),
                  // Goi ham de thuc thi tac vu can thiet.
                  _ActionMenuTile(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    icon: Icons.refresh_rounded,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    title: 'Làm mới dữ liệu',
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    subtitle: 'Tải lại thống kê của dashboard',
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    accentColor: const Color(0xFF6E90A9),
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    textColor: palette.textPrimary,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    subtitleColor: palette.textSecondary,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    onTap: () {
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      Navigator.of(sheetContext).pop();
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      Future.microtask(() {
                        // Goi ham de thuc thi tac vu can thiet.
                        unawaited(_loadDashboard());
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Khai bao bien _buildRecentTransactions de luu du lieu su dung trong xu ly.
  Widget _buildRecentTransactions(_DashboardMetrics metrics) {
    // Khai bao bien recentTx de luu du lieu su dung trong xu ly.
    final recentTx = _summary?.recentTransactions ?? [];

    // Kiem tra dieu kien de re nhanh xu ly.
    if (recentTx.isEmpty) {
      // Tra ve ket qua cho noi goi ham.
      return Center(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: Text(
          // Thuc thi cau lenh hien tai theo luong xu ly.
          'Chưa có giao dịch nào.',
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          style: AppTextStyles.bodySmall.copyWith(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: _palette(context).textSecondary,
          ),
        ),
      );
    }

    // Khai bao bien transactions de luu du lieu su dung trong xu ly.
    final transactions = recentTx
        // Thuc thi cau lenh hien tai theo luong xu ly.
        .map((tx) => _RecentTransaction(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              customerName: tx.customerName,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              carName: tx.carName,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              amount: tx.amount,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              timeAgo: tx.timeAgo,
            ))
        // Thuc thi cau lenh hien tai theo luong xu ly.
        .toList();

    // Tra ve ket qua cho noi goi ham.
    return Column(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      children: transactions
          // Thuc thi cau lenh hien tai theo luong xu ly.
          .map(
            // Thuc thi cau lenh hien tai theo luong xu ly.
            (transaction) => _buildRecentTransactionItem(transaction, metrics),
          )
          // Thuc thi cau lenh hien tai theo luong xu ly.
          .toList(),
    );
  }

  // Khai bao bien _buildRecentTransactionItem de luu du lieu su dung trong xu ly.
  Widget _buildRecentTransactionItem(
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _RecentTransaction transaction,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _DashboardMetrics metrics,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  ) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);
    // Khai bao bien initials de luu du lieu su dung trong xu ly.
    final initials = transaction.customerName.substring(0, 1).toUpperCase();

    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      margin: EdgeInsets.only(bottom: metrics.px(8)),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: EdgeInsets.fromLTRB(
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(12),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(10),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(12),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(10),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.cardBackground,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(metrics.px(16)),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: Border.all(color: palette.cardBorder, width: 1),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Row(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: [
          // Goi ham de thuc thi tac vu can thiet.
          CircleAvatar(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            radius: metrics.px(19),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            backgroundColor: palette.accent,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Text(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              initials,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              style: AppTextStyles.titleMedium.copyWith(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                color: palette.avatarText,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                fontWeight: FontWeight.w700,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                fontSize: metrics.fs(17),
              ),
            ),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          SizedBox(width: metrics.px(10)),
          // Goi ham de thuc thi tac vu can thiet.
          Expanded(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Column(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              crossAxisAlignment: CrossAxisAlignment.start,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              children: [
                // Goi ham de thuc thi tac vu can thiet.
                Text(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  transaction.customerName,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: AppTextStyles.titleSmall.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: palette.textPrimary,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontWeight: FontWeight.w700,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontSize: metrics.fs(14.5),
                  ),
                ),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(1)),
                // Goi ham de thuc thi tac vu can thiet.
                Text(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  transaction.carName,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: AppTextStyles.bodySmall.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: palette.textSecondary,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontSize: metrics.fs(11),
                  ),
                ),
              ],
            ),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          Column(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            crossAxisAlignment: CrossAxisAlignment.end,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Goi ham de thuc thi tac vu can thiet.
              Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                transaction.amount,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: AppTextStyles.titleSmall.copyWith(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: const Color(0xFF1BC47D),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontWeight: FontWeight.w700,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontSize: metrics.fs(14),
                ),
              ),
              // Goi ham de thuc thi tac vu can thiet.
              SizedBox(height: metrics.px(1)),
              // Goi ham de thuc thi tac vu can thiet.
              Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                transaction.timeAgo,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: AppTextStyles.labelSmall.copyWith(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: palette.textMuted,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontSize: metrics.fs(10.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Khai bao bien _buildBottomNavigationBar de luu du lieu su dung trong xu ly.
  Widget _buildBottomNavigationBar(_DashboardMetrics metrics) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Khai bao bien navItems de luu du lieu su dung trong xu ly.
    const navItems = [
      // Goi ham de thuc thi tac vu can thiet.
      _DashboardNavItem(icon: Icons.home_outlined, label: 'Trang Chủ'),
      // Goi ham de thuc thi tac vu can thiet.
      _DashboardNavItem(icon: Icons.storefront_outlined, label: 'Mall'),
      // Goi ham de thuc thi tac vu can thiet.
      _DashboardNavItem(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.notifications_none_rounded,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        label: 'Thông Báo',
      ),
      // Goi ham de thuc thi tac vu can thiet.
      _DashboardNavItem(icon: Icons.person_outline_rounded, label: 'Tôi'),
    ];

    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.navBackground,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: Border(top: BorderSide(color: palette.navBorder, width: 1)),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: SafeArea(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        top: false,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: Padding(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          padding: EdgeInsets.fromLTRB(
            // Thuc thi cau lenh hien tai theo luong xu ly.
            metrics.px(4),
            // Thuc thi cau lenh hien tai theo luong xu ly.
            metrics.px(7),
            // Thuc thi cau lenh hien tai theo luong xu ly.
            metrics.px(4),
            // Thuc thi cau lenh hien tai theo luong xu ly.
            metrics.px(8),
          ),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Row(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: List.generate(navItems.length, (index) {
              // Khai bao bien item de luu du lieu su dung trong xu ly.
              final item = navItems[index];
              // Khai bao bien isSelected de luu du lieu su dung trong xu ly.
              final isSelected = _selectedIndex == index;

              // Tra ve ket qua cho noi goi ham.
              return Expanded(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: InkWell(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  borderRadius: BorderRadius.circular(metrics.px(12)),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  onTap: () => _onBottomTabSelected(index),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  child: AnimatedContainer(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    duration: AppConstants.shortDuration,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    padding: EdgeInsets.symmetric(vertical: metrics.px(7)),
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    decoration: BoxDecoration(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      color: isSelected
                          // Thuc thi cau lenh hien tai theo luong xu ly.
                          ? palette.navSelectedBackground
                          // Thuc thi cau lenh hien tai theo luong xu ly.
                          : Colors.transparent,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      borderRadius: BorderRadius.circular(metrics.px(10)),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      border: Border.all(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        color: isSelected
                            // Thuc thi cau lenh hien tai theo luong xu ly.
                            ? palette.navSelectedBorder
                            // Thuc thi cau lenh hien tai theo luong xu ly.
                            : Colors.transparent,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        width: 1,
                      ),
                    ),
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    child: Column(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      mainAxisSize: MainAxisSize.min,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      children: [
                        // Goi ham de thuc thi tac vu can thiet.
                        Icon(
                          // Thuc thi cau lenh hien tai theo luong xu ly.
                          item.icon,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          size: metrics.px(19),
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          color: isSelected
                              // Thuc thi cau lenh hien tai theo luong xu ly.
                              ? palette.accent
                              // Thuc thi cau lenh hien tai theo luong xu ly.
                              : palette.navUnselected,
                        ),
                        // Goi ham de thuc thi tac vu can thiet.
                        SizedBox(height: metrics.px(3)),
                        // Goi ham de thuc thi tac vu can thiet.
                        Text(
                          // Thuc thi cau lenh hien tai theo luong xu ly.
                          item.label,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          style: AppTextStyles.labelSmall.copyWith(
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            fontSize: metrics.fs(10),
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            fontWeight: isSelected
                                // Thuc thi cau lenh hien tai theo luong xu ly.
                                ? FontWeight.w700
                                // Thuc thi cau lenh hien tai theo luong xu ly.
                                : FontWeight.w500,
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            color: isSelected
                                // Thuc thi cau lenh hien tai theo luong xu ly.
                                ? palette.accent
                                // Thuc thi cau lenh hien tai theo luong xu ly.
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

  // Dinh nghia ham _onBottomTabSelected de xu ly nghiep vu tuong ung.
  void _onBottomTabSelected(int index) {
    // Kiem tra dieu kien de re nhanh xu ly.
    if (index == _selectedIndex) {
      // Tra ve ket qua cho noi goi ham.
      return;
    }

    // Bat dau re nhanh theo nhieu truong hop gia tri.
    switch (index) {
      // Xu ly mot truong hop cu the trong switch.
      case 0:
        // Cap nhat state de giao dien duoc render lai.
        setState(() => _selectedIndex = index);
        // Tra ve ket qua cho noi goi ham.
        return;
      // Xu ly mot truong hop cu the trong switch.
      case 1:
        // Thuc thi cau lenh hien tai theo luong xu ly.
        context.go(RouteNames.mall);
        // Tra ve ket qua cho noi goi ham.
        return;
      // Xu ly mot truong hop cu the trong switch.
      case 2:
        // Thuc thi cau lenh hien tai theo luong xu ly.
        context.go(RouteNames.notification);
        // Tra ve ket qua cho noi goi ham.
        return;
      // Xu ly mot truong hop cu the trong switch.
      case 3:
        // Thuc thi cau lenh hien tai theo luong xu ly.
        context.go(RouteNames.profile);
        // Tra ve ket qua cho noi goi ham.
        return;
    }
  }

  // Dinh nghia ham _showFeatureComingSoon de xu ly nghiep vu tuong ung.
  void _showFeatureComingSoon(String message) {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    ScaffoldMessenger.of(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      context,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

// Dinh nghia lop _DashboardStat de gom nhom logic lien quan.
class _DashboardStat {
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

  // Khai bao bien _DashboardStat de luu du lieu su dung trong xu ly.
  const _DashboardStat({
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
  });
}

// Dinh nghia lop _QuickActionItem de gom nhom logic lien quan.
class _QuickActionItem {
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String title;
  // Khai bao bien IconData de luu du lieu su dung trong xu ly.
  final IconData icon;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color accentColor;
  // Khai bao bien VoidCallback de luu du lieu su dung trong xu ly.
  final VoidCallback onTap;

  // Khai bao bien _QuickActionItem de luu du lieu su dung trong xu ly.
  const _QuickActionItem({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.title,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.icon,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.accentColor,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.onTap,
  });
}

// Dinh nghia lop _ActionMenuTile de gom nhom logic lien quan.
class _ActionMenuTile extends StatelessWidget {
  // Khai bao bien IconData de luu du lieu su dung trong xu ly.
  final IconData icon;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String title;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String subtitle;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color accentColor;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color textColor;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color subtitleColor;
  // Khai bao bien VoidCallback de luu du lieu su dung trong xu ly.
  final VoidCallback onTap;

  // Khai bao bien _ActionMenuTile de luu du lieu su dung trong xu ly.
  const _ActionMenuTile({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.icon,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.title,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.subtitle,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.accentColor,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.textColor,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.subtitleColor,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.onTap,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Tra ve ket qua cho noi goi ham.
    return Padding(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: const EdgeInsets.only(bottom: 10),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Material(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: Colors.transparent,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: InkWell(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          onTap: onTap,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderRadius: BorderRadius.circular(18),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Container(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            padding: const EdgeInsets.all(14),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            decoration: BoxDecoration(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: accentColor.withValues(alpha: 0.09),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              borderRadius: BorderRadius.circular(18),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              border: Border.all(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                color: accentColor.withValues(alpha: 0.20),
              ),
            ),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Row(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              children: [
                // Goi ham de thuc thi tac vu can thiet.
                Container(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  padding: const EdgeInsets.all(10),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  decoration: BoxDecoration(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: accentColor.withValues(alpha: 0.15),
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    borderRadius: BorderRadius.circular(14),
                  ),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  child: Icon(icon, color: accentColor, size: 20),
                ),
                // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                const SizedBox(width: 12),
                // Goi ham de thuc thi tac vu can thiet.
                Expanded(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  child: Column(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    children: [
                      // Goi ham de thuc thi tac vu can thiet.
                      Text(
                        // Thuc thi cau lenh hien tai theo luong xu ly.
                        title,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        style: AppTextStyles.titleSmall.copyWith(
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          color: textColor,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                      const SizedBox(height: 2),
                      // Goi ham de thuc thi tac vu can thiet.
                      Text(
                        // Thuc thi cau lenh hien tai theo luong xu ly.
                        subtitle,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        style: AppTextStyles.bodySmall.copyWith(
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          color: subtitleColor,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                // Goi ham de thuc thi tac vu can thiet.
                Icon(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  Icons.chevron_right_rounded,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: subtitleColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Dinh nghia lop _RecentTransaction de gom nhom logic lien quan.
class _RecentTransaction {
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String customerName;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String carName;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String amount;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String timeAgo;

  // Khai bao bien _RecentTransaction de luu du lieu su dung trong xu ly.
  const _RecentTransaction({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.customerName,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.carName,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.amount,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.timeAgo,
  });
}

// Dinh nghia lop _DashboardNavItem de gom nhom logic lien quan.
class _DashboardNavItem {
  // Khai bao bien IconData de luu du lieu su dung trong xu ly.
  final IconData icon;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String label;

  // Khai bao bien _DashboardNavItem de luu du lieu su dung trong xu ly.
  const _DashboardNavItem({required this.icon, required this.label});
}

// Dinh nghia lop _DashboardMetrics de gom nhom logic lien quan.
class _DashboardMetrics {
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double screenWidth;
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double scale;
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double fontScale;

  // Khai bao bien _DashboardMetrics de luu du lieu su dung trong xu ly.
  const _DashboardMetrics._({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.screenWidth,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.scale,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.fontScale,
  });

  // Thuc thi cau lenh hien tai theo luong xu ly.
  factory _DashboardMetrics.fromWidth(double width) {
    // Khai bao bien rawScale de luu du lieu su dung trong xu ly.
    final rawScale = width / 390;

    // Tra ve ket qua cho noi goi ham.
    return _DashboardMetrics._(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      screenWidth: width,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      scale: rawScale.clamp(0.88, 1.12).toDouble(),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      fontScale: rawScale.clamp(0.92, 1.08).toDouble(),
    );
  }

  // Khai bao bien get de luu du lieu su dung trong xu ly.
  bool get isCompact => screenWidth < 370;

  // Khai bao bien get de luu du lieu su dung trong xu ly.
  bool get isWide => screenWidth >= 430;

  // Khai bao bien px de luu du lieu su dung trong xu ly.
  double px(double value) => value * scale;

  // Khai bao bien fs de luu du lieu su dung trong xu ly.
  double fs(double value) => value * fontScale;

  // Khai bao bien get de luu du lieu su dung trong xu ly.
  double get heroHeight => px(214).clamp(196, 246).toDouble();

  // Khai bao bien get de luu du lieu su dung trong xu ly.
  double get gridSpacing => px(10).clamp(8, 12).toDouble();

  // Khai bao bien get de luu du lieu su dung trong xu ly.
  double get statsAspectRatio {
    // Kiem tra dieu kien de re nhanh xu ly.
    if (isCompact) {
      // Tra ve ket qua cho noi goi ham.
      return 1.16;
    }
    // Kiem tra dieu kien de re nhanh xu ly.
    if (isWide) {
      // Tra ve ket qua cho noi goi ham.
      return 1.33;
    }
    // Tra ve ket qua cho noi goi ham.
    return 1.24;
  }

  // Khai bao bien get de luu du lieu su dung trong xu ly.
  double get actionsAspectRatio {
    // Kiem tra dieu kien de re nhanh xu ly.
    if (isCompact) {
      // Tra ve ket qua cho noi goi ham.
      return 1.32;
    }
    // Kiem tra dieu kien de re nhanh xu ly.
    if (isWide) {
      // Tra ve ket qua cho noi goi ham.
      return 1.56;
    }
    // Tra ve ket qua cho noi goi ham.
    return 1.44;
  }
}

// Dinh nghia lop _DashboardPalette de gom nhom logic lien quan.
class _DashboardPalette {
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color background;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color gradientTop;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color gradientBottom;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color accent;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color topBarIcon;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color topBarSplash;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color sectionTitle;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color cardBackground;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color cardBorder;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color avatarText;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color textPrimary;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color textSecondary;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color textMuted;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color navBackground;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color navBorder;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color navSelectedBackground;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color navSelectedBorder;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color navUnselected;

  // Khai bao bien _DashboardPalette de luu du lieu su dung trong xu ly.
  const _DashboardPalette({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.background,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.gradientTop,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.gradientBottom,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.accent,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.topBarIcon,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.topBarSplash,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.sectionTitle,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.cardBackground,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.cardBorder,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.avatarText,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.textPrimary,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.textSecondary,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.textMuted,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.navBackground,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.navBorder,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.navSelectedBackground,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.navSelectedBorder,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.navUnselected,
  });

  // Thuc thi cau lenh hien tai theo luong xu ly.
  factory _DashboardPalette.fromTheme(ThemeData theme) {
    // Khai bao bien isDark de luu du lieu su dung trong xu ly.
    final isDark = theme.brightness == Brightness.dark;
    // Khai bao bien onSurface de luu du lieu su dung trong xu ly.
    final onSurface = theme.colorScheme.onSurface;

    // Tra ve ket qua cho noi goi ham.
    return _DashboardPalette(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      background: theme.scaffoldBackgroundColor,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      gradientTop: isDark ? const Color(0xFF15171B) : const Color(0xFFF6F8FC),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      gradientBottom: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? const Color(0xFF08090B)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : const Color(0xFFECEFF6),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      accent: const Color(0xFFE0B54E),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      topBarIcon: isDark ? Colors.white.withValues(alpha: 0.95) : onSurface,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      topBarSplash: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? Colors.white.withValues(alpha: 0.08)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : Colors.black.withValues(alpha: 0.06),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      sectionTitle: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? Colors.white.withValues(alpha: 0.92)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : onSurface.withValues(alpha: 0.86),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      cardBackground: isDark ? const Color(0xFF1A1C20) : Colors.white,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      cardBorder: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? Colors.white.withValues(alpha: 0.05)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : Colors.black.withValues(alpha: 0.08),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      avatarText: isDark ? const Color(0xFF1A1A1A) : const Color(0xFF3A2B0E),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      textPrimary: onSurface,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      textSecondary: onSurface.withValues(alpha: isDark ? 0.65 : 0.72),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      textMuted: onSurface.withValues(alpha: isDark ? 0.55 : 0.62),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      navBackground: isDark ? const Color(0xFF121316) : const Color(0xFFF9FBFF),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      navBorder: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? Colors.white.withValues(alpha: 0.06)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : Colors.black.withValues(alpha: 0.08),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      navSelectedBackground: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? const Color(0xFF191B1F)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : const Color(0xFFEFE2C3),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      navSelectedBorder: const Color(
        // Thuc thi cau lenh hien tai theo luong xu ly.
        0xFFE0B54E,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      ).withValues(alpha: isDark ? 0.9 : 0.56),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      navUnselected: onSurface.withValues(alpha: isDark ? 0.68 : 0.62),
    );
  }
}
