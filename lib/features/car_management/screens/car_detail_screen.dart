// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';

// Nap thu vien hoac module can thiet.
import '../../../shared/services/service_locator.dart';
// Nap thu vien hoac module can thiet.
import '../../../shared/themes/app_colors.dart';
// Nap thu vien hoac module can thiet.
import '../models/car_model.dart';
// Nap thu vien hoac module can thiet.
import '../services/car_service.dart';

// Dinh nghia lop CarDetailScreen de gom nhom logic lien quan.
class CarDetailScreen extends StatefulWidget {
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String carId;

  // Khai bao bien CarDetailScreen de luu du lieu su dung trong xu ly.
  const CarDetailScreen({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.key,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.carId,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Thuc thi cau lenh hien tai theo luong xu ly.
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

// Dinh nghia lop _CarDetailScreenState de gom nhom logic lien quan.
class _CarDetailScreenState extends State<CarDetailScreen> {
  // Khai bao bien CarService de luu du lieu su dung trong xu ly.
  final CarService _carService = getIt<CarService>();
  // Thuc thi cau lenh hien tai theo luong xu ly.
  CarModel? _car;
  // Khai bao bien _isLoading de luu du lieu su dung trong xu ly.
  bool _isLoading = true;
  // Khai bao bien _isDeleting de luu du lieu su dung trong xu ly.
  bool _isDeleting = false;
  // Thuc thi cau lenh hien tai theo luong xu ly.
  String? _errorMessage;

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Dinh nghia ham initState de xu ly nghiep vu tuong ung.
  void initState() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.initState();
    // Khai bao constructor _loadCar de khoi tao doi tuong.
    _loadCar();
  }

  // Khai bao bien _loadCar de luu du lieu su dung trong xu ly.
  Future<void> _loadCar() async {
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
      final car = await _carService.fetchCarById(widget.carId);
      // Kiem tra dieu kien de re nhanh xu ly.
      if (!mounted) {
        // Tra ve ket qua cho noi goi ham.
        return;
      }

      // Cap nhat state de giao dien duoc render lai.
      setState(() {
        // Gan gia tri cho bien _car.
        _car = car;
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
        _errorMessage = 'Không thể tải chi tiết xe.';
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

  // Khai bao bien _deleteCar de luu du lieu su dung trong xu ly.
  Future<void> _deleteCar() async {
    // Kiem tra dieu kien de re nhanh xu ly.
    if (_isDeleting) {
      // Tra ve ket qua cho noi goi ham.
      return;
    }

    // Cap nhat state de giao dien duoc render lai.
    setState(() => _isDeleting = true);
    // Bao boc khoi lenh co the phat sinh loi de xu ly an toan.
    try {
      // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
      await _carService.deleteCar(widget.carId);
      // Kiem tra dieu kien de re nhanh xu ly.
      if (!mounted) {
        // Tra ve ket qua cho noi goi ham.
        return;
      }
      // Thuc thi cau lenh hien tai theo luong xu ly.
      Navigator.pop(context, true);
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } catch (_) {
      // Kiem tra dieu kien de re nhanh xu ly.
      if (!mounted) {
        // Tra ve ket qua cho noi goi ham.
        return;
      }
      // Thuc thi cau lenh hien tai theo luong xu ly.
      ScaffoldMessenger.of(context)
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ..hideCurrentSnackBar()
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ..showSnackBar(
          // Khai bao bien SnackBar de luu du lieu su dung trong xu ly.
          const SnackBar(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            content: Text('Xóa xe thất bại. Vui lòng thử lại.'),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            behavior: SnackBarBehavior.floating,
          ),
        );
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } finally {
      // Kiem tra dieu kien de re nhanh xu ly.
      if (mounted) {
        // Cap nhat state de giao dien duoc render lai.
        setState(() => _isDeleting = false);
      }
    }
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien car de luu du lieu su dung trong xu ly.
    final car = _car;

    // Tra ve ket qua cho noi goi ham.
    return Scaffold(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      appBar: AppBar(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        title: const Text('Chi tiết xe'),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        actions: [
          // Goi ham de thuc thi tac vu can thiet.
          IconButton(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            icon: const Icon(Icons.refresh),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onPressed: _isLoading ? null : _loadCar,
          ),
          // Goi ham de thuc thi tac vu can thiet.
          IconButton(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            icon: const Icon(Icons.edit),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onPressed: () {
              // TODO: Navigate to edit car
            },
          ),
          // Goi ham de thuc thi tac vu can thiet.
          IconButton(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            icon: const Icon(Icons.delete),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onPressed: car == null || _isDeleting
                // Thuc thi cau lenh hien tai theo luong xu ly.
                ? null
                // Thuc thi cau lenh hien tai theo luong xu ly.
                : () => _showDeleteDialog(context),
          ),
        ],
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      body: _isLoading
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? const Center(child: CircularProgressIndicator())
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : _errorMessage != null
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? Center(
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
                      onPressed: _loadCar,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      child: const Text('Thử lại'),
                    ),
                  ],
                ),
              ),
            )
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : car == null
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? const Center(child: Text('Không tìm thấy xe.'))
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : SingleChildScrollView(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              child: Column(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                crossAxisAlignment: CrossAxisAlignment.start,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                children: [
                  // Car image
                  // Goi ham de thuc thi tac vu can thiet.
                  Container(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    height: 250,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    width: double.infinity,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: Colors.grey[300],
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    child: car.images.isNotEmpty
                        // Thuc thi cau lenh hien tai theo luong xu ly.
                        ? Image.network(
                            // Thuc thi cau lenh hien tai theo luong xu ly.
                            car.images.first,
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            fit: BoxFit.cover,
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            errorBuilder: (_, __, ___) => const Center(
                              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                              child: Icon(
                                // Thuc thi cau lenh hien tai theo luong xu ly.
                                Icons.directions_car,
                                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                                size: 100,
                                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                                color: Colors.grey,
                              ),
                            ),
                          )
                        // Thuc thi cau lenh hien tai theo luong xu ly.
                        : const Center(
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            child: Icon(
                              // Thuc thi cau lenh hien tai theo luong xu ly.
                              Icons.directions_car,
                              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                              size: 100,
                              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                              color: Colors.grey,
                            ),
                          ),
                  ),
                  // Goi ham de thuc thi tac vu can thiet.
                  Padding(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    padding: const EdgeInsets.all(16),
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    child: Column(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      children: [
                        // Name and status
                        // Goi ham de thuc thi tac vu can thiet.
                        Row(
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          children: [
                            // Goi ham de thuc thi tac vu can thiet.
                            Expanded(
                              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                              child: Text(
                                // Thuc thi cau lenh hien tai theo luong xu ly.
                                car.name,
                                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                                style: Theme.of(
                                  // Thuc thi cau lenh hien tai theo luong xu ly.
                                  context,
                                // Thuc thi cau lenh hien tai theo luong xu ly.
                                ).textTheme.headlineSmall?.copyWith(
                                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            // Goi ham de thuc thi tac vu can thiet.
                            Container(
                              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                              padding: const EdgeInsets.symmetric(
                                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                                horizontal: 12,
                                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                                vertical: 6,
                              ),
                              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                              decoration: BoxDecoration(
                                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                                color: _getStatusColor(
                                  // Thuc thi cau lenh hien tai theo luong xu ly.
                                  car.status,
                                // Thuc thi cau lenh hien tai theo luong xu ly.
                                ).withValues(alpha: .1),
                                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                                borderRadius: BorderRadius.circular(20),
                              ),
                              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                              child: Text(
                                // Thuc thi cau lenh hien tai theo luong xu ly.
                                car.statusText,
                                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                                style: AppTextStyles.labelMedium.copyWith(
                                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                                  color: _getStatusColor(car.status),
                                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                        const SizedBox(height: 8),
                        // Price
                        // Goi ham de thuc thi tac vu can thiet.
                        Text(
                          // Thuc thi cau lenh hien tai theo luong xu ly.
                          car.formattedPrice,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                                color: Theme.of(context).primaryColor,
                                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                        const SizedBox(height: 24),
                        // Details
                        // Goi ham de thuc thi tac vu can thiet.
                        _buildDetailSection(context, 'Thông tin chi tiết', [
                          // Goi ham de thuc thi tac vu can thiet.
                          _buildDetailRow('Hãng xe', car.brand),
                          // Goi ham de thuc thi tac vu can thiet.
                          _buildDetailRow('Dòng xe', car.model),
                          // Goi ham de thuc thi tac vu can thiet.
                          _buildDetailRow('Năm sản xuất', car.year.toString()),
                          // Goi ham de thuc thi tac vu can thiet.
                          _buildDetailRow('Màu sắc', car.color),
                          // Goi ham de thuc thi tac vu can thiet.
                          _buildDetailRow('Số km đã đi', '${car.mileage} km'),
                          // Kiem tra dieu kien de re nhanh xu ly.
                          if (car.fuelType != null)
                            // Goi ham de thuc thi tac vu can thiet.
                            _buildDetailRow('Nhiên liệu', car.fuelType!),
                          // Kiem tra dieu kien de re nhanh xu ly.
                          if (car.transmission != null)
                            // Goi ham de thuc thi tac vu can thiet.
                            _buildDetailRow('Hộp số', car.transmission!),
                        ]),
                        // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                        const SizedBox(height: 16),
                        // Description
                        // Kiem tra dieu kien de re nhanh xu ly.
                        if (car.description != null) ...[
                          // Goi ham de thuc thi tac vu can thiet.
                          Text(
                            // Thuc thi cau lenh hien tai theo luong xu ly.
                            'Mô tả',
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            style: Theme.of(
                              // Thuc thi cau lenh hien tai theo luong xu ly.
                              context,
                            // Thuc thi cau lenh hien tai theo luong xu ly.
                            ).textTheme.titleMedium?.copyWith(
                                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                          const SizedBox(height: 8),
                          // Goi ham de thuc thi tac vu can thiet.
                          Text(
                            // Thuc thi cau lenh hien tai theo luong xu ly.
                            car.description!,
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      bottomNavigationBar: car?.status == CarStatus.available
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? Container(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              padding: const EdgeInsets.all(16),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              child: ElevatedButton(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                onPressed: () {
                  // TODO: Navigate to sell car
                },
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: const Text('Bán xe này'),
              ),
            )
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : null,
    );
  }

  // Khai bao bien _buildDetailSection de luu du lieu su dung trong xu ly.
  Widget _buildDetailSection(
    // Thuc thi cau lenh hien tai theo luong xu ly.
    BuildContext context,
    // Khai bao bien title de luu du lieu su dung trong xu ly.
    String title,
    // Khai bao bien children de luu du lieu su dung trong xu ly.
    List<Widget> children,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  ) {
    // Tra ve ket qua cho noi goi ham.
    return Column(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      crossAxisAlignment: CrossAxisAlignment.start,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      children: [
        // Goi ham de thuc thi tac vu can thiet.
        Text(
          // Thuc thi cau lenh hien tai theo luong xu ly.
          title,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                fontWeight: FontWeight.bold,
              ),
        ),
        // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
        const SizedBox(height: 12),
        // Goi ham de thuc thi tac vu can thiet.
        Card(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Padding(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            padding: const EdgeInsets.all(16),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Column(children: children),
          ),
        ),
      ],
    );
  }

  // Khai bao bien _buildDetailRow de luu du lieu su dung trong xu ly.
  Widget _buildDetailRow(String label, String value) {
    // Tra ve ket qua cho noi goi ham.
    return Padding(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: const EdgeInsets.symmetric(vertical: 8),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Row(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: [
          // Goi ham de thuc thi tac vu can thiet.
          Text(
            // Thuc thi cau lenh hien tai theo luong xu ly.
            label,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          Text(
            // Thuc thi cau lenh hien tai theo luong xu ly.
            value,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // Khai bao bien _getStatusColor de luu du lieu su dung trong xu ly.
  Color _getStatusColor(CarStatus status) {
    // Bat dau re nhanh theo nhieu truong hop gia tri.
    switch (status) {
      // Xu ly mot truong hop cu the trong switch.
      case CarStatus.available:
        // Tra ve ket qua cho noi goi ham.
        return Colors.green;
      // Xu ly mot truong hop cu the trong switch.
      case CarStatus.sold:
        // Tra ve ket qua cho noi goi ham.
        return Colors.red;
      // Xu ly mot truong hop cu the trong switch.
      case CarStatus.reserved:
        // Tra ve ket qua cho noi goi ham.
        return Colors.orange;
    }
  }

  // Dinh nghia ham _showDeleteDialog de xu ly nghiep vu tuong ung.
  void _showDeleteDialog(BuildContext context) {
    // Goi ham de thuc thi tac vu can thiet.
    showDialog(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      context: context,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      builder: (context) => AlertDialog(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        title: const Text('Xóa xe'),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        content: const Text('Bạn có chắc muốn xóa xe này?'),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        actions: [
          // Goi ham de thuc thi tac vu can thiet.
          TextButton(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onPressed: () => Navigator.pop(context),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: const Text('Hủy'),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          ElevatedButton(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            style: ElevatedButton.styleFrom(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              backgroundColor: Colors.red,
            ),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onPressed: () {
              // Thuc thi cau lenh hien tai theo luong xu ly.
              Navigator.pop(context);
              // Khai bao constructor _deleteCar de khoi tao doi tuong.
              _deleteCar();
            },
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: _isDeleting
                // Thuc thi cau lenh hien tai theo luong xu ly.
                ? const SizedBox(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    width: 16,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    height: 16,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                // Thuc thi cau lenh hien tai theo luong xu ly.
                : const Text('Xóa'),
          ),
        ],
      ),
    );
  }
}
