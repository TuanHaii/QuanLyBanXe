import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/services/service_locator.dart';
import '../../../shared/themes/app_colors.dart';
import '../models/car_model.dart';
import '../services/car_service.dart';

class CarDetailScreen extends StatefulWidget {
  final String carId;

  const CarDetailScreen({super.key, required this.carId});

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  final CarService _carService = getIt<CarService>();
  CarModel? _car;
  bool _isLoading = true;
  bool _isDeleting = false;
  String? _errorMessage;

  int? _parsedCarId;

  @override
  void initState() {
    super.initState();
    _parsedCarId = int.tryParse(widget.carId);
    _loadCar();
  }

  Future<void> _loadCar() async {
    if (_parsedCarId == null) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Mã xe không hợp lệ.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final car = await _carService.layXeTheoMa(_parsedCarId!);
      if (!mounted) {
        return;
      }

      setState(() {
        _car = car;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _errorMessage = 'Không thể tải chi tiết xe.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _deleteCar() async {
    if (_parsedCarId == null) {
      return;
    }

    if (_isDeleting) {
      return;
    }

    setState(() => _isDeleting = true);
    try {
      await _carService.xoaXe(_parsedCarId!);
      if (!mounted) {
        return;
      }
      Navigator.pop(context, true);
    } catch (_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Xóa xe thất bại. Vui lòng thử lại.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
    } finally {
      if (mounted) {
        setState(() => _isDeleting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final car = _car;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết xe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _loadCar,
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: car == null
                ? null
                : () {
                    context.push('/cars/${car.maXe}/edit');
                  },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: car == null || _isDeleting
                ? null
                : () => _showDeleteDialog(context),
          ),
        ],
      ),
      body: _isLoading
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
                      onPressed: _loadCar,
                      child: const Text('Thử lại'),
                    ),
                  ],
                ),
              ),
            )
          : car == null
          ? const Center(child: Text('Không tìm thấy xe.'))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Car image
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: .16),
                          Colors.grey.shade100,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.directions_car_filled_rounded,
                        size: 120,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name and status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                car.tenXe,
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(
                                  car.trangThai,
                                ).withValues(alpha: .1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                car.trangThaiText,
                                style: AppTextStyles.labelMedium.copyWith(
                                  color: _getStatusColor(car.trangThai),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Price
                        Text(
                          car.formattedPrice,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 24),
                        // Details
                        _buildDetailSection(context, 'Thông tin chi tiết', [
                          _buildDetailRow('Mã xe', car.maXe.toString()),
                          _buildDetailRow('Hãng xe', car.tenHangXe),
                          _buildDetailRow('Loại xe', car.tenLoaiXe),
                          _buildDetailRow(
                            'Năm sản xuất',
                            car.namSanXuat.toString(),
                          ),
                          _buildDetailRow('Màu sắc', car.mauSac),
                          _buildDetailRow('Số khung', car.soKhung),
                          _buildDetailRow('Số máy', car.soMay),
                          _buildDetailRow(
                            'Dung tích',
                            car.dungTich ?? 'Chưa cập nhật',
                          ),
                          _buildDetailRow('Tồn kho', '${car.soLuongTon} xe'),
                          _buildDetailRow('Mã hãng', car.maHang.toString()),
                          _buildDetailRow(
                            'Mã loại xe',
                            car.maLoaiXe.toString(),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildDetailSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: children),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey),
          ),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(bool trangThai) {
    return trangThai ? Colors.green : Colors.grey;
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa xe'),
        content: const Text('Bạn có chắc muốn xóa xe này?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              _deleteCar();
            },
            child: _isDeleting
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Xóa'),
          ),
        ],
      ),
    );
  }
}
