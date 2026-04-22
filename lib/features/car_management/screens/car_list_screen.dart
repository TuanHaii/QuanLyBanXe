import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/constants/app_constants.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/themes/app_colors.dart';
import '../models/car_model.dart';
import '../services/car_service.dart';
import '../widgets/car_list_item.dart';
import '../widgets/quick_add_car_sheet.dart';

class CarListScreen extends StatefulWidget {
  const CarListScreen({super.key});

  @override
  State<CarListScreen> createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  final CarService _carService = getIt<CarService>();
  List<CarModel> _cars = [];

  String _searchQuery = '';
  bool? _filterStatus;
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
      final matchesSearch = car.searchIndex.contains(
        _searchQuery.toLowerCase(),
      );
      final matchesStatus =
          _filterStatus == null || car.trangThai == _filterStatus;
      return matchesSearch && matchesStatus;
    }).toList();
  }

  Future<void> _openAddCarScreen() async {
    final created = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => const QuickAddCarSheet(),
    );
    if (created == true && mounted) {
      await _loadCars(showLoader: false);
    }
  }

  Future<void> _editCar(CarModel car) async {
    final updated = await context.push<bool>('/cars/${car.maXe}/edit');
    if (updated == true && mounted) {
      await _loadCars(showLoader: false);
    }
  }

  Future<void> _deleteCar(CarModel car) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Xóa xe'),
        content: Text('Bạn có chắc muốn xóa xe "${car.tenXe}" không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Hủy'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );

    if (shouldDelete != true || !mounted) {
      return;
    }

    try {
      await _carService.xoaXe(car.maXe);
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('Đã xóa xe ${car.tenXe}'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      await _loadCars(showLoader: false);
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('Xóa xe thất bại: ${e.toString()}'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.error,
          ),
        );
    }
  }

  void _goHome() {
    if (!mounted) {
      return;
    }

    context.go(RouteNames.dashboard);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragEnd: (details) {
        final velocity = details.primaryVelocity ?? 0;
        if (velocity > 350) {
          _goHome();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Danh sách xe'),
          actions: [
            IconButton(icon: const Icon(Icons.refresh), onPressed: _loadCars),
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: _showFilterDialog,
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              tooltip: 'Thêm xe mới',
              onPressed: _openAddCarScreen,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _openAddCarScreen,
          icon: const Icon(Icons.add),
          label: const Text('Thêm xe mới'),
        ),
        body: Column(
          children: [
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
                  ? const Center(child: Text('Không tìm thấy xe nào'))
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
                              context.push('/cars/${car.maXe}');
                            },
                            onEdit: () => _editCar(car),
                            onDelete: () => _deleteCar(car),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
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
                  label: const Text('Đang bán'),
                  selected: _filterStatus == true,
                  onSelected: (_) {
                    setState(() => _filterStatus = true);
                    Navigator.pop(context);
                  },
                ),
                FilterChip(
                  label: const Text('Ngừng bán'),
                  selected: _filterStatus == false,
                  onSelected: (_) {
                    setState(() => _filterStatus = false);
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
