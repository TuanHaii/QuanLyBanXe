import 'package:flutter/material.dart';

import '../models/sale_model.dart';
import '../widgets/sale_list_item.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<SaleModel> _sales = [
    SaleModel(
      id: '1',
      carName: 'Mercedes C300 2024',
      customerName: 'Nguyễn Văn A',
      salePrice: 2100000000,
      saleDate: DateTime.now().subtract(const Duration(days: 1)),
      status: SaleStatus.completed,
    ),
    SaleModel(
      id: '2',
      carName: 'BMW 320i 2023',
      customerName: 'Trần Thị B',
      salePrice: 1850000000,
      saleDate: DateTime.now().subtract(const Duration(days: 3)),
      status: SaleStatus.completed,
    ),
    SaleModel(
      id: '3',
      carName: 'Honda CR-V 2024',
      customerName: 'Lê Văn C',
      salePrice: 1100000000,
      saleDate: DateTime.now(),
      status: SaleStatus.pending,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<SaleModel> _getSalesByStatus(SaleStatus? status) {
    if (status == null) return _sales;
    return _sales.where((sale) => sale.status == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý bán hàng'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Tất cả'),
            Tab(text: 'Chờ xử lý'),
            Tab(text: 'Hoàn thành'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSalesList(null),
          _buildSalesList(SaleStatus.pending),
          _buildSalesList(SaleStatus.completed),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navigate to create new sale
        },
        icon: const Icon(Icons.add),
        label: const Text('Tạo đơn'),
      ),
    );
  }

  Widget _buildSalesList(SaleStatus? status) {
    final sales = _getSalesByStatus(status);

    if (sales.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Chưa có đơn hàng nào',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sales.length,
      itemBuilder: (context, index) {
        return SaleListItem(
          sale: sales[index],
          onTap: () {
            // TODO: Navigate to sale detail
          },
        );
      },
    );
  }
}
