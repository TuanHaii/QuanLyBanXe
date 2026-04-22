import 'package:flutter/material.dart';

import '../../../shared/services/service_locator.dart';
import '../../../shared/themes/app_colors.dart';
import '../models/car_model.dart';
import '../services/car_service.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key, this.carId});

  final String? carId;

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final CarService _carService = getIt<CarService>();
  final _formKey = GlobalKey<FormState>();
  final _tenXeController = TextEditingController();
  final _giaBanController = TextEditingController();
  final _namSanXuatController = TextEditingController();
  final _mauSacController = TextEditingController();
  final _soKhungController = TextEditingController();
  final _soMayController = TextEditingController();
  final _dungTichController = TextEditingController();
  final _soLuongTonController = TextEditingController(text: '0');
  final _maHangController = TextEditingController();
  final _maLoaiXeController = TextEditingController();

  CarModel? _editingCar;
  bool _isLoadingExistingCar = false;
  bool _isSubmitting = false;
  bool _trangThai = true;

  @override
  void initState() {
    super.initState();
    final carId = widget.carId?.trim();
    if (carId?.isNotEmpty ?? false) {
      _loadCarForEditing(carId!);
    }
  }

  @override
  void dispose() {
    _tenXeController.dispose();
    _giaBanController.dispose();
    _namSanXuatController.dispose();
    _mauSacController.dispose();
    _soKhungController.dispose();
    _soMayController.dispose();
    _dungTichController.dispose();
    _soLuongTonController.dispose();
    _maHangController.dispose();
    _maLoaiXeController.dispose();
    super.dispose();
  }

  Future<void> _loadCarForEditing(String carId) async {
    setState(() => _isLoadingExistingCar = true);

    try {
      final car = await _carService.layXeTheoMa(int.parse(carId));

      _editingCar = car;
      _tenXeController.text = car.tenXe;
      _giaBanController.text = car.giaBan.toStringAsFixed(0);
      _namSanXuatController.text = car.namSanXuat.toString();
      _mauSacController.text = car.mauSac;
      _soKhungController.text = car.soKhung;
      _soMayController.text = car.soMay;
      _dungTichController.text = car.dungTich ?? '';
      _soLuongTonController.text = car.soLuongTon.toString();
      _maHangController.text = car.maHang.toString();
      _maLoaiXeController.text = car.maLoaiXe.toString();
      _trangThai = car.trangThai;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Không tải được dữ liệu xe: ${e.toString()}'),
            backgroundColor: AppColors.error,
          ),
        );
        Navigator.pop(context, false);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoadingExistingCar = false);
      }
    }
  }

  CarModel _buildCarPayload() {
    return CarModel(
      maXe: _editingCar?.maXe ?? 0,
      tenXe: _tenXeController.text.trim(),
      giaBan: double.parse(_giaBanController.text.trim()),
      namSanXuat: int.parse(_namSanXuatController.text.trim()),
      mauSac: _mauSacController.text.trim(),
      soKhung: _soKhungController.text.trim(),
      soMay: _soMayController.text.trim(),
      dungTich: _dungTichController.text.trim().isEmpty
          ? null
          : _dungTichController.text.trim(),
      soLuongTon: int.tryParse(_soLuongTonController.text.trim()) ?? 0,
      trangThai: _trangThai,
      maHang: int.parse(_maHangController.text.trim()),
      maLoaiXe: int.parse(_maLoaiXeController.text.trim()),
    );
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final payload = _buildCarPayload();

      if (_editingCar != null) {
        await _carService.suaXe(_editingCar!.maXe, payload);
      } else {
        await _carService.themXe(payload);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _editingCar != null
                  ? 'Cập nhật xe thành công!'
                  : 'Thêm xe thành công!',
            ),
            backgroundColor: AppColors.success,
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi: ${e.toString()}'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = _editingCar != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Cập nhật xe' : 'Thêm xe mới')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: _isLoadingExistingCar
            ? const Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSection(
                      context,
                      title: 'Thông tin cơ bản',
                      children: [
                        TextFormField(
                          controller: _tenXeController,
                          decoration: const InputDecoration(
                            labelText: 'Tên xe *',
                            hintText: 'VD: Toyota Camry 2024',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Vui lòng nhập tên xe';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _giaBanController,
                                decoration: const InputDecoration(
                                  labelText: 'Giá bán *',
                                  hintText: 'VD: 1250000000',
                                  suffixText: 'VNĐ',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Vui lòng nhập giá bán';
                                  }
                                  final giaBan = double.tryParse(value.trim());
                                  if (giaBan == null || giaBan <= 0) {
                                    return 'Giá không hợp lệ';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextFormField(
                                controller: _namSanXuatController,
                                decoration: const InputDecoration(
                                  labelText: 'Năm sản xuất *',
                                  hintText: 'VD: 2024',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Vui lòng nhập năm sản xuất';
                                  }
                                  final year = int.tryParse(value.trim());
                                  if (year == null ||
                                      year < 1900 ||
                                      year > 2100) {
                                    return 'Năm không hợp lệ';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _mauSacController,
                          decoration: const InputDecoration(
                            labelText: 'Màu sắc *',
                            hintText: 'VD: Đen',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Vui lòng nhập màu sắc';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildSection(
                      context,
                      title: 'Thông số xe',
                      children: [
                        TextFormField(
                          controller: _soKhungController,
                          decoration: const InputDecoration(
                            labelText: 'Số khung *',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Vui lòng nhập số khung';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _soMayController,
                          decoration: const InputDecoration(
                            labelText: 'Số máy *',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Vui lòng nhập số máy';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _dungTichController,
                          decoration: const InputDecoration(
                            labelText: 'Dung tích động cơ',
                            hintText: 'VD: 2.0L',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildSection(
                      context,
                      title: 'Hãng xe & loại xe',
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _maHangController,
                                decoration: const InputDecoration(
                                  labelText: 'Mã hãng *',
                                  hintText: 'VD: 1',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Vui lòng nhập mã hãng';
                                  }
                                  if (int.tryParse(value.trim()) == null) {
                                    return 'Mã hãng phải là số';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextFormField(
                                controller: _maLoaiXeController,
                                decoration: const InputDecoration(
                                  labelText: 'Mã loại xe *',
                                  hintText: 'VD: 1',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Vui lòng nhập mã loại xe';
                                  }
                                  if (int.tryParse(value.trim()) == null) {
                                    return 'Mã loại xe phải là số';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _soLuongTonController,
                          decoration: const InputDecoration(
                            labelText: 'Số lượng tồn',
                            hintText: 'VD: 0',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Vui lòng nhập số lượng tồn';
                            }
                            final stock = int.tryParse(value.trim());
                            if (stock == null || stock < 0) {
                              return 'Số lượng tồn không hợp lệ';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: _trangThai,
                          onChanged: (value) =>
                              setState(() => _trangThai = value),
                          title: const Text('Đang bán'),
                          subtitle: const Text('Tắt để đánh dấu ngừng bán'),
                        ),
                      ],
                    ),
                    if (isEditing && _editingCar != null) ...[
                      const SizedBox(height: 16),
                      _buildDetailSummary(context),
                    ],
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: (_isSubmitting || _isLoadingExistingCar)
                          ? null
                          : _handleSubmit,
                      child: _isSubmitting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : Text(isEditing ? 'Cập nhật xe' : 'Thêm xe'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildDetailSummary(BuildContext context) {
    final car = _editingCar!;

    return _buildSection(
      context,
      title: 'Chi tiết xe hiện tại',
      children: [
        _detailRow('Mã xe', '#${car.maXe}'),
        _detailRow('Tên xe', car.tenXe),
        _detailRow('Giá bán', '${car.giaBan.toStringAsFixed(0)} VNĐ'),
        _detailRow('Năm sản xuất', car.namSanXuat.toString()),
        _detailRow('Màu sắc', car.mauSac),
        _detailRow('Số khung', car.soKhung),
        _detailRow('Số máy', car.soMay),
        _detailRow('Dung tích', car.dungTich ?? '-'),
        _detailRow('Số lượng tồn', car.soLuongTon.toString()),
        _detailRow('Trạng thái', car.trangThai ? 'Đang bán' : 'Ngừng bán'),
      ],
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(flex: 6, child: Text(value, textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }
}
