import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/constants/app_constants.dart';
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
    // Đảm bảo app ở chế độ Dark Mode cho màn hình này
    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary: Colors.blueAccent,
          surface: Color(0xFF1E1E1E),
        ),
      ),
      child: Scaffold(
        // Sử dụng CustomScrollView để làm hiệu ứng Header cuộn
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildSliverAppBar(),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 20.0,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildGreetingSection(),
                  const SizedBox(height: 24),
                  _buildStatsGrid(),
                  const SizedBox(height: 32),
                  _buildSectionTitle('Truy cập nhanh'),
                  const SizedBox(height: 16),
                  _buildQuickActionsGrid(),
                  const SizedBox(height: 20), // Padding đáy
                ]),
              ),
            ),
          ],
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  // ===========================================================================
  // CÁC WIDGET THÀNH PHẦN (ĐƯỢC CHIA NHỎ THEO OOP)
  // ===========================================================================

  /// 1. Header có ảnh 3D và thanh cuộn trong suốt
  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 240.0,
      pinned: true,
      stretch: true,
      backgroundColor: const Color(0xFF121212).withValues(alpha: 0.8),
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: Colors.white),
          onPressed: _showNotifications,
        ),
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.white),
          onPressed: _handleLogout,
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
        title: const Text(
          'AutoFlux Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 20,
            shadows: [
              Shadow(
                color: Colors.black87,
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Thay bằng ảnh xe 3D của bạn: Image.asset('assets/images/car_bg.png')
            Image.network(
              'https://images.unsplash.com/photo-1603584173870-7f23fdae1b7a?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80',
              fit: BoxFit.cover,
            ),
            // Lớp phủ Gradient đen mờ từ dưới lên để chữ nổi bật
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.2),
                    const Color(
                      0xFF121212,
                    ).withValues(alpha: 0.95), // Khớp với màu nền ở dưới
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 2. Lời chào
  Widget _buildGreetingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Xin chào!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Chào mừng bạn đến với hệ thống quản lý bán xe',
          style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.6)),
        ),
      ],
    );
  }

  /// 3. Tiêu đề các mục
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  /// 4. Lưới thống kê 4 ô
  Widget _buildStatsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.35, // Chỉnh tỷ lệ để ô nhìn vuông vắn hơn
      children: [
        const StatCard(
          title: 'Tổng xe',
          value: '156',
          icon: Icons.directions_car_rounded,
          iconColor: Color(0xFF5A84F1),
          bgColor: Color(0xFF1E2746), // Xanh Navy tối
        ),
        const StatCard(
          title: 'Đã bán',
          value: '89',
          icon: Icons.local_offer_rounded,
          iconColor: Color(0xFF4EE08F),
          bgColor: Color(0xFF1B3B2B), // Xanh Lục tối
        ),
        const StatCard(
          title: 'Còn hàng',
          value: '67',
          icon: Icons.inventory_2_rounded,
          iconColor: Color(0xFFFFB054),
          bgColor: Color(0xFF4A3419), // Cam đất tối
        ),
        const StatCard(
          title: 'Doanh thu',
          value: '12.5 tỷ',
          icon: Icons.monetization_on_rounded,
          iconColor: Color(0xFFD27DFF),
          bgColor: Color(0xFF3B2045), // Tím tối
        ),
      ],
    );
  }

  /// 5. Lưới thao tác nhanh
  Widget _buildQuickActionsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.1,
      children: [
        const ActionCard(
          title: 'Quản lý xe',
          icon: Icons.directions_car_rounded,
          color: Colors.blueAccent,
        ),
        const ActionCard(
          title: 'Bán hàng',
          icon: Icons.point_of_sale_rounded,
          color: Colors.greenAccent,
        ),
        const ActionCard(
          title: 'Thêm xe mới',
          icon: Icons.add_circle_rounded,
          color: Colors.orangeAccent,
        ),
        const ActionCard(
          title: 'Báo cáo',
          icon: Icons.bar_chart_rounded,
          color: Colors.purpleAccent,
        ),
      ],
    );
  }

  /// 6. Thanh điều hướng dưới cùng
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.05), width: 1),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: const Color(0xFF1A1A1A),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.white.withValues(alpha: 0.5),
        elevation: 0,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_rounded),
            label: 'Tổng quan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car_rounded),
            label: 'Xe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer_rounded),
            label: 'Bán hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Tài khoản',
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // CÁC HÀM XỬ LÝ SỰ KIỆN (Mock)
  // ===========================================================================
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
