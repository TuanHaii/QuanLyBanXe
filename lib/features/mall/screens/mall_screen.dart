import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/constants/app_constants.dart';
import '../../../shared/themes/app_colors.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  int _selectedCategoryIndex = 0;

  static const List<_MallCategory> _categories = [
    _MallCategory(label: 'Tất Cả', icon: Icons.grid_view_rounded),
    _MallCategory(label: 'Sedan', icon: Icons.directions_car_outlined),
    _MallCategory(label: 'SUV', icon: Icons.explore_outlined),
    _MallCategory(label: 'Xe Điện', icon: Icons.bolt_outlined),
  ];

  static const List<_MallCarItem> _cars = [
    _MallCarItem(
      name: 'Toyota Camry',
      year: 2024,
      category: 'Sedan',
      fuelType: 'Xăng',
      priceLabel: '1.2 tỷ',
      stock: 12,
      rating: 4.8,
      badgeLabel: 'Phổ Biến',
      badgeColor: Color(0xFF9A7B2F),
    ),
    _MallCarItem(
      name: 'Honda CR-V',
      year: 2024,
      category: 'SUV',
      fuelType: 'Xăng',
      priceLabel: '990 triệu',
      stock: 8,
      rating: 4.7,
      badgeLabel: 'Mới',
      badgeColor: Color(0xFF0B8F5A),
    ),
    _MallCarItem(
      name: 'VinFast VF 8',
      year: 2024,
      category: 'Xe Điện',
      fuelType: 'Điện',
      priceLabel: '1.05 tỷ',
      stock: 5,
      rating: 4.9,
      badgeLabel: 'Điện',
      badgeColor: Color(0xFF2F74D0),
    ),
    _MallCarItem(
      name: 'Mazda CX-5',
      year: 2024,
      category: 'SUV',
      fuelType: 'Xăng',
      priceLabel: '880 triệu',
      stock: 15,
      rating: 4.6,
      badgeLabel: 'Giảm Giá',
      badgeColor: Color(0xFFB74949),
    ),
    _MallCarItem(
      name: 'Mercedes C300',
      year: 2024,
      category: 'Sedan',
      fuelType: 'Xăng',
      priceLabel: '2.05 tỷ',
      stock: 3,
      rating: 4.9,
      badgeLabel: 'Hạng Sang',
      badgeColor: Color(0xFF626D82),
    ),
    _MallCarItem(
      name: 'Kia EV6',
      year: 2024,
      category: 'Xe Điện',
      fuelType: 'Điện',
      priceLabel: '1.38 tỷ',
      stock: 6,
      rating: 4.8,
      badgeLabel: 'Nổi Bật',
      badgeColor: Color(0xFF5E50B2),
    ),
  ];

  static const List<_MallNavItem> _navItems = [
    _MallNavItem(icon: Icons.home_outlined, label: 'Trang Chủ'),
    _MallNavItem(icon: Icons.storefront_outlined, label: 'Mall'),
    _MallNavItem(icon: Icons.notifications_none_rounded, label: 'Thông Báo'),
    _MallNavItem(icon: Icons.person_outline_rounded, label: 'Tôi'),
  ];

  String _searchQuery = '';

  List<_MallCarItem> get _filteredCars {
    final selectedCategory = _categories[_selectedCategoryIndex].label;
    final normalizedQuery = _searchQuery.trim().toLowerCase();

    return _cars.where((car) {
      final isCategoryMatch =
          selectedCategory == 'Tất Cả' || car.category == selectedCategory;
      final isSearchMatch =
          normalizedQuery.isEmpty || car.name.toLowerCase().contains(normalizedQuery);

      return isCategoryMatch && isSearchMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final metrics = _MallMetrics.fromWidth(MediaQuery.sizeOf(context).width);
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
              colors: [Color(0xFF171A1F), Color(0xFF090A0C)],
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
                        _buildTopHeader(metrics),
                        SizedBox(height: metrics.px(12)),
                        _buildSearchField(metrics),
                        SizedBox(height: metrics.px(12)),
                        _buildCategoryTabs(metrics),
                        SizedBox(height: metrics.px(12)),
                        _buildShowcaseBanner(metrics),
                        SizedBox(height: metrics.px(14)),
                        _buildSectionTitle(metrics),
                        SizedBox(height: metrics.px(10)),
                        _buildCarGrid(metrics),
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

  Widget _buildTopHeader(_MallMetrics metrics) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Khám phá',
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: metrics.fs(12),
                color: Colors.white.withValues(alpha: 0.62),
              ),
            ),
            SizedBox(height: metrics.px(2)),
            Text(
              'Trung Tâm Xe',
              style: AppTextStyles.titleLarge.copyWith(
                fontSize: metrics.fs(35),
                fontWeight: FontWeight.w700,
                color: Colors.white,
                height: 1,
              ),
            ),
          ],
        ),
        _buildIconButton(
          metrics: metrics,
          icon: Icons.tune_rounded,
          onTap: () => _showInfo('Bộ lọc nâng cao sẽ sớm được cập nhật.'),
        ),
      ],
    );
  }

  Widget _buildIconButton({
    required _MallMetrics metrics,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkResponse(
        onTap: onTap,
        radius: metrics.px(22),
        highlightShape: BoxShape.circle,
        splashColor: Colors.white.withValues(alpha: 0.1),
        child: Container(
          width: metrics.px(38),
          height: metrics.px(38),
          decoration: BoxDecoration(
            color: const Color(0xFF191C21),
            borderRadius: BorderRadius.circular(metrics.px(12)),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.06),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            size: metrics.px(20),
            color: const Color(0xFFE0B54E),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(_MallMetrics metrics) {
    return Container(
      height: metrics.px(44),
      padding: EdgeInsets.symmetric(horizontal: metrics.px(12)),
      decoration: BoxDecoration(
        color: const Color(0xFF16191E),
        borderRadius: BorderRadius.circular(metrics.px(14)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06), width: 1),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            color: Colors.white.withValues(alpha: 0.55),
            size: metrics.px(20),
          ),
          SizedBox(width: metrics.px(8)),
          Expanded(
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: metrics.fs(13),
                color: Colors.white,
              ),
              cursorColor: const Color(0xFFE0B54E),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Tìm kiếm xe...',
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  fontSize: metrics.fs(13),
                  color: Colors.white.withValues(alpha: 0.42),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs(_MallMetrics metrics) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_categories.length, (index) {
          final category = _categories[index];
          final isSelected = _selectedCategoryIndex == index;

          return Padding(
            padding: EdgeInsets.only(right: metrics.px(8)),
            child: InkWell(
              onTap: () => setState(() => _selectedCategoryIndex = index),
              borderRadius: BorderRadius.circular(metrics.px(14)),
              child: AnimatedContainer(
                duration: AppConstants.shortDuration,
                padding: EdgeInsets.symmetric(
                  horizontal: metrics.px(12),
                  vertical: metrics.px(8),
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFE0B54E)
                      : const Color(0xFF14181E),
                  borderRadius: BorderRadius.circular(metrics.px(14)),
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : Colors.white.withValues(alpha: 0.08),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      category.icon,
                      size: metrics.px(15),
                      color: isSelected
                          ? const Color(0xFF1B1B1B)
                          : Colors.white.withValues(alpha: 0.68),
                    ),
                    SizedBox(width: metrics.px(6)),
                    Text(
                      category.label,
                      style: AppTextStyles.labelMedium.copyWith(
                        fontSize: metrics.fs(12),
                        fontWeight: FontWeight.w700,
                        color: isSelected
                            ? const Color(0xFF1B1B1B)
                            : Colors.white.withValues(alpha: 0.72),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildShowcaseBanner(_MallMetrics metrics) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(metrics.px(18)),
      child: SizedBox(
        height: metrics.bannerHeight,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/images/MustangBg.webp', fit: BoxFit.cover),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.2),
                    Colors.black.withValues(alpha: 0.45),
                    Colors.black.withValues(alpha: 0.88),
                  ],
                  stops: const [0.0, 0.52, 1.0],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                metrics.px(14),
                metrics.px(12),
                metrics.px(14),
                metrics.px(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'KHO TRƯNG BÀY',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: const Color(0xFFE0B54E),
                      fontWeight: FontWeight.w700,
                      fontSize: metrics.fs(10),
                      letterSpacing: metrics.px(1.2),
                    ),
                  ),
                  SizedBox(height: metrics.px(2)),
                  Text(
                    'Xe Mới 2024',
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: metrics.fs(31),
                      height: 1,
                    ),
                  ),
                  SizedBox(height: metrics.px(4)),
                  Text(
                    'Loạt xe mới vừa cập bến tại showroom trung tâm.',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.white.withValues(alpha: 0.82),
                      fontSize: metrics.fs(10.5),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: metrics.px(36),
                    child: ElevatedButton(
                      onPressed: () =>
                          _showInfo('Đang chuyển đến danh sách xe mới nhất.'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE0B54E),
                        foregroundColor: const Color(0xFF1B1B1B),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(metrics.px(20)),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: metrics.px(15),
                          vertical: 0,
                        ),
                      ),
                      child: Text(
                        'Xem Ngay',
                        style: AppTextStyles.labelLarge.copyWith(
                          fontSize: metrics.fs(13),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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

  Widget _buildSectionTitle(_MallMetrics metrics) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Danh Sách Xe',
          style: AppTextStyles.titleLarge.copyWith(
            color: Colors.white.withValues(alpha: 0.96),
            fontWeight: FontWeight.w700,
            fontSize: metrics.fs(14),
          ),
        ),
        Text(
          '${_filteredCars.length} xe',
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.white.withValues(alpha: 0.58),
            fontSize: metrics.fs(11.5),
          ),
        ),
      ],
    );
  }

  Widget _buildCarGrid(_MallMetrics metrics) {
    final cars = _filteredCars;

    if (cars.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: metrics.px(26)),
          child: Column(
            children: [
              Icon(
                Icons.search_off_rounded,
                size: metrics.px(48),
                color: Colors.white.withValues(alpha: 0.45),
              ),
              SizedBox(height: metrics.px(10)),
              Text(
                'Không tìm thấy mẫu xe phù hợp',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white.withValues(alpha: 0.72),
                  fontSize: metrics.fs(13.5),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cars.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: metrics.gridSpacing,
        crossAxisSpacing: metrics.gridSpacing,
        childAspectRatio: metrics.cardAspectRatio,
      ),
      itemBuilder: (context, index) {
        final car = cars[index];

        return Container(
          padding: EdgeInsets.fromLTRB(
            metrics.px(12),
            metrics.px(12),
            metrics.px(12),
            metrics.px(10),
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF171A1F),
            borderRadius: BorderRadius.circular(metrics.px(16)),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.06),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: metrics.px(40),
                    height: metrics.px(40),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1D2128),
                      borderRadius: BorderRadius.circular(metrics.px(12)),
                    ),
                    child: Icon(
                      Icons.local_shipping_outlined,
                      color: const Color(0xFFE0B54E),
                      size: metrics.px(23),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: metrics.px(7),
                      vertical: metrics.px(3),
                    ),
                    decoration: BoxDecoration(
                      color: car.badgeColor.withValues(alpha: 0.22),
                      borderRadius: BorderRadius.circular(metrics.px(12)),
                    ),
                    child: Text(
                      car.badgeLabel,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: car.badgeColor,
                        fontSize: metrics.fs(10),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: metrics.px(10)),
              Text(
                car.name,
                style: AppTextStyles.titleSmall.copyWith(
                  color: Colors.white,
                  fontSize: metrics.fs(17),
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: metrics.px(2)),
              Text(
                '${car.year} • ${car.fuelType}',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.white.withValues(alpha: 0.58),
                  fontSize: metrics.fs(11),
                ),
              ),
              const Spacer(),
              Text(
                car.priceLabel,
                style: AppTextStyles.titleMedium.copyWith(
                  color: const Color(0xFFE0B54E),
                  fontWeight: FontWeight.w700,
                  fontSize: metrics.fs(24),
                ),
              ),
              SizedBox(height: metrics.px(2)),
              Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: const Color(0xFFE0B54E),
                    size: metrics.px(14),
                  ),
                  SizedBox(width: metrics.px(2)),
                  Text(
                    car.rating.toStringAsFixed(1),
                    style: AppTextStyles.labelMedium.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: metrics.fs(11),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Kho: ${car.stock}',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: Colors.white.withValues(alpha: 0.58),
                      fontSize: metrics.fs(11),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(_MallMetrics metrics) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF121316),
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.06), width: 1),
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
            children: List.generate(_navItems.length, (index) {
              final item = _navItems[index];
              final isSelected = index == 1;

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
    switch (index) {
      case 0:
        context.go(RouteNames.dashboard);
        return;
      case 1:
        return;
      case 2:
        _showInfo('Chưa có thông báo mới!');
        return;
      case 3:
        _showInfo('Trang cá nhân sẽ sớm được cập nhật.');
        return;
    }
  }

  void _showInfo(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _MallCategory {
  final String label;
  final IconData icon;

  const _MallCategory({required this.label, required this.icon});
}

class _MallCarItem {
  final String name;
  final int year;
  final String category;
  final String fuelType;
  final String priceLabel;
  final int stock;
  final double rating;
  final String badgeLabel;
  final Color badgeColor;

  const _MallCarItem({
    required this.name,
    required this.year,
    required this.category,
    required this.fuelType,
    required this.priceLabel,
    required this.stock,
    required this.rating,
    required this.badgeLabel,
    required this.badgeColor,
  });
}

class _MallNavItem {
  final IconData icon;
  final String label;

  const _MallNavItem({required this.icon, required this.label});
}

class _MallMetrics {
  final double screenWidth;
  final double scale;
  final double fontScale;

  const _MallMetrics._({
    required this.screenWidth,
    required this.scale,
    required this.fontScale,
  });

  factory _MallMetrics.fromWidth(double width) {
    final rawScale = width / 390;

    return _MallMetrics._(
      screenWidth: width,
      scale: rawScale.clamp(0.88, 1.12).toDouble(),
      fontScale: rawScale.clamp(0.92, 1.08).toDouble(),
    );
  }

  bool get isCompact => screenWidth < 370;

  bool get isWide => screenWidth >= 430;

  double px(double value) => value * scale;

  double fs(double value) => value * fontScale;

  double get bannerHeight => px(158).clamp(146, 190).toDouble();

  double get gridSpacing => px(10).clamp(8, 12).toDouble();

  double get cardAspectRatio {
    if (isCompact) {
      return 0.79;
    }
    if (isWide) {
      return 0.91;
    }
    return 0.85;
  }
}
