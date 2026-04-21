import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/constants/app_constants.dart';
import '../models/car_model.dart';
import '../widgets/car_list_item.dart';

class CarListScreen extends StatefulWidget {
  const CarListScreen({super.key});

  @override
  State<CarListScreen> createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  final List<CarModel> _cars = [
    const CarModel(
      id: '1',
      name: 'Toyota Camry 2024',
      brand: 'Toyota',
      model: 'Camry',
      year: 2024,
      color: 'Đen',
      price: 1250000000,
      mileage: 0,
      status: CarStatus.available,
    ),
    const CarModel(
      id: '2',
      name: 'Honda Civic 2023',
      brand: 'Honda',
      model: 'Civic',
      year: 2023,
      color: 'Trắng',
      price: 870000000,
      mileage: 5000,
      status: CarStatus.available,
    ),
    const CarModel(
      id: '3',
      name: 'Mercedes C300 2024',
      brand: 'Mercedes',
      model: 'C300',
      year: 2024,
      color: 'Bạc',
      price: 2100000000,
      mileage: 0,
      status: CarStatus.sold,
    ),
  ];

  String _searchQuery = '';
  CarStatus? _filterStatus;

  List<CarModel> get _filteredCars {
    return _cars.where((car) {
      final matchesSearch =
          car.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          car.brand.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesStatus =
          _filterStatus == null || car.status == _filterStatus;
      return matchesSearch && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách xe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
              decoration: InputDecoration(
                hintText: 'Tìm kiếm xe...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
              ),
            ),
          ),
          // Car list
          Expanded(
            child: _filteredCars.isEmpty
                ? const Center(child: Text('Không tìm thấy xe nào'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredCars.length,
                    itemBuilder: (context, index) {
                      final car = _filteredCars[index];
                      return CarListItem(
                        car: car,
                        onTap: () {
                          context.push('/cars/${car.id}');
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(RouteNames.addCar),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lọc theo trạng thái',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                FilterChip(
                  label: const Text('Tất cả'),
                  selected: _filterStatus == null,
                  onSelected: (_) {
                    setState(() => _filterStatus = null);
                    Navigator.pop(context);
                  },
                ),
                FilterChip(
                  label: const Text('Còn hàng'),
                  selected: _filterStatus == CarStatus.available,
                  onSelected: (_) {
                    setState(() => _filterStatus = CarStatus.available);
                    Navigator.pop(context);
                  },
                ),
                FilterChip(
                  label: const Text('Đã bán'),
                  selected: _filterStatus == CarStatus.sold,
                  onSelected: (_) {
                    setState(() => _filterStatus = CarStatus.sold);
                    Navigator.pop(context);
                  },
                ),
                FilterChip(
                  label: const Text('Đã đặt'),
                  selected: _filterStatus == CarStatus.reserved,
                  onSelected: (_) {
                    setState(() => _filterStatus = CarStatus.reserved);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
