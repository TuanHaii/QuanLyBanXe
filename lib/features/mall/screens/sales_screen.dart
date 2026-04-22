// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';
// Nap thu vien hoac module can thiet.
import 'package:go_router/go_router.dart';

// Nap thu vien hoac module can thiet.
import '../../../shared/constants/app_constants.dart';
// Nap thu vien hoac module can thiet.
import '../../../shared/services/service_locator.dart';
// Nap thu vien hoac module can thiet.
import '../models/mall_model.dart';
// Nap thu vien hoac module can thiet.
import '../services/sale_service.dart';
// Nap thu vien hoac module can thiet.
import '../widgets/mall_list_item.dart';

// Dinh nghia lop SalesScreen de gom nhom logic lien quan.
class SalesScreen extends StatefulWidget {
  // Khai bao bien SalesScreen de luu du lieu su dung trong xu ly.
  const SalesScreen({super.key});

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Thuc thi cau lenh hien tai theo luong xu ly.
  State<SalesScreen> createState() => _SalesScreenState();
}

// Dinh nghia lop _SalesScreenState de gom nhom logic lien quan.
class _SalesScreenState extends State<SalesScreen> {
  // Khai bao bien SaleService de luu du lieu su dung trong xu ly.
  final SaleService _saleService = getIt<SaleService>();
  // Khai bao bien TextEditingController de luu du lieu su dung trong xu ly.
  final TextEditingController _searchController = TextEditingController();

  // Khai bao bien _isLoading de luu du lieu su dung trong xu ly.
  bool _isLoading = true;
  // Thuc thi cau lenh hien tai theo luong xu ly.
  String? _errorMessage;
  // Khai bao bien _sales de luu du lieu su dung trong xu ly.
  List<SaleModel> _sales = [];
  // Khai bao bien _filteredSales de luu du lieu su dung trong xu ly.
  List<SaleModel> _filteredSales = [];

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Dinh nghia ham initState de xu ly nghiep vu tuong ung.
  void initState() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.initState();
    // Khai bao constructor _loadSales de khoi tao doi tuong.
    _loadSales();
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

  // Khai bao bien _loadSales de luu du lieu su dung trong xu ly.
  Future<void> _loadSales() async {
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
      final sales = await _saleService.fetchSales();
      // Cap nhat state de giao dien duoc render lai.
      setState(() {
        // Gan gia tri cho bien _sales.
        _sales = sales;
        // Gan gia tri cho bien _filteredSales.
        _filteredSales = sales;
      });
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } catch (_) {
      // Cap nhat state de giao dien duoc render lai.
      setState(() {
        // Gan gia tri cho bien _errorMessage.
        _errorMessage = 'Không thể tải danh sách bán hàng. Vui lòng thử lại.';
      });
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } finally {
      // Cap nhat state de giao dien duoc render lai.
      setState(() {
        // Gan gia tri cho bien _isLoading.
        _isLoading = false;
      });
    }
  }

  // Dinh nghia ham _filterSales de xu ly nghiep vu tuong ung.
  void _filterSales(String query) {
    // Khai bao bien normalized de luu du lieu su dung trong xu ly.
    final normalized = query.trim().toLowerCase();
    // Cap nhat state de giao dien duoc render lai.
    setState(() {
      // Gan gia tri cho bien _filteredSales.
      _filteredSales = _sales.where((sale) {
        // Khai bao bien carName de luu du lieu su dung trong xu ly.
        final carName = sale.carName.toLowerCase();
        // Khai bao bien customerName de luu du lieu su dung trong xu ly.
        final customerName = sale.customerName.toLowerCase();
        // Khai bao bien status de luu du lieu su dung trong xu ly.
        final status = sale.statusText.toLowerCase();
        // Tra ve ket qua cho noi goi ham.
        return normalized.isEmpty ||
            // Thuc thi cau lenh hien tai theo luong xu ly.
            carName.contains(normalized) ||
            // Thuc thi cau lenh hien tai theo luong xu ly.
            customerName.contains(normalized) ||
            // Thuc thi cau lenh hien tai theo luong xu ly.
            status.contains(normalized);
      // Thuc thi cau lenh hien tai theo luong xu ly.
      }).toList();
    });
  }

  // Dinh nghia ham _openSaleDetail de xu ly nghiep vu tuong ung.
  void _openSaleDetail(SaleModel sale) {
    // Khai bao bien path de luu du lieu su dung trong xu ly.
    final path = RouteNames.saleDetail.replaceFirst(':id', sale.id);
    // Thuc thi cau lenh hien tai theo luong xu ly.
    context.go(path);
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Tra ve ket qua cho noi goi ham.
    return Scaffold(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      appBar: AppBar(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        title: const Text('Danh sách Sales'),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        actions: [
          // Goi ham de thuc thi tac vu can thiet.
          IconButton(onPressed: _loadSales, icon: const Icon(Icons.refresh)),
        ],
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      body: SafeArea(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: Padding(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Column(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Goi ham de thuc thi tac vu can thiet.
              _buildSearchField(),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 12),
              // Goi ham de thuc thi tac vu can thiet.
              Expanded(child: _buildBody()),
            ],
          ),
        ),
      ),
    );
  }

  // Khai bao bien _buildSearchField de luu du lieu su dung trong xu ly.
  Widget _buildSearchField() {
    // Tra ve ket qua cho noi goi ham.
    return TextField(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      controller: _searchController,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      onChanged: _filterSales,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: InputDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        hintText: 'Tìm kiếm theo xe, khách hàng, trạng thái...',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        prefixIcon: const Icon(Icons.search),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        suffixIcon: IconButton(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          icon: const Icon(Icons.clear),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          onPressed: () {
            // Thuc thi cau lenh hien tai theo luong xu ly.
            _searchController.clear();
            // Khai bao constructor _filterSales de khoi tao doi tuong.
            _filterSales('');
          },
        ),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: OutlineInputBorder(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderRadius: BorderRadius.circular(14),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
        ),
      ),
    );
  }

  // Khai bao bien _buildBody de luu du lieu su dung trong xu ly.
  Widget _buildBody() {
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
              Text(_errorMessage!, textAlign: TextAlign.center),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 12),
              // Goi ham de thuc thi tac vu can thiet.
              ElevatedButton(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                onPressed: _loadSales,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: const Text('Thử lại'),
              ),
            ],
          ),
        ),
      );
    }

    // Kiem tra dieu kien de re nhanh xu ly.
    if (_filteredSales.isEmpty) {
      // Tra ve ket qua cho noi goi ham.
      return const Center(child: Text('Không có giao dịch phù hợp.'));
    }

    // Tra ve ket qua cho noi goi ham.
    return ListView.builder(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      itemCount: _filteredSales.length,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: EdgeInsets.zero,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      itemBuilder: (context, index) {
        // Khai bao bien sale de luu du lieu su dung trong xu ly.
        final sale = _filteredSales[index];
        // Tra ve ket qua cho noi goi ham.
        return SaleListItem(sale: sale, onTap: () => _openSaleDetail(sale));
      },
    );
  }
}
