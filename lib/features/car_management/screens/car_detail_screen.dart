import 'package:flutter/material.dart';

import '../models/car_model.dart';
import '../../../shared/themes/app_colors.dart';

class CarDetailScreen extends StatelessWidget {
  final String carId;

  const CarDetailScreen({
    super.key,
    required this.carId,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Fetch car details from API
    final car = CarModel(
      id: carId,
      name: 'Toyota Camry 2024',
      brand: 'Toyota',
      model: 'Camry',
      year: 2024,
      color: 'Đen',
      price: 1250000000,
      mileage: 0,
      description:
          'Xe mới 100%, đủ màu, giao ngay. Hỗ trợ trả góp 80% giá trị xe.',
      fuelType: 'Xăng',
      transmission: 'Tự động',
      status: CarStatus.available,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết xe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigate to edit car
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _showDeleteDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Car image
            Container(
              height: 250,
              width: double.infinity,
              color: Colors.grey[300],
              child: const Center(
                child: Icon(
                  Icons.directions_car,
                  size: 100,
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
                          car.name,
                          style:
                              Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(car.status).withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          car.statusText,
                          style: AppTextStyles.labelMedium.copyWith(
                            color: _getStatusColor(car.status),
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
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 24),
                  // Details
                  _buildDetailSection(context, 'Thông tin chi tiết', [
                    _buildDetailRow('Hãng xe', car.brand),
                    _buildDetailRow('Dòng xe', car.model),
                    _buildDetailRow('Năm sản xuất', car.year.toString()),
                    _buildDetailRow('Màu sắc', car.color),
                    _buildDetailRow('Số km đã đi', '${car.mileage} km'),
                    if (car.fuelType != null)
                      _buildDetailRow('Nhiên liệu', car.fuelType!),
                    if (car.transmission != null)
                      _buildDetailRow('Hộp số', car.transmission!),
                  ]),
                  const SizedBox(height: 16),
                  // Description
                  if (car.description != null) ...[
                    Text(
                      'Mô tả',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      car.description!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: car.status == CarStatus.available
          ? Container(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to sell car
                },
                child: const Text('Bán xe này'),
              ),
            )
          : null,
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
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
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
            style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(CarStatus status) {
    switch (status) {
      case CarStatus.available:
        return Colors.green;
      case CarStatus.sold:
        return Colors.red;
      case CarStatus.reserved:
        return Colors.orange;
    }
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
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              // TODO: Delete car
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }
}
