// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';
// Nap thu vien hoac module can thiet.
import 'package:go_router/go_router.dart';
// Nap thu vien hoac module can thiet.
import 'package:flutter_svg/flutter_svg.dart';

// Nap thu vien hoac module can thiet.
import '../../../shared/constants/app_constants.dart';
// Nap thu vien hoac module can thiet.
import '../../../shared/services/service_locator.dart';
// Nap thu vien hoac module can thiet.
import '../models/mall_product_model.dart';
// Nap thu vien hoac module can thiet.
import '../services/mall_service.dart';

// Dinh nghia lop MallScreen de gom nhom logic lien quan.
class MallScreen extends StatefulWidget {
  // Khai bao bien MallScreen de luu du lieu su dung trong xu ly.
  const MallScreen({super.key});

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Thuc thi cau lenh hien tai theo luong xu ly.
  State<MallScreen> createState() => _MallScreenState();
}

// Dinh nghia lop _MallScreenState de gom nhom logic lien quan.
class _MallScreenState extends State<MallScreen> {
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const double _horizontalPadding = 14;
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const double _cardRadius = 16;

  // Dinh nghia ham _palette de xu ly nghiep vu tuong ung.
  _MallPalette _palette(BuildContext context) {
    // Tra ve ket qua cho noi goi ham.
    return _MallPalette.fromTheme(Theme.of(context));
  }

  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Map<String, String> _brandLogoByKey = {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    'toyota': 'assets/icons/brands/toyota.svg',
    // Thuc thi cau lenh hien tai theo luong xu ly.
    'honda': 'assets/icons/brands/honda.svg',
    // Thuc thi cau lenh hien tai theo luong xu ly.
    'mazda': 'assets/icons/brands/mazda.svg',
    // Thuc thi cau lenh hien tai theo luong xu ly.
    'vinfast': 'assets/icons/brands/vinfast.svg',
    // Thuc thi cau lenh hien tai theo luong xu ly.
    'mercedes': 'assets/icons/brands/mercedes.svg',
    // Thuc thi cau lenh hien tai theo luong xu ly.
    'mercedesbenz': 'assets/icons/brands/mercedes.svg',
    // Thuc thi cau lenh hien tai theo luong xu ly.
    'benz': 'assets/icons/brands/mercedes.svg',
  };

  // Khai bao bien MallService de luu du lieu su dung trong xu ly.
  final MallService _mallService = getIt<MallService>();
  // Khai bao bien TextEditingController de luu du lieu su dung trong xu ly.
  final TextEditingController _searchController = TextEditingController();

  // Khai bao bien List de luu du lieu su dung trong xu ly.
  final List<_MallCategory> _categories = const [
    // Goi ham de thuc thi tac vu can thiet.
    _MallCategory(label: 'Tất Cả', icon: Icons.grid_view_rounded),
    // Goi ham de thuc thi tac vu can thiet.
    _MallCategory(label: 'Sedan', icon: Icons.directions_car_outlined),
    // Goi ham de thuc thi tac vu can thiet.
    _MallCategory(label: 'SUV', icon: Icons.explore_outlined),
    // Goi ham de thuc thi tac vu can thiet.
    _MallCategory(label: 'Xe Điện', icon: Icons.bolt_outlined),
  ];

  // Khai bao bien _selectedCategoryIndex de luu du lieu su dung trong xu ly.
  int _selectedCategoryIndex = 0;
  // Khai bao bien _isLoading de luu du lieu su dung trong xu ly.
  bool _isLoading = true;
  // Thuc thi cau lenh hien tai theo luong xu ly.
  String? _errorMessage;
  // Khai bao bien _products de luu du lieu su dung trong xu ly.
  List<MallProduct> _products = [];
  // Khai bao bien _filteredProducts de luu du lieu su dung trong xu ly.
  List<MallProduct> _filteredProducts = [];

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Dinh nghia ham initState de xu ly nghiep vu tuong ung.
  void initState() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.initState();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _searchController.addListener(() {
      // Kiem tra dieu kien de re nhanh xu ly.
      if (mounted) {
        // Cap nhat state de giao dien duoc render lai.
        setState(() {});
      }
    });
    // Khai bao constructor _loadProducts de khoi tao doi tuong.
    _loadProducts();
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Dinh nghia ham dispose de xu ly nghiep vu tuong ung.
  void dispose() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _searchController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.dispose();
  }

  // Khai bao bien _loadProducts de luu du lieu su dung trong xu ly.
  Future<void> _loadProducts() async {
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
      final products = await _mallService.fetchProducts(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        category: _categories[_selectedCategoryIndex].label == 'Tất Cả'
            // Thuc thi cau lenh hien tai theo luong xu ly.
            ? null
            // Thuc thi cau lenh hien tai theo luong xu ly.
            : _categories[_selectedCategoryIndex].label,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        query: _searchController.text,
      );

      // Kiem tra dieu kien de re nhanh xu ly.
      if (!mounted) {
        // Tra ve ket qua cho noi goi ham.
        return;
      }

      // Cap nhat state de giao dien duoc render lai.
      setState(() {
        // Gan gia tri cho bien _products.
        _products = products;
        // Gan gia tri cho bien _filteredProducts.
        _filteredProducts = products;
      });
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } catch (_) {
      // Kiem tra dieu kien de re nhanh xu ly.
      if (!mounted) {
        // Tra ve ket qua cho noi goi ham.
        return;
      }

      // Cap nhat state de giao dien duoc render lai.
      setState(() {
        // Gan gia tri cho bien _errorMessage.
        _errorMessage = 'Không thể tải dữ liệu Mall. Vui lòng thử lại.';
      });
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } finally {
      // Kiem tra dieu kien de re nhanh xu ly.
      if (mounted) {
        // Cap nhat state de giao dien duoc render lai.
        setState(() {
          // Gan gia tri cho bien _isLoading.
          _isLoading = false;
        });
      }
    }
  }

  // Dinh nghia ham _filterProducts de xu ly nghiep vu tuong ung.
  void _filterProducts(String query) {
    // Khai bao bien normalized de luu du lieu su dung trong xu ly.
    final normalized = query.trim().toLowerCase();
    // Cap nhat state de giao dien duoc render lai.
    setState(() {
      // Gan gia tri cho bien _filteredProducts.
      _filteredProducts = _products.where((product) {
        // Khai bao bien name de luu du lieu su dung trong xu ly.
        final name = product.name.toLowerCase();
        // Khai bao bien category de luu du lieu su dung trong xu ly.
        final category = product.category.toLowerCase();
        // Tra ve ket qua cho noi goi ham.
        return normalized.isEmpty ||
            // Thuc thi cau lenh hien tai theo luong xu ly.
            name.contains(normalized) ||
            // Thuc thi cau lenh hien tai theo luong xu ly.
            category.contains(normalized);
      // Thuc thi cau lenh hien tai theo luong xu ly.
      }).toList();
    });
  }

  // Dinh nghia ham _onCategorySelected de xu ly nghiep vu tuong ung.
  void _onCategorySelected(int index) {
    // Cap nhat state de giao dien duoc render lai.
    setState(() => _selectedCategoryIndex = index);
    // Khai bao constructor _loadProducts de khoi tao doi tuong.
    _loadProducts();
  }

  // Thuc thi cau lenh hien tai theo luong xu ly.
  String? get _bannerImageUrl {
    // Lap qua tap du lieu theo dieu kien xac dinh.
    for (final product in _filteredProducts) {
      // Kiem tra dieu kien de re nhanh xu ly.
      if (product.imageUrl.trim().isNotEmpty) {
        // Tra ve ket qua cho noi goi ham.
        return product.imageUrl;
      }
    }

    // Lap qua tap du lieu theo dieu kien xac dinh.
    for (final product in _products) {
      // Kiem tra dieu kien de re nhanh xu ly.
      if (product.imageUrl.trim().isNotEmpty) {
        // Tra ve ket qua cho noi goi ham.
        return product.imageUrl;
      }
    }

    // Tra ve ket qua cho noi goi ham.
    return null;
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
    ScaffoldMessenger.of(context)
      // Thuc thi cau lenh hien tai theo luong xu ly.
      ..hideCurrentSnackBar()
      // Thuc thi cau lenh hien tai theo luong xu ly.
      ..showSnackBar(
        // Goi ham de thuc thi tac vu can thiet.
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return Scaffold(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      backgroundColor: palette.background,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      body: SafeArea(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        bottom: false,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: RefreshIndicator(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          color: palette.accent,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          backgroundColor: palette.surface,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          onRefresh: _loadProducts,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: CustomScrollView(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            physics: const BouncingScrollPhysics(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              parent: AlwaysScrollableScrollPhysics(),
            ),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            slivers: [
              // Goi ham de thuc thi tac vu can thiet.
              SliverPadding(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                padding: const EdgeInsets.fromLTRB(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  _horizontalPadding,
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  15,
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  _horizontalPadding,
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  8,
                ),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                sliver: SliverList(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  delegate: SliverChildListDelegate.fixed([
                    // Goi ham de thuc thi tac vu can thiet.
                    _buildHeader(),
                    // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                    const SizedBox(height: 14),
                    // Goi ham de thuc thi tac vu can thiet.
                    _buildSearchField(),
                    // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                    const SizedBox(height: 10),
                    // Goi ham de thuc thi tac vu can thiet.
                    _buildCategoryTabs(),
                    // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                    const SizedBox(height: 12),
                    // Goi ham de thuc thi tac vu can thiet.
                    _buildHeroBanner(),
                    // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                    const SizedBox(height: 16),
                    // Goi ham de thuc thi tac vu can thiet.
                    _buildSectionHeader(),
                    // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                    const SizedBox(height: 10),
                  ]),
                ),
              ),
              // Thuc thi cau lenh hien tai theo luong xu ly.
              ..._buildContentSlivers(context),
              // Khai bao bien SliverToBoxAdapter de luu du lieu su dung trong xu ly.
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ],
          ),
        ),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // Khai bao bien _buildHeader de luu du lieu su dung trong xu ly.
  Widget _buildHeader() {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return Row(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      children: [
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
                'Khám phá',
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: palette.textSecondary,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontSize: 14,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontWeight: FontWeight.w500,
                ),
              ),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 3),
              // Goi ham de thuc thi tac vu can thiet.
              Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                'Trung Tâm Xe',
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: palette.textPrimary,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontWeight: FontWeight.w800,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontSize: 24,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  height: 1.03,
                ),
              ),
            ],
          ),
        ),
        // Goi ham de thuc thi tac vu can thiet.
        Container(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          decoration: BoxDecoration(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: palette.surfaceSoft,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            borderRadius: BorderRadius.circular(13),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            border: Border.all(color: palette.cardBorder),
          ),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: IconButton(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onPressed: _loadProducts,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            icon: Icon(Icons.tune, color: palette.accent, size: 21),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            padding: const EdgeInsets.all(12),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            constraints: const BoxConstraints.tightFor(width: 46, height: 46),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            tooltip: 'Làm mới',
          ),
        ),
      ],
    );
  }

  // Khai bao bien _buildSearchField de luu du lieu su dung trong xu ly.
  Widget _buildSearchField() {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return TextField(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      controller: _searchController,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      onChanged: _filterProducts,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: InputDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        hintText: 'Tìm kiếm xe...',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        hintStyle: TextStyle(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          color: palette.textMuted,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          fontSize: 14,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          fontWeight: FontWeight.w500,
        ),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        prefixIcon: Icon(Icons.search, size: 20, color: palette.textSecondary),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        suffixIcon: _searchController.text.isNotEmpty
            // Thuc thi cau lenh hien tai theo luong xu ly.
            ? IconButton(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                icon: Icon(Icons.close, size: 18, color: palette.textSecondary),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                onPressed: () {
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  _searchController.clear();
                  // Khai bao constructor _filterProducts de khoi tao doi tuong.
                  _filterProducts('');
                },
              )
            // Thuc thi cau lenh hien tai theo luong xu ly.
            : null,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        filled: true,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        fillColor: palette.surface,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: OutlineInputBorder(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderRadius: BorderRadius.circular(14),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderSide: BorderSide(color: palette.cardBorder),
        ),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        enabledBorder: OutlineInputBorder(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderRadius: BorderRadius.circular(14),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderSide: BorderSide(color: palette.cardBorder),
        ),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        focusedBorder: OutlineInputBorder(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderRadius: BorderRadius.circular(14),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderSide: BorderSide(color: palette.accent, width: 1.1),
        ),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      style: TextStyle(color: palette.textPrimary, fontSize: 14.5),
    );
  }

  // Khai bao bien _buildCategoryTabs de luu du lieu su dung trong xu ly.
  Widget _buildCategoryTabs() {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return SingleChildScrollView(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      scrollDirection: Axis.horizontal,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Row(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: List.generate(_categories.length, (index) {
          // Khai bao bien category de luu du lieu su dung trong xu ly.
          final category = _categories[index];
          // Khai bao bien isSelected de luu du lieu su dung trong xu ly.
          final isSelected = index == _selectedCategoryIndex;

          // Tra ve ket qua cho noi goi ham.
          return Padding(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            padding: const EdgeInsets.only(right: 8),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: InkWell(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              onTap: () => _onCategorySelected(index),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              borderRadius: BorderRadius.circular(18),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              child: AnimatedContainer(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                duration: AppConstants.shortDuration,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                padding: const EdgeInsets.symmetric(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  horizontal: 12,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  vertical: 8,
                ),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                decoration: BoxDecoration(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: isSelected ? palette.accent : palette.surface,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  borderRadius: BorderRadius.circular(18),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  border: Border.all(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: isSelected ? palette.accent : palette.cardBorder,
                  ),
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
                      category.icon,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      size: 14,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      color: isSelected
                          // Thuc thi cau lenh hien tai theo luong xu ly.
                          ? palette.accentForeground
                          // Thuc thi cau lenh hien tai theo luong xu ly.
                          : palette.textSecondary,
                    ),
                    // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                    const SizedBox(width: 6),
                    // Goi ham de thuc thi tac vu can thiet.
                    Text(
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      category.label,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        color: isSelected
                            // Thuc thi cau lenh hien tai theo luong xu ly.
                            ? palette.accentForeground
                            // Thuc thi cau lenh hien tai theo luong xu ly.
                            : palette.textPrimary,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        fontWeight: FontWeight.w700,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
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

  // Khai bao bien _buildHeroBanner de luu du lieu su dung trong xu ly.
  Widget _buildHeroBanner() {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);
    // Khai bao bien imageUrl de luu du lieu su dung trong xu ly.
    final imageUrl = _bannerImageUrl;

    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      height: 164,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.surface,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(18),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: Border.all(color: palette.cardBorder),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      clipBehavior: Clip.antiAlias,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Stack(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: [
          // Thuc thi cau lenh hien tai theo luong xu ly.
          Positioned.fill(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: imageUrl == null
                // Thuc thi cau lenh hien tai theo luong xu ly.
                ? Image.asset('assets/images/MustangBg.webp', fit: BoxFit.cover)
                // Thuc thi cau lenh hien tai theo luong xu ly.
                : Image.network(
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    imageUrl,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fit: BoxFit.cover,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    errorBuilder: (context, error, stackTrace) {
                      // Tra ve ket qua cho noi goi ham.
                      return Image.asset(
                        // Thuc thi cau lenh hien tai theo luong xu ly.
                        'assets/images/MustangBg.webp',
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        fit: BoxFit.cover,
                      );
                    },
                  ),
          ),
          // Thuc thi cau lenh hien tai theo luong xu ly.
          Positioned.fill(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: DecoratedBox(
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
                    Colors.black.withValues(alpha: 0.2),
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    Colors.black.withValues(alpha: 0.72),
                  ],
                ),
              ),
            ),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          Positioned(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            left: 12,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            top: 12,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Container(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              decoration: BoxDecoration(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                color: Colors.black.withValues(alpha: 0.38),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                borderRadius: BorderRadius.circular(11),
              ),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              child: Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                'KHO TRƯNG BÀY',
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: palette.accent,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontSize: 10,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  letterSpacing: 0.7,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          Positioned(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            left: 12,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            right: 12,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            top: 41,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Text(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              'Xe Mới 2024',
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                color: Colors.white,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                fontWeight: FontWeight.w800,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                fontSize: 33,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                height: 1,
              ),
            ),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          Positioned(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            left: 12,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            right: 12,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            top: 78,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Text(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              'Lựa chọn đa dạng với mức giá tốt cho mọi nhu cầu di chuyển.',
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                color: Colors.white.withValues(alpha: 0.72),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                fontSize: 11,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                height: 1.35,
              ),
            ),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          Positioned(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            left: 12,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            bottom: 10,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: FilledButton(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              onPressed: () {
                // Khai bao constructor _showFeatureComingSoon de khoi tao doi tuong.
                _showFeatureComingSoon('Danh mục nổi bật sẽ sớm được mở rộng.');
              },
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              style: FilledButton.styleFrom(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                backgroundColor: palette.accent,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                foregroundColor: palette.accentForeground,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                padding: const EdgeInsets.symmetric(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  horizontal: 16,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  vertical: 10,
                ),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                shape: RoundedRectangleBorder(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              child: const Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                'Xem Ngay',
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Khai bao bien _buildSectionHeader de luu du lieu su dung trong xu ly.
  Widget _buildSectionHeader() {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return Row(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      children: [
        // Goi ham de thuc thi tac vu can thiet.
        Text(
          // Thuc thi cau lenh hien tai theo luong xu ly.
          'Danh Sách Xe',
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: palette.textPrimary,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            fontWeight: FontWeight.w800,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            fontSize: 29,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            height: 1,
          ),
        ),
        // Khai bao bien Spacer de luu du lieu su dung trong xu ly.
        const Spacer(),
        // Goi ham de thuc thi tac vu can thiet.
        Text(
          // Thuc thi cau lenh hien tai theo luong xu ly.
          '${_filteredProducts.length} xe',
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: palette.textSecondary,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            fontWeight: FontWeight.w600,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  // Khai bao bien _normalizeBrandKey de luu du lieu su dung trong xu ly.
  String _normalizeBrandKey(String brand) {
    // Tra ve ket qua cho noi goi ham.
    return brand.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
  }

  // Khai bao bien _brandLogoAsset de luu du lieu su dung trong xu ly.
  String _brandLogoAsset(String brand) {
    // Khai bao bien key de luu du lieu su dung trong xu ly.
    final key = _normalizeBrandKey(brand);
    // Tra ve ket qua cho noi goi ham.
    return _brandLogoByKey[key] ?? 'assets/icons/brands/brand_default.svg';
  }

  // Khai bao bien _buildContentSlivers de luu du lieu su dung trong xu ly.
  List<Widget> _buildContentSlivers(BuildContext context) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Kiem tra dieu kien de re nhanh xu ly.
    if (_isLoading) {
      // Tra ve ket qua cho noi goi ham.
      return [
        // Goi ham de thuc thi tac vu can thiet.
        SliverFillRemaining(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          hasScrollBody: false,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Center(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: CircularProgressIndicator(color: palette.accent),
          ),
        ),
      ];
    }

    // Kiem tra dieu kien de re nhanh xu ly.
    if (_errorMessage != null) {
      // Tra ve ket qua cho noi goi ham.
      return [
        // Goi ham de thuc thi tac vu can thiet.
        SliverFillRemaining(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          hasScrollBody: false,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Padding(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            padding: const EdgeInsets.symmetric(horizontal: 24),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Column(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              mainAxisAlignment: MainAxisAlignment.center,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              children: [
                // Goi ham de thuc thi tac vu can thiet.
                Text(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  _errorMessage!,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  textAlign: TextAlign.center,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: Theme.of(
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    context,
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  ).textTheme.bodyLarge?.copyWith(color: palette.textSecondary),
                ),
                // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                const SizedBox(height: 12),
                // Goi ham de thuc thi tac vu can thiet.
                FilledButton(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  onPressed: _loadProducts,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: FilledButton.styleFrom(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    backgroundColor: palette.accent,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    foregroundColor: palette.accentForeground,
                  ),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  child: const Text('Thử lại'),
                ),
              ],
            ),
          ),
        ),
      ];
    }

    // Kiem tra dieu kien de re nhanh xu ly.
    if (_filteredProducts.isEmpty) {
      // Tra ve ket qua cho noi goi ham.
      return [
        // Goi ham de thuc thi tac vu can thiet.
        SliverFillRemaining(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          hasScrollBody: false,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Padding(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            padding: const EdgeInsets.symmetric(horizontal: 24),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Center(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              child: Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                'Không có sản phẩm phù hợp.',
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                textAlign: TextAlign.center,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: Theme.of(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  context,
                // Thuc thi cau lenh hien tai theo luong xu ly.
                ).textTheme.bodyLarge?.copyWith(color: palette.textSecondary),
              ),
            ),
          ),
        ),
      ];
    }

    // Tra ve ket qua cho noi goi ham.
    return [
      // Goi ham de thuc thi tac vu can thiet.
      SliverPadding(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        padding: const EdgeInsets.fromLTRB(
          // Thuc thi cau lenh hien tai theo luong xu ly.
          _horizontalPadding,
          // Thuc thi cau lenh hien tai theo luong xu ly.
          0,
          // Thuc thi cau lenh hien tai theo luong xu ly.
          _horizontalPadding,
          // Thuc thi cau lenh hien tai theo luong xu ly.
          0,
        ),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        sliver: SliverGrid(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          delegate: SliverChildBuilderDelegate((context, index) {
            // Khai bao bien product de luu du lieu su dung trong xu ly.
            final product = _filteredProducts[index];
            // Tra ve ket qua cho noi goi ham.
            return _buildProductCard(product);
          // Thuc thi cau lenh hien tai theo luong xu ly.
          }, childCount: _filteredProducts.length),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            crossAxisCount: 2,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            mainAxisSpacing: 10,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            crossAxisSpacing: 10,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            childAspectRatio: 0.82,
          ),
        ),
      ),
    ];
  }

  // Khai bao bien _buildProductCard de luu du lieu su dung trong xu ly.
  Widget _buildProductCard(MallProduct product) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.surface,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(_cardRadius),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: Border.all(color: palette.cardBorder),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: const EdgeInsets.all(11),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Column(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        crossAxisAlignment: CrossAxisAlignment.start,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: [
          // Goi ham de thuc thi tac vu can thiet.
          Row(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Goi ham de thuc thi tac vu can thiet.
              _buildBrandLogo(product),
              // Khai bao bien Spacer de luu du lieu su dung trong xu ly.
              const Spacer(),
              // Goi ham de thuc thi tac vu can thiet.
              Container(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                decoration: BoxDecoration(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: product.badgeColorValue.withValues(alpha: 0.16),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  borderRadius: BorderRadius.circular(999),
                ),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: Text(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  product.badgeLabel,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: product.badgeColorValue,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontWeight: FontWeight.w700,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
          const SizedBox(height: 11),
          // Goi ham de thuc thi tac vu can thiet.
          Text(
            // Thuc thi cau lenh hien tai theo luong xu ly.
            product.name,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            maxLines: 2,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            overflow: TextOverflow.ellipsis,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: palette.textPrimary,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              fontWeight: FontWeight.w800,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              fontSize: 15,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              height: 1.15,
            ),
          ),
          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
          const SizedBox(height: 4),
          // Goi ham de thuc thi tac vu can thiet.
          Text(
            // Thuc thi cau lenh hien tai theo luong xu ly.
            '${product.year} · ${product.category}',
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            maxLines: 1,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            overflow: TextOverflow.ellipsis,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: palette.textSecondary,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              fontSize: 12,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              height: 1.2,
            ),
          ),
          // Khai bao bien Spacer de luu du lieu su dung trong xu ly.
          const Spacer(),
          // Goi ham de thuc thi tac vu can thiet.
          Row(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Goi ham de thuc thi tac vu can thiet.
              Icon(Icons.star_rounded, size: 14, color: palette.accent),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(width: 3),
              // Goi ham de thuc thi tac vu can thiet.
              Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                product.rating.toStringAsFixed(1),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: palette.textPrimary.withValues(alpha: 0.82),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontWeight: FontWeight.w600,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontSize: 11.5,
                ),
              ),
              // Khai bao bien Spacer de luu du lieu su dung trong xu ly.
              const Spacer(),
              // Goi ham de thuc thi tac vu can thiet.
              Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                'Kho: ${product.stock}',
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: palette.textMuted,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontSize: 11.5,
                ),
              ),
            ],
          ),
          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
          const SizedBox(height: 5),
          // Goi ham de thuc thi tac vu can thiet.
          Text(
            // Thuc thi cau lenh hien tai theo luong xu ly.
            product.priceLabel,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: palette.accent,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              fontWeight: FontWeight.w800,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              fontSize: 28,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  // Khai bao bien _buildBrandLogo de luu du lieu su dung trong xu ly.
  Widget _buildBrandLogo(MallProduct product) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      height: 44,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      width: 44,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.surfaceSoft,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(12),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: const EdgeInsets.all(7),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: SvgPicture.asset(
        // Goi ham de thuc thi tac vu can thiet.
        _brandLogoAsset(product.brand),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        fit: BoxFit.contain,
      ),
    );
  }

  // Khai bao bien _buildBottomNavigationBar de luu du lieu su dung trong xu ly.
  Widget _buildBottomNavigationBar() {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Khai bao bien navItems de luu du lieu su dung trong xu ly.
    const navItems = [
      // Goi ham de thuc thi tac vu can thiet.
      _MallBottomNavItem(icon: Icons.home_outlined, label: 'Trang Chủ'),
      // Goi ham de thuc thi tac vu can thiet.
      _MallBottomNavItem(icon: Icons.shopping_bag_outlined, label: 'Mall'),
      // Goi ham de thuc thi tac vu can thiet.
      _MallBottomNavItem(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.notifications_none_rounded,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        label: 'Thông Báo',
      ),
      // Goi ham de thuc thi tac vu can thiet.
      _MallBottomNavItem(icon: Icons.person_outline_rounded, label: 'Tôi'),
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
          padding: const EdgeInsets.fromLTRB(8, 7, 8, 6),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Row(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: List.generate(navItems.length, (index) {
              // Khai bao bien item de luu du lieu su dung trong xu ly.
              final item = navItems[index];
              // Khai bao bien isSelected de luu du lieu su dung trong xu ly.
              final isSelected = index == 1;

              // Tra ve ket qua cho noi goi ham.
              return Expanded(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: InkWell(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  onTap: () => _onBottomTabSelected(index),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  borderRadius: BorderRadius.circular(12),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  child: AnimatedContainer(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    duration: AppConstants.shortDuration,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    decoration: BoxDecoration(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      color: isSelected
                          // Thuc thi cau lenh hien tai theo luong xu ly.
                          ? palette.navSelectedBackground
                          // Thuc thi cau lenh hien tai theo luong xu ly.
                          : Colors.transparent,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      borderRadius: BorderRadius.circular(11),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      border: Border.all(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        color: isSelected
                            // Thuc thi cau lenh hien tai theo luong xu ly.
                            ? palette.navSelectedBorder
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
                          size: 19,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          color: isSelected
                              // Thuc thi cau lenh hien tai theo luong xu ly.
                              ? palette.accent
                              // Thuc thi cau lenh hien tai theo luong xu ly.
                              : palette.navUnselected,
                        ),
                        // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                        const SizedBox(height: 3),
                        // Goi ham de thuc thi tac vu can thiet.
                        Text(
                          // Thuc thi cau lenh hien tai theo luong xu ly.
                          item.label,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          style: Theme.of(context).textTheme.labelSmall
                              // Thuc thi cau lenh hien tai theo luong xu ly.
                              ?.copyWith(
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

// Dinh nghia lop _MallCategory de gom nhom logic lien quan.
class _MallCategory {
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String label;
  // Khai bao bien IconData de luu du lieu su dung trong xu ly.
  final IconData icon;

  // Khai bao bien _MallCategory de luu du lieu su dung trong xu ly.
  const _MallCategory({required this.label, required this.icon});
}

// Dinh nghia lop _MallBottomNavItem de gom nhom logic lien quan.
class _MallBottomNavItem {
  // Khai bao bien IconData de luu du lieu su dung trong xu ly.
  final IconData icon;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String label;

  // Khai bao bien _MallBottomNavItem de luu du lieu su dung trong xu ly.
  const _MallBottomNavItem({required this.icon, required this.label});
}

// Dinh nghia lop _MallPalette de gom nhom logic lien quan.
class _MallPalette {
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color background;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color surface;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color surfaceSoft;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color accent;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color accentForeground;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color cardBorder;
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

  // Khai bao bien _MallPalette de luu du lieu su dung trong xu ly.
  const _MallPalette({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.background,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.surface,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.surfaceSoft,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.accent,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.accentForeground,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.cardBorder,
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
  factory _MallPalette.fromTheme(ThemeData theme) {
    // Khai bao bien isDark de luu du lieu su dung trong xu ly.
    final isDark = theme.brightness == Brightness.dark;
    // Khai bao bien onSurface de luu du lieu su dung trong xu ly.
    final onSurface = theme.colorScheme.onSurface;

    // Tra ve ket qua cho noi goi ham.
    return _MallPalette(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      background: isDark ? const Color(0xFF0A0B0E) : const Color(0xFFF6F8FC),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      surface: isDark ? const Color(0xFF15181D) : Colors.white,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      surfaceSoft: isDark ? const Color(0xFF1A1D22) : const Color(0xFFF0F3F8),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      accent: const Color(0xFFD6A93E),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      accentForeground: isDark ? Colors.black : const Color(0xFF2D230F),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      cardBorder: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? Colors.white.withValues(alpha: 0.06)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : Colors.black.withValues(alpha: 0.08),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      textPrimary: onSurface,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      textSecondary: onSurface.withValues(alpha: isDark ? 0.65 : 0.72),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      textMuted: onSurface.withValues(alpha: isDark ? 0.52 : 0.58),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      navBackground: isDark ? const Color(0xFF111317) : const Color(0xFFF9FBFF),
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
          : const Color(0xFFF3E8CD),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      navSelectedBorder: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? Colors.white.withValues(alpha: 0.72)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : const Color(0xFFC89B34).withValues(alpha: 0.52),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      navUnselected: onSurface.withValues(alpha: isDark ? 0.68 : 0.62),
    );
  }
}
