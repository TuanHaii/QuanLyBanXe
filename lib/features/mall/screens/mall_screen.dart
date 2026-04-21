import 'package:flutter/material.dart';

import '../../../shared/services/service_locator.dart';
import '../models/mall_product_model.dart';
import '../services/mall_service.dart';

class MallScreen extends StatefulWidget {
  const MallScreen({super.key});

  @override
  State<MallScreen> createState() => _MallScreenState();
}

class _MallScreenState extends State<MallScreen> {
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
      setState(() {
        _products = products;
        _filteredProducts = products;
      });
    } catch (_) {
      setState(() {
        _errorMessage = 'Không thể tải dữ liệu Mall. Vui lòng thử lại.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mall'),
        actions: [
          IconButton(onPressed: _loadProducts, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              _buildSearchField(),
              const SizedBox(height: 12),
              _buildCategoryTabs(),
              const SizedBox(height: 12),
              Expanded(child: _buildBody()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      onChanged: _filterProducts,
      decoration: InputDecoration(
        hintText: 'Tìm kiếm xe theo tên hoặc loại...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            _searchController.clear();
            _filterProducts('');
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
        ),
      ),
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
            child: ChoiceChip(
              label: Text(category.label),
              selected: isSelected,
              onSelected: (_) => _onCategorySelected(index),
              selectedColor: const Color(0xFFE0B54E),
              backgroundColor: const Color(0xFF14181E),
              labelStyle: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_errorMessage!, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _loadProducts,
                child: const Text('Thử lại'),
              ),
            ],
          ),
        ),
      );
    }

    if (_filteredProducts.isEmpty) {
      return const Center(child: Text('Không có sản phẩm phù hợp.'));
    }

    return GridView.builder(
      itemCount: _filteredProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.74,
      ),
      itemBuilder: (context, index) {
        final product = _filteredProducts[index];
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF171A1F),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1D2128),
                    borderRadius: BorderRadius.circular(16),
                    image: product.imageUrl.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(product.imageUrl),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: product.imageUrl.isEmpty
                      ? const Center(
                          child: Icon(
                            Icons.directions_car_outlined,
                            color: Colors.white54,
                            size: 32,
                          ),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${product.year} · ${product.category}',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.priceLabel,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color(0xFFE0B54E),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: product.badgeColorValue.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      product.badgeLabel,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: product.badgeColorValue,
                        fontWeight: FontWeight.w700,
                      ),
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
}

class _MallCategory {
  final String label;
  final IconData icon;

  const _MallCategory({required this.label, required this.icon});
}
