// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';
// Nap thu vien hoac module can thiet.
import 'package:go_router/go_router.dart';

// Nap thu vien hoac module can thiet.
import '../../authentication/services/auth_service.dart';
// Nap thu vien hoac module can thiet.
import '../../authentication/models/user_model.dart';
// Nap thu vien hoac module can thiet.
import '../../../shared/constants/app_constants.dart';
// Nap thu vien hoac module can thiet.
import '../../../shared/services/service_locator.dart';
// Nap thu vien hoac module can thiet.
import '../../../shared/services/theme_service.dart';
// Nap thu vien hoac module can thiet.
import '../../../shared/themes/app_colors.dart';
// Nap thu vien hoac module can thiet.
import '../../dashboard/models/dashboard_summary_model.dart';
// Nap thu vien hoac module can thiet.
import '../../dashboard/services/dashboard_service.dart';

// Dinh nghia lop ProfileScreen de gom nhom logic lien quan.
class ProfileScreen extends StatefulWidget {
  // Khai bao bien ProfileScreen de luu du lieu su dung trong xu ly.
  const ProfileScreen({super.key});

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Thuc thi cau lenh hien tai theo luong xu ly.
  State<ProfileScreen> createState() => _ProfileScreenState();
}

// Dinh nghia lop _ProfileScreenState de gom nhom logic lien quan.
class _ProfileScreenState extends State<ProfileScreen> {
  // Khai bao bien final de luu du lieu su dung trong xu ly.
  late final ThemeService _themeService;
  // Khai bao bien final de luu du lieu su dung trong xu ly.
  late final AuthService _authService;
  // Khai bao bien final de luu du lieu su dung trong xu ly.
  late final DashboardService _dashboardService;
  // Khai bao bien _isApplyingTheme de luu du lieu su dung trong xu ly.
  bool _isApplyingTheme = false;

  // Thuc thi cau lenh hien tai theo luong xu ly.
  UserModel? _user;
  // Thuc thi cau lenh hien tai theo luong xu ly.
  DashboardSummaryModel? _summary;

  // Dinh nghia ham _palette de xu ly nghiep vu tuong ung.
  _ProfilePalette _palette(BuildContext context) {
    // Tra ve ket qua cho noi goi ham.
    return _ProfilePalette.fromTheme(Theme.of(context));
  }

  // Khai bao bien get de luu du lieu su dung trong xu ly.
  bool get _darkModeEnabled => _themeService.darkModeEnabled;

  // Khai bao bien get de luu du lieu su dung trong xu ly.
  bool get _followSystemTheme => _themeService.followSystemTheme;

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Dinh nghia ham initState de xu ly nghiep vu tuong ung.
  void initState() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.initState();
    // Gan gia tri cho bien _themeService.
    _themeService = getIt<ThemeService>();
    // Gan gia tri cho bien _authService.
    _authService = getIt<AuthService>();
    // Gan gia tri cho bien _dashboardService.
    _dashboardService = getIt<DashboardService>();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _themeService.addListener(_handleThemeServiceChanged);
    // Khai bao constructor _loadProfileData de khoi tao doi tuong.
    _loadProfileData();
  }

  // Khai bao bien _loadProfileData de luu du lieu su dung trong xu ly.
  Future<void> _loadProfileData() async {
    // Cap nhat state de giao dien duoc render lai.
    setState(() {
      // Gan gia tri cho bien _user.
      _user = _authService.currentUser;
    });

    // Bao boc khoi lenh co the phat sinh loi de xu ly an toan.
    try {
      // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
      final summary = await _dashboardService.fetchDashboardSummary();
      // Kiem tra dieu kien de re nhanh xu ly.
      if (!mounted) return;
      // Cap nhat state de giao dien duoc render lai.
      setState(() => _summary = summary);
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } catch (_) {
      // Silently ignore - stats will show fallback values
    }
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Dinh nghia ham dispose de xu ly nghiep vu tuong ung.
  void dispose() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _themeService.removeListener(_handleThemeServiceChanged);
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.dispose();
  }

  // Dinh nghia ham _handleThemeServiceChanged de xu ly nghiep vu tuong ung.
  void _handleThemeServiceChanged() {
    // Kiem tra dieu kien de re nhanh xu ly.
    if (!mounted) {
      // Tra ve ket qua cho noi goi ham.
      return;
    }

    // Cap nhat state de giao dien duoc render lai.
    setState(() {});
  }

  // Dinh nghia ham _onDarkModeChanged de xu ly nghiep vu tuong ung.
  void _onDarkModeChanged(bool enabled) {
    // Khai bao constructor _applyDarkMode de khoi tao doi tuong.
    _applyDarkMode(enabled);
  }

  // Khai bao bien _applyDarkMode de luu du lieu su dung trong xu ly.
  Future<void> _applyDarkMode(bool enabled) async {
    // Kiem tra dieu kien de re nhanh xu ly.
    if (_isApplyingTheme) {
      // Tra ve ket qua cho noi goi ham.
      return;
    }

    // Cap nhat state de giao dien duoc render lai.
    setState(() => _isApplyingTheme = true);
    // Bao boc khoi lenh co the phat sinh loi de xu ly an toan.
    try {
      // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
      await _themeService.setDarkModeEnabled(enabled);
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } finally {
      // Kiem tra dieu kien de re nhanh xu ly.
      if (mounted) {
        // Cap nhat state de giao dien duoc render lai.
        setState(() => _isApplyingTheme = false);
      }
    }
  }

  // Dinh nghia ham _onFollowSystemThemeChanged de xu ly nghiep vu tuong ung.
  void _onFollowSystemThemeChanged(bool enabled) {
    // Khai bao constructor _applyFollowSystemTheme de khoi tao doi tuong.
    _applyFollowSystemTheme(enabled);
  }

  // Khai bao bien _applyFollowSystemTheme de luu du lieu su dung trong xu ly.
  Future<void> _applyFollowSystemTheme(bool enabled) async {
    // Kiem tra dieu kien de re nhanh xu ly.
    if (_isApplyingTheme) {
      // Tra ve ket qua cho noi goi ham.
      return;
    }

    // Cap nhat state de giao dien duoc render lai.
    setState(() => _isApplyingTheme = true);
    // Bao boc khoi lenh co the phat sinh loi de xu ly an toan.
    try {
      // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
      await _themeService.setFollowSystemTheme(enabled);
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } finally {
      // Kiem tra dieu kien de re nhanh xu ly.
      if (mounted) {
        // Cap nhat state de giao dien duoc render lai.
        setState(() => _isApplyingTheme = false);
      }
    }
  }

  // Dinh nghia ham _onBottomTabSelected de xu ly nghiep vu tuong ung.
  void _onBottomTabSelected(int index) {
    // Bat dau re nhanh theo nhieu truong hop gia tri.
    switch (index) {
      // Xu ly mot truong hop cu the trong switch.
      case 0:
        // Thuc thi cau lenh hien tai theo luong xu ly.
        context.go(RouteNames.dashboard);
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
        // Tra ve ket qua cho noi goi ham.
        return;
    }
  }

  // Dinh nghia ham _showFeatureComingSoon de xu ly nghiep vu tuong ung.
  void _showFeatureComingSoon(String message) {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    ScaffoldMessenger.of(context)
      // Thuc thi cau lenh hien tai theo luong xu ly.
      ..hideCurrentSnackBar()
      // Thuc thi cau lenh hien tai theo luong xu ly.
      ..showSnackBar(
        // Goi ham de thuc thi tac vu can thiet.
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  // Khai bao bien _handleLogout de luu du lieu su dung trong xu ly.
  Future<void> _handleLogout() async {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    final confirmed = await showDialog<bool>(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      context: context,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      builder: (dialogContext) => AlertDialog(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        backgroundColor: palette.dialogBackground,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        title: const Text('Đăng xuất'),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        content: const Text('Bạn có chắc muốn đăng xuất khỏi hệ thống?'),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        titleTextStyle: AppTextStyles.titleLarge.copyWith(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          color: palette.textPrimary,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          fontWeight: FontWeight.w700,
        ),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          color: palette.textSecondary,
        ),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        actions: [
          // Goi ham de thuc thi tac vu can thiet.
          TextButton(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onPressed: () => Navigator.pop(dialogContext, false),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Text(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              'Hủy',
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              style: AppTextStyles.labelLarge.copyWith(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                color: palette.textSecondary,
              ),
            ),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          FilledButton(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            style: FilledButton.styleFrom(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              backgroundColor: palette.logoutForeground,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              foregroundColor: Colors.white,
            ),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onPressed: () => Navigator.pop(dialogContext, true),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: const Text('Đăng xuất'),
          ),
        ],
      ),
    );

    // Kiem tra dieu kien de re nhanh xu ly.
    if (confirmed == true && mounted) {
      // Khai bao bien authService de luu du lieu su dung trong xu ly.
      final authService = getIt<AuthService>();
      // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
      await authService.logout();
      // Kiem tra dieu kien de re nhanh xu ly.
      if (mounted) {
        // Thuc thi cau lenh hien tai theo luong xu ly.
        context.go(RouteNames.login);
      }
    }
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien metrics de luu du lieu su dung trong xu ly.
    final metrics = _ProfileMetrics.fromWidth(MediaQuery.sizeOf(context).width);
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
          child: SingleChildScrollView(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            physics: const BouncingScrollPhysics(),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            padding: EdgeInsets.fromLTRB(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              metrics.px(14),
              // Thuc thi cau lenh hien tai theo luong xu ly.
              metrics.px(10),
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
                _buildProfileHeader(metrics),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(16)),
                // Goi ham de thuc thi tac vu can thiet.
                _buildStats(metrics),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(18)),
                // Goi ham de thuc thi tac vu can thiet.
                _buildSectionTitle('TÀI KHOẢN', metrics),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(8)),
                // Goi ham de thuc thi tac vu can thiet.
                _buildActionGroup(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  metrics: metrics,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  items: [
                    // Goi ham de thuc thi tac vu can thiet.
                    _ProfileActionItem(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      icon: Icons.person_outline_rounded,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      title: 'Thông Tin Cá Nhân',
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      onTap: () => context.push(RouteNames.profileInfo),
                    ),
                    // Goi ham de thuc thi tac vu can thiet.
                    _ProfileActionItem(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      icon: Icons.shield_outlined,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      title: 'Bảo Mật',
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      onTap: () => context.push(RouteNames.profileSecurity),
                    ),
                    // Goi ham de thuc thi tac vu can thiet.
                    _ProfileActionItem(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      icon: Icons.notifications_none_rounded,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      title: 'Thông Báo',
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      onTap: () => context.go(RouteNames.notification),
                    ),
                  ],
                ),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(14)),
                // Goi ham de thuc thi tac vu can thiet.
                _buildSectionTitle('HIỂN THỊ', metrics),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(8)),
                // Goi ham de thuc thi tac vu can thiet.
                _buildDisplayGroup(metrics),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(14)),
                // Goi ham de thuc thi tac vu can thiet.
                _buildSectionTitle('HOẠT ĐỘNG', metrics),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(8)),
                // Goi ham de thuc thi tac vu can thiet.
                _buildActionGroup(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  metrics: metrics,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  items: [
                    // Goi ham de thuc thi tac vu can thiet.
                    _ProfileActionItem(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      icon: Icons.bar_chart_rounded,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      title: 'Báo Cáo Của Tôi',
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      onTap: () => _showFeatureComingSoon(
                        // Thuc thi cau lenh hien tai theo luong xu ly.
                        'Báo cáo chi tiết đang được hoàn thiện.',
                      ),
                    ),
                    // Goi ham de thuc thi tac vu can thiet.
                    _ProfileActionItem(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      icon: Icons.history_rounded,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      title: 'Lịch Sử Giao Dịch',
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      onTap: () => context.push(RouteNames.profileHistory),
                    ),
                    // Goi ham de thuc thi tac vu can thiet.
                    _ProfileActionItem(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      icon: Icons.track_changes_outlined,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      title: 'Mục Tiêu Doanh Số',
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      onTap: () => _showFeatureComingSoon(
                        // Thuc thi cau lenh hien tai theo luong xu ly.
                        'Mục tiêu doanh số sẽ sớm khả dụng.',
                      ),
                    ),
                  ],
                ),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(14)),
                // Goi ham de thuc thi tac vu can thiet.
                _buildSectionTitle('HỖ TRỢ', metrics),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(8)),
                // Goi ham de thuc thi tac vu can thiet.
                _buildActionGroup(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  metrics: metrics,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  items: [
                    // Goi ham de thuc thi tac vu can thiet.
                    _ProfileActionItem(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      icon: Icons.help_outline_rounded,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      title: 'Trung Tâm Hỗ Trợ',
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      onTap: () => _showFeatureComingSoon(
                        // Thuc thi cau lenh hien tai theo luong xu ly.
                        'Trung tâm hỗ trợ đang được cập nhật.',
                      ),
                    ),
                    // Goi ham de thuc thi tac vu can thiet.
                    _ProfileActionItem(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      icon: Icons.chat_bubble_outline_rounded,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      title: 'Liên Hệ Chúng Tôi',
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      onTap: () => _showFeatureComingSoon(
                        // Thuc thi cau lenh hien tai theo luong xu ly.
                        'Kênh liên hệ trực tiếp đang được bổ sung.',
                      ),
                    ),
                    // Goi ham de thuc thi tac vu can thiet.
                    _ProfileActionItem(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      icon: Icons.info_outline_rounded,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      title: 'Về Ứng Dụng',
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      onTap: () => _showFeatureComingSoon(
                        // Thuc thi cau lenh hien tai theo luong xu ly.
                        'Thông tin phiên bản chi tiết sẽ sớm có.',
                      ),
                    ),
                  ],
                ),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(16)),
                // Goi ham de thuc thi tac vu can thiet.
                _buildLogoutButton(metrics),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(12)),
                // Goi ham de thuc thi tac vu can thiet.
                Center(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  child: Text(
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    'Phiên bản ${AppConstants.appVersion} - Precision Auto',
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    style: AppTextStyles.labelMedium.copyWith(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      color: palette.textMuted,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      fontSize: metrics.fs(11),
                    ),
                  ),
                ),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(14)),
              ],
            ),
          ),
        ),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      bottomNavigationBar: _buildBottomNavigationBar(metrics),
    );
  }

  // Khai bao bien _buildProfileHeader de luu du lieu su dung trong xu ly.
  Widget _buildProfileHeader(_ProfileMetrics metrics) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return Center(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Column(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: [
          // Goi ham de thuc thi tac vu can thiet.
          Container(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            width: metrics.px(82),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            height: metrics.px(82),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            decoration: BoxDecoration(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              shape: BoxShape.circle,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              gradient: const LinearGradient(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                begin: Alignment.topLeft,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                end: Alignment.bottomRight,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                colors: [Color(0xFFE4C15D), Color(0xFFD6A93E)],
              ),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              border: Border.all(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                color: const Color(0xFFFFE4A4).withValues(alpha: 0.26),
              ),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              boxShadow: [
                // Goi ham de thuc thi tac vu can thiet.
                BoxShadow(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: palette.accent.withValues(alpha: 0.23),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  blurRadius: 22,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            alignment: Alignment.center,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Text(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              (_user?.name ?? 'Người dùng').substring(0, 1).toUpperCase(),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              style: AppTextStyles.headlineMedium.copyWith(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                color: const Color(0xFF17150F),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                fontWeight: FontWeight.w800,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                fontSize: metrics.fs(34),
              ),
            ),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          SizedBox(height: metrics.px(12)),
          // Goi ham de thuc thi tac vu can thiet.
          Text(
            // Thuc thi cau lenh hien tai theo luong xu ly.
            _user?.name ?? 'Người dùng',
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            style: AppTextStyles.headlineSmall.copyWith(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: palette.textPrimary,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              fontWeight: FontWeight.w800,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              fontSize: metrics.fs(32),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              height: 1,
            ),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          SizedBox(height: metrics.px(4)),
          // Goi ham de thuc thi tac vu can thiet.
          Text(
            // Thuc thi cau lenh hien tai theo luong xu ly.
            _roleLabel,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            style: AppTextStyles.bodyMedium.copyWith(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: palette.textSecondary,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              fontSize: metrics.fs(16),
            ),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          SizedBox(height: metrics.px(9)),
          // Goi ham de thuc thi tac vu can thiet.
          Container(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            padding: EdgeInsets.symmetric(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              horizontal: metrics.px(12),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              vertical: metrics.px(5),
            ),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            decoration: BoxDecoration(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: palette.surfaceSoft,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              borderRadius: BorderRadius.circular(999),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              border: Border.all(color: palette.accent.withValues(alpha: 0.28)),
            ),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Row(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              mainAxisSize: MainAxisSize.min,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              children: [
                // Goi ham de thuc thi tac vu can thiet.
                Icon(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  Icons.star_border_rounded,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: palette.accent,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  size: metrics.px(14),
                ),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(width: metrics.px(6)),
                // Goi ham de thuc thi tac vu can thiet.
                Text(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  'Nhân Viên Xuất Sắc',
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: AppTextStyles.labelMedium.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: palette.accent,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontWeight: FontWeight.w700,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
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

  // Khai bao bien get de luu du lieu su dung trong xu ly.
  String get _roleLabel {
    // Khai bao bien role de luu du lieu su dung trong xu ly.
    final role = _user?.role?.toLowerCase() ?? '';
    // Bat dau re nhanh theo nhieu truong hop gia tri.
    switch (role) {
      // Xu ly mot truong hop cu the trong switch.
      case 'admin':
        // Tra ve ket qua cho noi goi ham.
        return 'Quản trị viên';
      // Xu ly mot truong hop cu the trong switch.
      case 'manager':
        // Tra ve ket qua cho noi goi ham.
        return 'Giám Đốc Kinh Doanh';
      // Xu ly mot truong hop cu the trong switch.
      case 'user':
        // Tra ve ket qua cho noi goi ham.
        return 'Nhân viên';
      // Xu ly mac dinh khi khong khop case nao.
      default:
        // Tra ve ket qua cho noi goi ham.
        return 'Nhân viên';
    }
  }

  // Khai bao bien _buildStats de luu du lieu su dung trong xu ly.
  Widget _buildStats(_ProfileMetrics metrics) {
    // Khai bao bien stats de luu du lieu su dung trong xu ly.
    final stats = [
      // Goi ham de thuc thi tac vu can thiet.
      _ProfileStatData(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.attach_money_rounded,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        value: _summary != null ? '${_summary!.carsSold}' : '--',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        label: 'Xe Đã Bán',
      ),
      // Goi ham de thuc thi tac vu can thiet.
      _ProfileStatData(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.trending_up_rounded,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        value: _summary?.totalRevenueLabel ?? '--',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        label: 'Doanh Thu',
      ),
      // Goi ham de thuc thi tac vu can thiet.
      _ProfileStatData(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.groups_2_outlined,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        value: _summary != null ? '${_summary!.inStock}' : '--',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        label: 'Trong Kho',
      ),
    ];

    // Tra ve ket qua cho noi goi ham.
    return Row(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      children: List.generate(stats.length, (index) {
        // Khai bao bien stat de luu du lieu su dung trong xu ly.
        final stat = stats[index];

        // Tra ve ket qua cho noi goi ham.
        return Expanded(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Padding(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            padding: EdgeInsets.only(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              left: index == 0 ? 0 : metrics.px(4),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              right: index == stats.length - 1 ? 0 : metrics.px(4),
            ),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: _buildStatCard(metrics: metrics, stat: stat),
          ),
        );
      }),
    );
  }

  // Khai bao bien _buildStatCard de luu du lieu su dung trong xu ly.
  Widget _buildStatCard({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required _ProfileMetrics metrics,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required _ProfileStatData stat,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: EdgeInsets.fromLTRB(
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(11),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(10),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(11),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(10),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.surface,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(metrics.px(14)),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: Border.all(color: palette.cardBorder),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Column(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        crossAxisAlignment: CrossAxisAlignment.start,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: [
          // Goi ham de thuc thi tac vu can thiet.
          Icon(stat.icon, color: palette.accent, size: metrics.px(15)),
          // Goi ham de thuc thi tac vu can thiet.
          SizedBox(height: metrics.px(5)),
          // Goi ham de thuc thi tac vu can thiet.
          Text(
            // Thuc thi cau lenh hien tai theo luong xu ly.
            stat.value,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            style: AppTextStyles.titleLarge.copyWith(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: palette.textPrimary,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              fontWeight: FontWeight.w800,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              fontSize: metrics.fs(25),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              height: 1,
            ),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          SizedBox(height: metrics.px(3)),
          // Goi ham de thuc thi tac vu can thiet.
          Text(
            // Thuc thi cau lenh hien tai theo luong xu ly.
            stat.label,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            style: AppTextStyles.labelMedium.copyWith(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: palette.textMuted,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              fontSize: metrics.fs(11),
            ),
          ),
        ],
      ),
    );
  }

  // Khai bao bien _buildSectionTitle de luu du lieu su dung trong xu ly.
  Widget _buildSectionTitle(String text, _ProfileMetrics metrics) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return Text(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      text,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      style: AppTextStyles.labelLarge.copyWith(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.textSecondary,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        letterSpacing: metrics.px(1.05),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        fontWeight: FontWeight.w700,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        fontSize: metrics.fs(13),
      ),
    );
  }

  // Khai bao bien _buildActionGroup de luu du lieu su dung trong xu ly.
  Widget _buildActionGroup({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required _ProfileMetrics metrics,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required List<_ProfileActionItem> items,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.surface,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(metrics.px(17)),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: Border.all(color: palette.cardBorder),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Column(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: List.generate(items.length, (index) {
          // Khai bao bien item de luu du lieu su dung trong xu ly.
          final item = items[index];

          // Tra ve ket qua cho noi goi ham.
          return Column(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Goi ham de thuc thi tac vu can thiet.
              _buildActionTile(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                metrics: metrics,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                icon: item.icon,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                title: item.title,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                onTap: item.onTap,
              ),
              // Kiem tra dieu kien de re nhanh xu ly.
              if (index != items.length - 1)
                // Goi ham de thuc thi tac vu can thiet.
                Divider(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: palette.divider,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  height: 1,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  indent: metrics.px(13),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  endIndent: metrics.px(13),
                ),
            ],
          );
        }),
      ),
    );
  }

  // Khai bao bien _buildDisplayGroup de luu du lieu su dung trong xu ly.
  Widget _buildDisplayGroup(_ProfileMetrics metrics) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.surface,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(metrics.px(17)),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: Border.all(color: palette.cardBorder),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Column(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: [
          // Goi ham de thuc thi tac vu can thiet.
          _buildSwitchTile(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            metrics: metrics,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            icon: Icons.nights_stay_outlined,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            title: 'Chế Độ Tối',
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            value: _darkModeEnabled,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onChanged: _onDarkModeChanged,
          ),
          // Goi ham de thuc thi tac vu can thiet.
          Divider(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: palette.divider,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            height: 1,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            indent: metrics.px(13),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            endIndent: metrics.px(13),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          _buildSwitchTile(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            metrics: metrics,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            icon: Icons.smartphone_outlined,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            title: 'Theo Hệ Thống',
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            value: _followSystemTheme,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onChanged: _onFollowSystemThemeChanged,
          ),
        ],
      ),
    );
  }

  // Khai bao bien _buildActionTile de luu du lieu su dung trong xu ly.
  Widget _buildActionTile({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required _ProfileMetrics metrics,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required IconData icon,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required String title,
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
      child: InkWell(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(metrics.px(15)),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onTap: onTap,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: Padding(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          padding: EdgeInsets.symmetric(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            horizontal: metrics.px(12),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            vertical: metrics.px(13),
          ),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Row(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Goi ham de thuc thi tac vu can thiet.
              _buildLeadingIcon(icon, metrics),
              // Goi ham de thuc thi tac vu can thiet.
              SizedBox(width: metrics.px(9)),
              // Goi ham de thuc thi tac vu can thiet.
              Expanded(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: Text(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  title,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: AppTextStyles.titleSmall.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: palette.textPrimary,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontWeight: FontWeight.w700,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontSize: metrics.fs(15),
                  ),
                ),
              ),
              // Goi ham de thuc thi tac vu can thiet.
              Icon(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                Icons.chevron_right_rounded,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                size: metrics.px(19),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                color: palette.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Khai bao bien _buildSwitchTile de luu du lieu su dung trong xu ly.
  Widget _buildSwitchTile({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required _ProfileMetrics metrics,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required IconData icon,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required String title,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required bool value,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required ValueChanged<bool> onChanged,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return Padding(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: EdgeInsets.symmetric(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        horizontal: metrics.px(12),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        vertical: metrics.px(13),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Row(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: [
          // Goi ham de thuc thi tac vu can thiet.
          _buildLeadingIcon(icon, metrics),
          // Goi ham de thuc thi tac vu can thiet.
          SizedBox(width: metrics.px(9)),
          // Goi ham de thuc thi tac vu can thiet.
          Expanded(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Text(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              title,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              style: AppTextStyles.titleSmall.copyWith(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                color: palette.textPrimary,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                fontWeight: FontWeight.w700,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                fontSize: metrics.fs(15),
              ),
            ),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          _DualToneSwitch(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            value: value,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onChanged: _isApplyingTheme ? null : onChanged,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            accentColor: palette.accent,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            tealAccentColor: palette.tealAccent,
          ),
        ],
      ),
    );
  }

  // Khai bao bien _buildLeadingIcon de luu du lieu su dung trong xu ly.
  Widget _buildLeadingIcon(IconData icon, _ProfileMetrics metrics) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      width: metrics.px(30),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      height: metrics.px(30),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.iconContainer,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(metrics.px(9)),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      alignment: Alignment.center,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Icon(icon, color: palette.accent, size: metrics.px(16)),
    );
  }

  // Khai bao bien _buildLogoutButton de luu du lieu su dung trong xu ly.
  Widget _buildLogoutButton(_ProfileMetrics metrics) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return SizedBox(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      width: double.infinity,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: FilledButton.icon(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onPressed: _handleLogout,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        style: FilledButton.styleFrom(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          backgroundColor: palette.logoutBackground,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          foregroundColor: palette.logoutForeground,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          elevation: 0,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          padding: EdgeInsets.symmetric(vertical: metrics.px(14)),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          shape: RoundedRectangleBorder(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            borderRadius: BorderRadius.circular(metrics.px(14)),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            side: BorderSide(color: palette.logoutBorder),
          ),
        ),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: const Icon(Icons.logout_rounded, size: 18),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        label: Text(
          // Thuc thi cau lenh hien tai theo luong xu ly.
          'Đăng Xuất',
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          style: AppTextStyles.titleSmall.copyWith(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: palette.logoutForeground,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            fontWeight: FontWeight.w700,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            fontSize: metrics.fs(16),
          ),
        ),
      ),
    );
  }

  // Khai bao bien _buildBottomNavigationBar de luu du lieu su dung trong xu ly.
  Widget _buildBottomNavigationBar(_ProfileMetrics metrics) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Khai bao bien navItems de luu du lieu su dung trong xu ly.
    const navItems = [
      // Goi ham de thuc thi tac vu can thiet.
      _ProfileNavItem(icon: Icons.home_outlined, label: 'Trang Chủ'),
      // Goi ham de thuc thi tac vu can thiet.
      _ProfileNavItem(icon: Icons.shopping_bag_outlined, label: 'Mall'),
      // Goi ham de thuc thi tac vu can thiet.
      _ProfileNavItem(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.notifications_none_rounded,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        label: 'Thông Báo',
      ),
      // Goi ham de thuc thi tac vu can thiet.
      _ProfileNavItem(icon: Icons.person_outline_rounded, label: 'Tôi'),
    ];

    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.bottomNavBackground,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: Border(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          top: BorderSide(color: palette.bottomNavBorder, width: 1),
        ),
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
            metrics.px(8),
            // Thuc thi cau lenh hien tai theo luong xu ly.
            metrics.px(7),
            // Thuc thi cau lenh hien tai theo luong xu ly.
            metrics.px(8),
            // Thuc thi cau lenh hien tai theo luong xu ly.
            metrics.px(6),
          ),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Row(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: List.generate(navItems.length, (index) {
              // Khai bao bien item de luu du lieu su dung trong xu ly.
              final item = navItems[index];
              // Khai bao bien selectedIndex de luu du lieu su dung trong xu ly.
              const selectedIndex = 3;
              // Khai bao bien isSelected de luu du lieu su dung trong xu ly.
              final isSelected = index == selectedIndex;

              // Tra ve ket qua cho noi goi ham.
              return Expanded(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: InkWell(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  onTap: () => _onBottomTabSelected(index),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  borderRadius: BorderRadius.circular(metrics.px(12)),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  child: AnimatedContainer(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    duration: AppConstants.shortDuration,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    padding: EdgeInsets.symmetric(vertical: metrics.px(8)),
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    decoration: BoxDecoration(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      color: isSelected
                          // Thuc thi cau lenh hien tai theo luong xu ly.
                          ? palette.bottomNavSelectedBackground
                          // Thuc thi cau lenh hien tai theo luong xu ly.
                          : Colors.transparent,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      borderRadius: BorderRadius.circular(metrics.px(11)),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      border: Border.all(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        color: isSelected
                            // Thuc thi cau lenh hien tai theo luong xu ly.
                            ? palette.bottomNavSelectedBorder
                            // Thuc thi cau lenh hien tai theo luong xu ly.
                            : Colors.transparent,
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
                            color: isSelected
                                // Thuc thi cau lenh hien tai theo luong xu ly.
                                ? palette.accent
                                // Thuc thi cau lenh hien tai theo luong xu ly.
                                : palette.navUnselected,
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            fontWeight: isSelected
                                // Thuc thi cau lenh hien tai theo luong xu ly.
                                ? FontWeight.w700
                                // Thuc thi cau lenh hien tai theo luong xu ly.
                                : FontWeight.w500,
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
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

// Dinh nghia lop _DualToneSwitch de gom nhom logic lien quan.
class _DualToneSwitch extends StatelessWidget {
  // Khai bao bien bool de luu du lieu su dung trong xu ly.
  final bool value;
  // Khai bao bien ValueChanged de luu du lieu su dung trong xu ly.
  final ValueChanged<bool>? onChanged;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color accentColor;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color tealAccentColor;

  // Khai bao bien _DualToneSwitch de luu du lieu su dung trong xu ly.
  const _DualToneSwitch({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.value,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.onChanged,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.accentColor,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.tealAccentColor,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien isDark de luu du lieu su dung trong xu ly.
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Khai bao bien disabledTrackColors de luu du lieu su dung trong xu ly.
    final disabledTrackColors = isDark
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ? const [Color(0xFF363942), Color(0xFF2A2C33)]
        // Thuc thi cau lenh hien tai theo luong xu ly.
        : const [Color(0xFFE1E6EE), Color(0xFFD5DCE8)];
    // Khai bao bien offTrackColors de luu du lieu su dung trong xu ly.
    final offTrackColors = isDark
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ? const [Color(0xFF42464E), Color(0xFF2E3138)]
        // Thuc thi cau lenh hien tai theo luong xu ly.
        : const [Color(0xFFDCE2EB), Color(0xFFCAD3E0)];
    // Khai bao bien thumbColor de luu du lieu su dung trong xu ly.
    final thumbColor = value
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ? (isDark ? const Color(0xFFF5F7FA) : Colors.white)
        // Thuc thi cau lenh hien tai theo luong xu ly.
        : (isDark ? const Color(0xFF9CA3AF) : const Color(0xFF7D8896));

    // Tra ve ket qua cho noi goi ham.
    return GestureDetector(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      behavior: HitTestBehavior.opaque,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      onTap: onChanged == null ? null : () => onChanged!(!value),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: AnimatedContainer(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        duration: AppConstants.shortDuration,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        width: 44,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        height: 24,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        padding: const EdgeInsets.all(2),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        decoration: BoxDecoration(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderRadius: BorderRadius.circular(999),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          gradient: LinearGradient(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            begin: Alignment.centerLeft,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            end: Alignment.centerRight,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            colors: onChanged == null
                // Thuc thi cau lenh hien tai theo luong xu ly.
                ? disabledTrackColors
                // Thuc thi cau lenh hien tai theo luong xu ly.
                : value
                // Thuc thi cau lenh hien tai theo luong xu ly.
                ? [accentColor, tealAccentColor]
                // Thuc thi cau lenh hien tai theo luong xu ly.
                : offTrackColors,
          ),
        ),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: AnimatedAlign(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          duration: AppConstants.shortDuration,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Container(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            width: 20,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            height: 20,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            decoration: BoxDecoration(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              shape: BoxShape.circle,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: thumbColor,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              boxShadow: [
                // Goi ham de thuc thi tac vu can thiet.
                BoxShadow(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.12),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  blurRadius: 6,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
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

// Dinh nghia lop _ProfilePalette de gom nhom logic lien quan.
class _ProfilePalette {
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color background;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color gradientTop;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color gradientBottom;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color surface;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color surfaceSoft;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color accent;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color tealAccent;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color textPrimary;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color textSecondary;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color textMuted;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color cardBorder;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color divider;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color iconContainer;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color bottomNavBackground;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color bottomNavBorder;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color bottomNavSelectedBackground;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color bottomNavSelectedBorder;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color navUnselected;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color logoutBackground;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color logoutForeground;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color logoutBorder;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color dialogBackground;

  // Khai bao bien _ProfilePalette de luu du lieu su dung trong xu ly.
  const _ProfilePalette({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.background,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.gradientTop,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.gradientBottom,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.surface,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.surfaceSoft,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.accent,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.tealAccent,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.textPrimary,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.textSecondary,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.textMuted,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.cardBorder,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.divider,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.iconContainer,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.bottomNavBackground,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.bottomNavBorder,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.bottomNavSelectedBackground,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.bottomNavSelectedBorder,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.navUnselected,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.logoutBackground,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.logoutForeground,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.logoutBorder,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.dialogBackground,
  });

  // Thuc thi cau lenh hien tai theo luong xu ly.
  factory _ProfilePalette.fromTheme(ThemeData theme) {
    // Khai bao bien isDark de luu du lieu su dung trong xu ly.
    final isDark = theme.brightness == Brightness.dark;
    // Khai bao bien onSurface de luu du lieu su dung trong xu ly.
    final onSurface = theme.colorScheme.onSurface;

    // Tra ve ket qua cho noi goi ham.
    return _ProfilePalette(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      background: isDark ? const Color(0xFF07080A) : const Color(0xFFF4F7FB),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      gradientTop: isDark ? const Color(0xFF14161A) : const Color(0xFFFBFCFF),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      gradientBottom: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? const Color(0xFF060709)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : const Color(0xFFEEF2F8),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      surface: isDark ? const Color(0xFF16181D) : Colors.white,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      surfaceSoft: isDark ? const Color(0xFF1A1D22) : const Color(0xFFF2F5FA),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      accent: const Color(0xFFD8AD48),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      tealAccent: const Color(0xFF09B7A3),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      textPrimary: onSurface,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      textSecondary: onSurface.withValues(alpha: isDark ? 0.7 : 0.74),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      textMuted: onSurface.withValues(alpha: isDark ? 0.52 : 0.58),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      cardBorder: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? Colors.white.withValues(alpha: 0.07)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : Colors.black.withValues(alpha: 0.08),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      divider: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? Colors.white.withValues(alpha: 0.05)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : Colors.black.withValues(alpha: 0.06),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      iconContainer: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? Colors.white.withValues(alpha: 0.03)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : Colors.black.withValues(alpha: 0.03),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      bottomNavBackground: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? const Color(0xFF111317)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : const Color(0xFFF9FBFF),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      bottomNavBorder: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? Colors.white.withValues(alpha: 0.06)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : Colors.black.withValues(alpha: 0.08),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      bottomNavSelectedBackground: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? const Color(0xFF191B1F)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : const Color(0xFFF5ECD6),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      bottomNavSelectedBorder: const Color(
        // Thuc thi cau lenh hien tai theo luong xu ly.
        0xFFD8AD48,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      ).withValues(alpha: isDark ? 0.78 : 0.56),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      navUnselected: onSurface.withValues(alpha: isDark ? 0.62 : 0.58),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      logoutBackground: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? const Color(0xFF32131A)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : const Color(0xFFFFEEF0),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      logoutForeground: const Color(0xFFF25A65),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      logoutBorder: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? const Color(0xFFB6424A).withValues(alpha: 0.44)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : const Color(0xFFDA7D84).withValues(alpha: 0.44),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      dialogBackground: isDark ? const Color(0xFF1A1D22) : Colors.white,
    );
  }
}

// Dinh nghia lop _ProfileActionItem de gom nhom logic lien quan.
class _ProfileActionItem {
  // Khai bao bien IconData de luu du lieu su dung trong xu ly.
  final IconData icon;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String title;
  // Khai bao bien VoidCallback de luu du lieu su dung trong xu ly.
  final VoidCallback onTap;

  // Khai bao bien _ProfileActionItem de luu du lieu su dung trong xu ly.
  const _ProfileActionItem({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.icon,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.title,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.onTap,
  });
}

// Dinh nghia lop _ProfileStatData de gom nhom logic lien quan.
class _ProfileStatData {
  // Khai bao bien IconData de luu du lieu su dung trong xu ly.
  final IconData icon;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String value;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String label;

  // Khai bao bien _ProfileStatData de luu du lieu su dung trong xu ly.
  const _ProfileStatData({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.icon,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.value,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.label,
  });
}

// Dinh nghia lop _ProfileNavItem de gom nhom logic lien quan.
class _ProfileNavItem {
  // Khai bao bien IconData de luu du lieu su dung trong xu ly.
  final IconData icon;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String label;

  // Khai bao bien _ProfileNavItem de luu du lieu su dung trong xu ly.
  const _ProfileNavItem({required this.icon, required this.label});
}

// Dinh nghia lop _ProfileMetrics de gom nhom logic lien quan.
class _ProfileMetrics {
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double scale;
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double textScale;

  // Khai bao bien _ProfileMetrics de luu du lieu su dung trong xu ly.
  const _ProfileMetrics._({required this.scale, required this.textScale});

  // Thuc thi cau lenh hien tai theo luong xu ly.
  factory _ProfileMetrics.fromWidth(double width) {
    // Khai bao bien rawScale de luu du lieu su dung trong xu ly.
    final rawScale = width / 390;
    // Tra ve ket qua cho noi goi ham.
    return _ProfileMetrics._(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      scale: rawScale.clamp(0.88, 1.14).toDouble(),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      textScale: rawScale.clamp(0.92, 1.09).toDouble(),
    );
  }

  // Khai bao bien px de luu du lieu su dung trong xu ly.
  double px(double value) => value * scale;

  // Khai bao bien fs de luu du lieu su dung trong xu ly.
  double fs(double value) => value * textScale;
}
