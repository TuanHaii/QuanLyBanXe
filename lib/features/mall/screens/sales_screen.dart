import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/constants/app_constants.dart';
import '../../../shared/services/service_locator.dart';
import '../models/mall_model.dart';
import '../services/sale_service.dart';
import '../widgets/mall_list_item.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final SaleService _saleService = getIt<SaleService>();
  final TextEditingController _searchController = TextEditingController();

  bool _isLoading = true;
  String? _errorMessage;
  List<SaleModel> _sales = [];
  List<SaleModel> _filteredSales = [];

  @override
  void initState() {
    super.initState();
    _loadSales();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadSales() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final sales = await _saleService.fetchSales();
      setState(() {
        _sales = sales;
        _filteredSales = sales;
      });
    } catch (_) {
      setState(() {
        _errorMessage = 'Không thể tải danh sách bán hàng. Vui lòng thử lại.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterSales(String query) {
    final normalized = query.trim().toLowerCase();
    setState(() {
      _filteredSales = _sales.where((sale) {
        final carName = sale.carName.toLowerCase();
        final customerName = sale.customerName.toLowerCase();
        final status = sale.statusText.toLowerCase();
        return normalized.isEmpty ||
            carName.contains(normalized) ||
            customerName.contains(normalized) ||
            status.contains(normalized);
      }).toList();
    });
  }

  void _openSaleDetail(SaleModel sale) {
    final path = RouteNames.saleDetail.replaceFirst(':id', sale.id);
    context.go(path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách Sales'),
        actions: [
          IconButton(onPressed: _loadSales, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              _buildSearchField(),
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
      onChanged: _filterSales,
      decoration: InputDecoration(
        hintText: 'Tìm kiếm theo xe, khách hàng, trạng thái...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            _searchController.clear();
            _filterSales('');
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
        ),
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
                onPressed: _loadSales,
                child: const Text('Thử lại'),
              ),
            ],
          ),
        ),
      );
    }

    if (_filteredSales.isEmpty) {
      return const Center(child: Text('Không có giao dịch phù hợp.'));
    }

    return ListView.builder(
      itemCount: _filteredSales.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final sale = _filteredSales[index];
        return SaleListItem(sale: sale, onTap: () => _openSaleDetail(sale));
      },
    );
  }
}
