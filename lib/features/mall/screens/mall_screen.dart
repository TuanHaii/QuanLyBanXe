import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../shared/constants/app_constants.dart';
import '../../../shared/services/service_locator.dart';
import '../models/mall_product_model.dart';
import '../services/mall_service.dart';

class MallScreen extends StatefulWidget {
  const MallScreen({super.key});

  @override
  State<MallScreen> createState() => _MallScreenState();
}

class _MallScreenState extends State<MallScreen> {
  static const Color _backgroundColor = Color(0xFF0A0B0E);
  static const Color _surfaceColor = Color(0xFF15181D);
  static const Color _surfaceLightColor = Color(0xFF1A1D22);
  static const Color _accentColor = Color(0xFFD6A93E);
  static const double _horizontalPadding = 14;
  static const double _cardRadius = 16;

  static const Map<String, String> _brandLogoByKey = {
    'toyota': 'assets/icons/brands/toyota.svg',
    'honda': 'assets/icons/brands/honda.svg',
    'mazda': 'assets/icons/brands/mazda.svg',
    'vinfast': 'assets/icons/brands/vinfast.svg',
    'mercedes': 'assets/icons/brands/mercedes.svg',
    'mercedesbenz': 'assets/icons/brands/mercedes.svg',
    'benz': 'assets/icons/brands/mercedes.svg',
  };

  final MallService _mallService = getIt<MallService>();
  final TextEditingController _searchController = TextEditingController();

  final List<_MallCategory> _categories = const [
    _MallCategory(label: 'Tất Cả', icon: Icons.grid_view_rounded),
    _MallCategory(label: 'Sedan', icon: Icons.directions_car_outlined),
    _MallCategory(label: 'SUV', icon: Icons.explore_outlined),
    _MallCategory(label: 'Xe Điện', icon: Icons.bolt_outlined),
  ];

  int _selectedCategoryIndex = 0;
  bool _isLoading = true;
  String? _errorMessage;
  List<MallProduct> _products = [];
  List<MallProduct> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    _loadProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final products = await _mallService.fetchProducts(
        category: _categories[_selectedCategoryIndex].label == 'Tất Cả'
            ? null
            : _categories[_selectedCategoryIndex].label,
        query: _searchController.text,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _products = products;
        _filteredProducts = products;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _errorMessage = 'Không thể tải dữ liệu Mall. Vui lòng thử lại.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _filterProducts(String query) {
    final normalized = query.trim().toLowerCase();
    setState(() {
      _filteredProducts = _products.where((product) {
        final name = product.name.toLowerCase();
        final category = product.category.toLowerCase();
        return normalized.isEmpty ||
            name.contains(normalized) ||
            category.contains(normalized);
      }).toList();
    });
  }

  void _onCategorySelected(int index) {
    setState(() => _selectedCategoryIndex = index);
    _loadProducts();
  }

  String? get _bannerImageUrl {
    for (final product in _filteredProducts) {
      if (product.imageUrl.trim().isNotEmpty) {
        return product.imageUrl;
      }
    }

    for (final product in _products) {
      if (product.imageUrl.trim().isNotEmpty) {
        return product.imageUrl;
      }
    }

    return null;
  }

  void _onBottomTabSelected(int index) {
    switch (index) {
      case 0:
        context.go(RouteNames.dashboard);
        return;
      case 1:
        return;
      case 2:
        context.go(RouteNames.notification);
        return;
      case 3:
        context.go(RouteNames.profile);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          color: _accentColor,
          backgroundColor: _surfaceColor,
          onRefresh: _loadProducts,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  _horizontalPadding,
                  15,
                  _horizontalPadding,
                  8,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate.fixed([
                    _buildHeader(),
                    const SizedBox(height: 14),
                    _buildSearchField(),
                    const SizedBox(height: 10),
                    _buildCategoryTabs(),
                    const SizedBox(height: 12),
                    _buildHeroBanner(),
                    const SizedBox(height: 16),
                    _buildSectionHeader(),
                    const SizedBox(height: 10),
                  ]),
                ),
              ),
              ..._buildContentSlivers(context),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Khám phá',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.55),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'Trung Tâm Xe',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                  height: 1.03,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: _surfaceLightColor,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
          ),
          child: IconButton(
            onPressed: _loadProducts,
            icon: const Icon(Icons.tune, color: _accentColor, size: 21),
            padding: const EdgeInsets.all(12),
            constraints: const BoxConstraints.tightFor(width: 46, height: 46),
            tooltip: 'Làm mới',
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      onChanged: _filterProducts,
      decoration: InputDecoration(
        hintText: 'Tìm kiếm xe...',
        hintStyle: TextStyle(
          color: Colors.white.withValues(alpha: 0.46),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(
          Icons.search,
          size: 20,
          color: Colors.white.withValues(alpha: 0.56),
        ),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: Icon(
                  Icons.close,
                  size: 18,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
                onPressed: () {
                  _searchController.clear();
                  _filterProducts('');
                },
              )
            : null,
        filled: true,
        fillColor: _surfaceColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _accentColor, width: 1.1),
        ),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 14.5),
    );
  }

  Widget _buildCategoryTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_categories.length, (index) {
          final category = _categories[index];
          final isSelected = index == _selectedCategoryIndex;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () => _onCategorySelected(index),
              borderRadius: BorderRadius.circular(18),
              child: AnimatedContainer(
                duration: AppConstants.shortDuration,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? _accentColor : _surfaceColor,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isSelected
                        ? _accentColor
                        : Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      category.icon,
                      size: 14,
                      color: isSelected ? Colors.black : Colors.white70,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      category.label,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: isSelected ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
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

  Widget _buildHeroBanner() {
    final imageUrl = _bannerImageUrl;

    return Container(
      height: 164,
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: imageUrl == null
                ? Image.asset('assets/images/MustangBg.webp', fit: BoxFit.cover)
                : Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/MustangBg.webp',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.2),
                    Colors.black.withValues(alpha: 0.72),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 12,
            top: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.38),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Text(
                'KHO TRƯNG BÀY',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: _accentColor,
                  fontSize: 10,
                  letterSpacing: 0.7,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Positioned(
            left: 12,
            right: 12,
            top: 41,
            child: Text(
              'Xe Mới 2024',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 33,
                height: 1,
              ),
            ),
          ),
          Positioned(
            left: 12,
            right: 12,
            top: 78,
            child: Text(
              'Lựa chọn đa dạng với mức giá tốt cho mọi nhu cầu di chuyển.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.72),
                fontSize: 11,
                height: 1.35,
              ),
            ),
          ),
          Positioned(
            left: 12,
            bottom: 10,
            child: FilledButton(
              onPressed: () {
                _showFeatureComingSoon('Danh mục nổi bật sẽ sớm được mở rộng.');
              },
              style: FilledButton.styleFrom(
                backgroundColor: _accentColor,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Xem Ngay',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      children: [
        Text(
          'Danh Sách Xe',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 29,
            height: 1,
          ),
        ),
        const Spacer(),
        Text(
          '${_filteredProducts.length} xe',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.58),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  String _normalizeBrandKey(String brand) {
    return brand.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
  }

  String _brandLogoAsset(String brand) {
    final key = _normalizeBrandKey(brand);
    return _brandLogoByKey[key] ?? 'assets/icons/brands/brand_default.svg';
  }

  List<Widget> _buildContentSlivers(BuildContext context) {
    if (_isLoading) {
      return const [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: CircularProgressIndicator(color: _accentColor)),
        ),
      ];
    }

    if (_errorMessage != null) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: _loadProducts,
                  style: FilledButton.styleFrom(
                    backgroundColor: _accentColor,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('Thử lại'),
                ),
              ],
            ),
          ),
        ),
      ];
    }

    if (_filteredProducts.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Center(
              child: Text(
                'Không có sản phẩm phù hợp.',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
              ),
            ),
          ),
        ),
      ];
    }

    return [
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(
          _horizontalPadding,
          0,
          _horizontalPadding,
          0,
        ),
        sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate((context, index) {
            final product = _filteredProducts[index];
            return _buildProductCard(product);
          }, childCount: _filteredProducts.length),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.82,
          ),
        ),
      ),
    ];
  }

  Widget _buildProductCard(MallProduct product) {
    return Container(
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(_cardRadius),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      padding: const EdgeInsets.all(11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildBrandLogo(product),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: product.badgeColorValue.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  product.badgeLabel,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: product.badgeColorValue,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 11),
          Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 15,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${product.year} · ${product.category}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white70,
              fontSize: 12,
              height: 1.2,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              const Icon(Icons.star_rounded, size: 14, color: _accentColor),
              const SizedBox(width: 3),
              Text(
                product.rating.toStringAsFixed(1),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.82),
                  fontWeight: FontWeight.w600,
                  fontSize: 11.5,
                ),
              ),
              const Spacer(),
              Text(
                'Kho: ${product.stock}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.52),
                  fontSize: 11.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            product.priceLabel,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: _accentColor,
              fontWeight: FontWeight.w800,
              fontSize: 28,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandLogo(MallProduct product) {
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.035),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(7),
      child: SvgPicture.asset(
        _brandLogoAsset(product.brand),
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    const navItems = [
      _MallBottomNavItem(icon: Icons.home_outlined, label: 'Trang Chủ'),
      _MallBottomNavItem(icon: Icons.shopping_bag_outlined, label: 'Mall'),
      _MallBottomNavItem(
        icon: Icons.notifications_none_rounded,
        label: 'Thông Báo',
      ),
      _MallBottomNavItem(icon: Icons.person_outline_rounded, label: 'Tôi'),
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
          padding: const EdgeInsets.fromLTRB(8, 7, 8, 6),
          child: Row(
            children: List.generate(navItems.length, (index) {
              final item = navItems[index];
              final isSelected = index == 1;

              return Expanded(
                child: InkWell(
                  onTap: () => _onBottomTabSelected(index),
                  borderRadius: BorderRadius.circular(12),
                  child: AnimatedContainer(
                    duration: AppConstants.shortDuration,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF191B1F)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(
                        color: isSelected
                            ? Colors.white.withValues(alpha: 0.72)
                            : Colors.transparent,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item.icon,
                          size: 19,
                          color: isSelected
                              ? _accentColor
                              : Colors.white.withValues(alpha: 0.68),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item.label,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: isSelected
                                    ? _accentColor
                                    : Colors.white.withValues(alpha: 0.62),
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                fontSize: 10.5,
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

class _MallCategory {
  final String label;
  final IconData icon;

  const _MallCategory({required this.label, required this.icon});
}

class _MallBottomNavItem {
  final IconData icon;
  final String label;

  const _MallBottomNavItem({required this.icon, required this.label});
}
