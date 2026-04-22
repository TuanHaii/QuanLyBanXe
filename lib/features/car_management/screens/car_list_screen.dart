import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/constants/app_constants.dart';
import '../../../shared/services/service_locator.dart';
import '../models/car_model.dart';
import '../services/car_service.dart';
import '../widgets/car_list_item.dart';

class CarListScreen extends StatefulWidget {
  const CarListScreen({super.key});

  @override
  State<CarListScreen> createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  final CarService _carService = getIt<CarService>();
  List<CarModel> _cars = [];

  String _searchQuery = '';
  CarStatus? _filterStatus;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCars();
  }

  Future<void> _loadCars({bool showLoader = true}) async {
    if (showLoader) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
    }

    try {
      final cars = await _carService.fetchCars();

      if (!mounted) {
        return;
      }

      setState(() {
        _cars = cars;
        _errorMessage = null;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _errorMessage = 'Không thể tải danh sách xe. Vui lòng thử lại.';
      });
    } finally {
      if (mounted && showLoader) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  List<CarModel> get _filteredCars {
    return _cars.where((car) {
      final matchesSearch = car.name
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          car.brand.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesStatus = _filterStatus == null || car.status == _filterStatus;
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
            icon: const Icon(Icons.refresh),
            onPressed: _loadCars,
          ),
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
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage != null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_errorMessage!, textAlign: TextAlign.center),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: _loadCars,
                            child: const Text('Thử lại'),
                          ),
                        ],
                      ),
                    ),
                  )
                : _filteredCars.isEmpty
                ? const Center(
                    child: Text('Không tìm thấy xe nào'),
                  )
                : RefreshIndicator(
                    onRefresh: () => _loadCars(showLoader: false),
                    child: ListView.builder(
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.push(RouteNames.addCar);
          if (mounted) {
            _loadCars(showLoader: false);
          }
        },
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
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
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
