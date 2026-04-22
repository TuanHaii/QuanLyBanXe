// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';

// Nap thu vien hoac module can thiet.
import '../../../shared/services/service_locator.dart';
// Nap thu vien hoac module can thiet.
import '../../../shared/themes/app_colors.dart';
// Nap thu vien hoac module can thiet.
import '../services/car_service.dart';

// Dinh nghia lop AddCarScreen de gom nhom logic lien quan.
class AddCarScreen extends StatefulWidget {
  // Khai bao bien AddCarScreen de luu du lieu su dung trong xu ly.
  const AddCarScreen({super.key});

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Thuc thi cau lenh hien tai theo luong xu ly.
  State<AddCarScreen> createState() => _AddCarScreenState();
}

// Dinh nghia lop _AddCarScreenState de gom nhom logic lien quan.
class _AddCarScreenState extends State<AddCarScreen> {
  // Khai bao bien CarService de luu du lieu su dung trong xu ly.
  final CarService _carService = getIt<CarService>();
  // Khai bao bien _formKey de luu du lieu su dung trong xu ly.
  final _formKey = GlobalKey<FormState>();
  // Khai bao bien _nameController de luu du lieu su dung trong xu ly.
  final _nameController = TextEditingController();
  // Khai bao bien _brandController de luu du lieu su dung trong xu ly.
  final _brandController = TextEditingController();
  // Khai bao bien _modelController de luu du lieu su dung trong xu ly.
  final _modelController = TextEditingController();
  // Khai bao bien _yearController de luu du lieu su dung trong xu ly.
  final _yearController = TextEditingController();
  // Khai bao bien _colorController de luu du lieu su dung trong xu ly.
  final _colorController = TextEditingController();
  // Khai bao bien _priceController de luu du lieu su dung trong xu ly.
  final _priceController = TextEditingController();
  // Khai bao bien _mileageController de luu du lieu su dung trong xu ly.
  final _mileageController = TextEditingController();
  // Khai bao bien _descriptionController de luu du lieu su dung trong xu ly.
  final _descriptionController = TextEditingController();

  // Khai bao bien _fuelType de luu du lieu su dung trong xu ly.
  String _fuelType = 'Xăng';
  // Khai bao bien _transmission de luu du lieu su dung trong xu ly.
  String _transmission = 'Tự động';
  // Khai bao bien _isLoading de luu du lieu su dung trong xu ly.
  bool _isLoading = false;

  // Khai bao bien List de luu du lieu su dung trong xu ly.
  final List<String> _fuelTypes = ['Xăng', 'Dầu', 'Điện', 'Hybrid'];
  // Khai bao bien List de luu du lieu su dung trong xu ly.
  final List<String> _transmissions = ['Tự động', 'Số sàn'];

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Dinh nghia ham dispose de xu ly nghiep vu tuong ung.
  void dispose() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _nameController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _brandController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _modelController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _yearController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _colorController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _priceController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _mileageController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _descriptionController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.dispose();
  }

  // Khai bao bien _handleSubmit de luu du lieu su dung trong xu ly.
  Future<void> _handleSubmit() async {
    // Kiem tra dieu kien de re nhanh xu ly.
    if (!_formKey.currentState!.validate()) return;

    // Cap nhat state de giao dien duoc render lai.
    setState(() => _isLoading = true);

    // Bao boc khoi lenh co the phat sinh loi de xu ly an toan.
    try {
      // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
      await _carService.createCar({
        // Thuc thi cau lenh hien tai theo luong xu ly.
        'name': _nameController.text.trim(),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        'brand': _brandController.text.trim(),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        'model': _modelController.text.trim(),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        'year': int.parse(_yearController.text.trim()),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        'color': _colorController.text.trim(),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        'price': double.parse(_priceController.text.trim()),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        'mileage': int.tryParse(_mileageController.text.trim()) ?? 0,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        'description': _descriptionController.text.trim().isEmpty
            // Thuc thi cau lenh hien tai theo luong xu ly.
            ? null
            // Thuc thi cau lenh hien tai theo luong xu ly.
            : _descriptionController.text.trim(),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        'fuel_type': _fuelType,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        'transmission': _transmission,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        'status': 'available',
      });

      // Kiem tra dieu kien de re nhanh xu ly.
      if (mounted) {
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ScaffoldMessenger.of(context).showSnackBar(
          // Khai bao bien SnackBar de luu du lieu su dung trong xu ly.
          const SnackBar(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            content: Text('Thêm xe thành công!'),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            backgroundColor: AppColors.success,
          ),
        );
        // Thuc thi cau lenh hien tai theo luong xu ly.
        Navigator.pop(context, true);
      }
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } catch (e) {
      // Kiem tra dieu kien de re nhanh xu ly.
      if (mounted) {
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ScaffoldMessenger.of(context).showSnackBar(
          // Goi ham de thuc thi tac vu can thiet.
          SnackBar(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            content: Text('Lỗi: ${e.toString()}'),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            backgroundColor: AppColors.error,
          ),
        );
      }
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } finally {
      // Kiem tra dieu kien de re nhanh xu ly.
      if (mounted) {
        // Cap nhat state de giao dien duoc render lai.
        setState(() => _isLoading = false);
      }
    }
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
        title: const Text('Thêm xe mới'),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      body: SingleChildScrollView(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        padding: const EdgeInsets.all(16),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: Form(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          key: _formKey,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Column(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Image placeholder
              // Goi ham de thuc thi tac vu can thiet.
              Container(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                height: 150,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                decoration: BoxDecoration(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: Colors.grey[200],
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  borderRadius: BorderRadius.circular(12),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  border: Border.all(color: Colors.grey[300]!),
                ),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: InkWell(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  onTap: () {
                    // TODO: Pick images
                  },
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  borderRadius: BorderRadius.circular(12),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  child: Column(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    mainAxisAlignment: MainAxisAlignment.center,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    children: [
                      // Khai bao bien Icon de luu du lieu su dung trong xu ly.
                      const Icon(
                        // Thuc thi cau lenh hien tai theo luong xu ly.
                        Icons.add_photo_alternate_outlined,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        size: 48,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        color: Colors.grey,
                      ),
                      // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                      const SizedBox(height: 8),
                      // Goi ham de thuc thi tac vu can thiet.
                      Text(
                        // Thuc thi cau lenh hien tai theo luong xu ly.
                        'Thêm hình ảnh',
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 24),
              // Name
              // Goi ham de thuc thi tac vu can thiet.
              TextFormField(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                controller: _nameController,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                decoration: const InputDecoration(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  labelText: 'Tên xe *',
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  hintText: 'VD: Toyota Camry 2024',
                ),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                validator: (value) {
                  // Kiem tra dieu kien de re nhanh xu ly.
                  if (value == null || value.isEmpty) {
                    // Tra ve ket qua cho noi goi ham.
                    return 'Vui lòng nhập tên xe';
                  }
                  // Tra ve ket qua cho noi goi ham.
                  return null;
                },
              ),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 16),
              // Brand and Model
              // Goi ham de thuc thi tac vu can thiet.
              Row(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                children: [
                  // Goi ham de thuc thi tac vu can thiet.
                  Expanded(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    child: TextFormField(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      controller: _brandController,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      decoration: const InputDecoration(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        labelText: 'Hãng xe *',
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        hintText: 'VD: Toyota',
                      ),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      validator: (value) {
                        // Kiem tra dieu kien de re nhanh xu ly.
                        if (value == null || value.isEmpty) {
                          // Tra ve ket qua cho noi goi ham.
                          return 'Vui lòng nhập hãng xe';
                        }
                        // Tra ve ket qua cho noi goi ham.
                        return null;
                      },
                    ),
                  ),
                  // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                  const SizedBox(width: 16),
                  // Goi ham de thuc thi tac vu can thiet.
                  Expanded(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    child: TextFormField(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      controller: _modelController,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      decoration: const InputDecoration(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        labelText: 'Dòng xe *',
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        hintText: 'VD: Camry',
                      ),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      validator: (value) {
                        // Kiem tra dieu kien de re nhanh xu ly.
                        if (value == null || value.isEmpty) {
                          // Tra ve ket qua cho noi goi ham.
                          return 'Vui lòng nhập dòng xe';
                        }
                        // Tra ve ket qua cho noi goi ham.
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 16),
              // Year and Color
              // Goi ham de thuc thi tac vu can thiet.
              Row(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                children: [
                  // Goi ham de thuc thi tac vu can thiet.
                  Expanded(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    child: TextFormField(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      controller: _yearController,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      decoration: const InputDecoration(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        labelText: 'Năm SX *',
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        hintText: 'VD: 2024',
                      ),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      keyboardType: TextInputType.number,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      validator: (value) {
                        // Kiem tra dieu kien de re nhanh xu ly.
                        if (value == null || value.isEmpty) {
                          // Tra ve ket qua cho noi goi ham.
                          return 'Vui lòng nhập';
                        }
                        // Khai bao bien year de luu du lieu su dung trong xu ly.
                        final year = int.tryParse(value);
                        // Kiem tra dieu kien de re nhanh xu ly.
                        if (year == null || year < 1900 || year > 2100) {
                          // Tra ve ket qua cho noi goi ham.
                          return 'Năm không hợp lệ';
                        }
                        // Tra ve ket qua cho noi goi ham.
                        return null;
                      },
                    ),
                  ),
                  // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                  const SizedBox(width: 16),
                  // Goi ham de thuc thi tac vu can thiet.
                  Expanded(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    child: TextFormField(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      controller: _colorController,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      decoration: const InputDecoration(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        labelText: 'Màu sắc *',
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        hintText: 'VD: Đen',
                      ),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      validator: (value) {
                        // Kiem tra dieu kien de re nhanh xu ly.
                        if (value == null || value.isEmpty) {
                          // Tra ve ket qua cho noi goi ham.
                          return 'Vui lòng nhập';
                        }
                        // Tra ve ket qua cho noi goi ham.
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 16),
              // Price
              // Goi ham de thuc thi tac vu can thiet.
              TextFormField(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                controller: _priceController,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                decoration: const InputDecoration(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  labelText: 'Giá (VNĐ) *',
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  hintText: 'VD: 1250000000',
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  suffixText: 'VNĐ',
                ),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                keyboardType: TextInputType.number,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                validator: (value) {
                  // Kiem tra dieu kien de re nhanh xu ly.
                  if (value == null || value.isEmpty) {
                    // Tra ve ket qua cho noi goi ham.
                    return 'Vui lòng nhập giá';
                  }
                  // Khai bao bien price de luu du lieu su dung trong xu ly.
                  final price = double.tryParse(value);
                  // Kiem tra dieu kien de re nhanh xu ly.
                  if (price == null || price <= 0) {
                    // Tra ve ket qua cho noi goi ham.
                    return 'Giá không hợp lệ';
                  }
                  // Tra ve ket qua cho noi goi ham.
                  return null;
                },
              ),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 16),
              // Mileage
              // Goi ham de thuc thi tac vu can thiet.
              TextFormField(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                controller: _mileageController,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                decoration: const InputDecoration(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  labelText: 'Số km đã đi',
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  hintText: 'VD: 0',
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  suffixText: 'km',
                ),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                keyboardType: TextInputType.number,
              ),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 16),
              // Fuel type and Transmission
              // Goi ham de thuc thi tac vu can thiet.
              Row(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                children: [
                  // Goi ham de thuc thi tac vu can thiet.
                  Expanded(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    child: DropdownButtonFormField<String>(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      value: _fuelType,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      decoration: const InputDecoration(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        labelText: 'Nhiên liệu',
                      ),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      items: _fuelTypes.map((type) {
                        // Tra ve ket qua cho noi goi ham.
                        return DropdownMenuItem(
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          value: type,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          child: Text(type),
                        );
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      }).toList(),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      onChanged: (value) {
                        // Cap nhat state de giao dien duoc render lai.
                        setState(() => _fuelType = value!);
                      },
                    ),
                  ),
                  // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                  const SizedBox(width: 16),
                  // Goi ham de thuc thi tac vu can thiet.
                  Expanded(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    child: DropdownButtonFormField<String>(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      value: _transmission,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      decoration: const InputDecoration(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        labelText: 'Hộp số',
                      ),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      items: _transmissions.map((type) {
                        // Tra ve ket qua cho noi goi ham.
                        return DropdownMenuItem(
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          value: type,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          child: Text(type),
                        );
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      }).toList(),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      onChanged: (value) {
                        // Cap nhat state de giao dien duoc render lai.
                        setState(() => _transmission = value!);
                      },
                    ),
                  ),
                ],
              ),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 16),
              // Description
              // Goi ham de thuc thi tac vu can thiet.
              TextFormField(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                controller: _descriptionController,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                decoration: const InputDecoration(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  labelText: 'Mô tả',
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  hintText: 'Nhập mô tả chi tiết về xe...',
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  alignLabelWithHint: true,
                ),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                maxLines: 4,
              ),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 32),
              // Submit button
              // Goi ham de thuc thi tac vu can thiet.
              ElevatedButton(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                onPressed: _isLoading ? null : _handleSubmit,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: _isLoading
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    ? const SizedBox(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        height: 20,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        width: 20,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        child: CircularProgressIndicator(
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          strokeWidth: 2,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          valueColor:
                              // Thuc thi cau lenh hien tai theo luong xu ly.
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    : const Text('Thêm xe'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
