import 'package:flutter/material.dart';

import '../../../shared/services/service_locator.dart';
import '../../../shared/themes/app_colors.dart';
import '../models/car_model.dart';
import '../models/catalog_option_model.dart';
import '../services/car_service.dart';

class QuickAddCarSheet extends StatefulWidget {
  const QuickAddCarSheet({super.key});

  @override
  State<QuickAddCarSheet> createState() => _QuickAddCarSheetState();
}

class _QuickAddCarSheetState extends State<QuickAddCarSheet> {
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
  final _hangXeController = TextEditingController();
  final _loaiXeController = TextEditingController();

  bool _trangThai = true;
  bool _isSubmitting = false;
  bool _isLoadingCatalog = true;
  String? _catalogError;
  List<CatalogOption> _brands = [];
  List<CatalogOption> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadCatalogOptions();
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
    _hangXeController.dispose();
    _loaiXeController.dispose();
    super.dispose();
  }

  Future<void> _loadCatalogOptions() async {
    setState(() {
      _isLoadingCatalog = true;
      _catalogError = null;
    });

    try {
      final results = await Future.wait([
        _carService.fetchBrands(),
        _carService.fetchCarTypes(),
      ]);

      if (!mounted) {
        return;
      }

      setState(() {
        _brands = results[0];
        _categories = results[1];
      });
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        _catalogError = 'Không tải được danh mục hãng/loại xe: ${e.toString()}';
      });
    } finally {
      if (mounted) {
        setState(() => _isLoadingCatalog = false);
      }
    }
  }

  Future<void> _pickBrand() async {
    final selected = await _showCatalogPicker(
      title: 'Chọn hãng xe',
      items: _brands,
      currentValue: _hangXeController.text,
      emptyText: 'Không tìm thấy hãng xe phù hợp',
      createLabel: 'Thêm hãng mới',
    );

    if (!mounted || selected == null) {
      return;
    }

    setState(() {
      _hangXeController.text = selected;
    });
  }

  Future<void> _pickCategory() async {
    final selected = await _showCatalogPicker(
      title: 'Chọn loại xe',
      items: _categories,
      currentValue: _loaiXeController.text,
      emptyText: 'Không tìm thấy loại xe phù hợp',
      createLabel: 'Thêm loại mới',
    );

    if (!mounted || selected == null) {
      return;
    }

    setState(() {
      _loaiXeController.text = selected;
    });
  }

  Future<String?> _showCatalogPicker({
    required String title,
    required List<CatalogOption> items,
    required String
    currentValue, // Vẫn giữ biến này để sau này có thể làm highlight mục đã chọn
    required String emptyText,
    required String createLabel,
  }) {
    // 🛠 CÁCH FIX: Luôn khởi tạo ô tìm kiếm rỗng để show toàn bộ danh sách
    final searchController = TextEditingController(text: '');

    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final query = searchController.text.trim().toLowerCase();
            final filteredItems = items
                .where((item) => item.name.toLowerCase().contains(query))
                .toList(growable: false);
            final canCreateNew =
                searchController.text.trim().isNotEmpty &&
                !items.any(
                  (item) =>
                      item.name.toLowerCase() ==
                      searchController.text.trim().toLowerCase(),
                );

            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.7,
              minChildSize: 0.45,
              maxChildSize: 0.92,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            width: 44,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w800),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(sheetContext),
                              child: const Text('Đóng'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: searchController,
                          decoration: const InputDecoration(
                            hintText: 'Tìm hoặc nhập mới...',
                            prefixIcon: Icon(Icons.search),
                          ),
                          onChanged: (_) => setModalState(() {}),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: filteredItems.isEmpty && !canCreateNew
                              ? Center(child: Text(emptyText))
                              : ListView(
                                  controller: scrollController,
                                  children: [
                                    if (canCreateNew)
                                      ListTile(
                                        leading: const Icon(
                                          Icons.add_circle_outline,
                                        ),
                                        title: Text(
                                          '$createLabel: ${searchController.text.trim()}',
                                        ),
                                        subtitle: const Text(
                                          'Sẽ tự tạo nếu chưa có trong database',
                                        ),
                                        onTap: () {
                                          Navigator.pop(
                                            sheetContext,
                                            searchController.text.trim(),
                                          );
                                        },
                                      ),
                                    ...filteredItems.map((item) {
                                      // 💡 Tiện tay code thêm tính năng highlight mục đang được chọn
                                      final isSelected =
                                          item.name == currentValue;

                                      return ListTile(
                                        leading: Icon(
                                          isSelected
                                              ? Icons.check_circle
                                              : Icons.local_offer_outlined,
                                          color: isSelected
                                              ? AppColors.primary
                                              : Colors.grey,
                                        ),
                                        title: Text(
                                          item.name,
                                          style: TextStyle(
                                            fontWeight: isSelected
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            color: isSelected
                                                ? AppColors.primary
                                                : Colors.black,
                                          ),
                                        ),
                                        subtitle: Text('Mã: ${item.id}'),
                                        // Thêm background nhẹ nếu đang được chọn
                                        tileColor: isSelected
                                            ? AppColors.primary.withOpacity(0.1)
                                            : null,
                                        onTap: () {
                                          Navigator.pop(
                                            sheetContext,
                                            item.name,
                                          );
                                        },
                                      );
                                    }),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    ).whenComplete(searchController.dispose);
  }

  Future<CarModel> _buildPayload() async {
    final brand = await _carService.ensureBrand(_hangXeController.text.trim());
    final category = await _carService.ensureCarType(
      _loaiXeController.text.trim(),
    );

    return CarModel(
      maXe: 0,
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
      maHang: brand.id,
      maLoaiXe: category.id,
      hangXe: HangXeModel(maHang: brand.id, tenHang: brand.name),
      loaiXe: LoaiXeModel(maLoaiXe: category.id, tenLoai: category.name),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      await _carService.themXe(await _buildPayload());

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Thêm xe thành công!'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Thêm xe thất bại: ${e.toString()}'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.92,
          minChildSize: 0.72,
          maxChildSize: 0.96,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(18, 10, 18, 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Container(
                          width: 44,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Thêm xe mới',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Nhập nhanh thông tin trong schema Xe.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (_isLoadingCatalog)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      else if (_catalogError != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              _catalogError!,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.error),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: _loadCatalogOptions,
                              child: const Text('Thử tải lại danh mục'),
                            ),
                          ],
                        )
                      else ...[
                        _section(
                          context,
                          title: 'Thông tin cơ bản',
                          children: [
                            TextFormField(
                              controller: _tenXeController,
                              decoration: const InputDecoration(
                                labelText: 'Tên xe *',
                                hintText: 'VD: Toyota Camry 2024',
                              ),
                              validator: (value) =>
                                  value == null || value.trim().isEmpty
                                  ? 'Vui lòng nhập tên xe'
                                  : null,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _giaBanController,
                                    decoration: const InputDecoration(
                                      labelText: 'Giá bán *',
                                      hintText: 'VD: 1250000000',
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      final parsed = double.tryParse(
                                        value?.trim() ?? '',
                                      );
                                      if (parsed == null || parsed <= 0) {
                                        return 'Giá không hợp lệ';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextFormField(
                                    controller: _namSanXuatController,
                                    decoration: const InputDecoration(
                                      labelText: 'Năm sản xuất *',
                                      hintText: 'VD: 2024',
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      final year = int.tryParse(
                                        value?.trim() ?? '',
                                      );
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
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _mauSacController,
                              decoration: const InputDecoration(
                                labelText: 'Màu sắc *',
                                hintText: 'VD: Đen',
                              ),
                              validator: (value) =>
                                  value == null || value.trim().isEmpty
                                  ? 'Vui lòng nhập màu sắc'
                                  : null,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _section(
                          context,
                          title: 'Thông số xe',
                          children: [
                            TextFormField(
                              controller: _soKhungController,
                              decoration: const InputDecoration(
                                labelText: 'Số khung *',
                              ),
                              validator: (value) =>
                                  value == null || value.trim().isEmpty
                                  ? 'Vui lòng nhập số khung'
                                  : null,
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _soMayController,
                              decoration: const InputDecoration(
                                labelText: 'Số máy *',
                              ),
                              validator: (value) =>
                                  value == null || value.trim().isEmpty
                                  ? 'Vui lòng nhập số máy'
                                  : null,
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _dungTichController,
                              decoration: const InputDecoration(
                                labelText: 'Dung tích động cơ',
                                hintText: 'VD: 2.0L',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _section(
                          context,
                          title: 'Hãng xe & loại xe',
                          children: [
                            _buildPickerField(
                              label: 'Hãng xe *',
                              value: _hangXeController.text,
                              hint: 'Chọn hoặc nhập tên hãng',
                              onTap: _pickBrand,
                            ),
                            const SizedBox(height: 12),
                            _buildPickerField(
                              label: 'Loại xe *',
                              value: _loaiXeController.text,
                              hint: 'Chọn hoặc nhập tên loại xe',
                              onTap: _pickCategory,
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _soLuongTonController,
                              decoration: const InputDecoration(
                                labelText: 'Số lượng tồn *',
                                hintText: 'VD: 0',
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                final stock = int.tryParse(value?.trim() ?? '');
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
                              subtitle: const Text('Tắt để lưu xe ngừng bán'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        ElevatedButton(
                          onPressed: _isSubmitting ? null : _submit,
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
                              : const Text('Thêm xe mới'),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _section(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildPickerField({
    required String label,
    required String hint,
    required String value,
    required VoidCallback onTap,
  }) {
    return FormField<String>(
      initialValue: value,
      validator: (_) => value.trim().isEmpty ? 'Vui lòng chọn giá trị' : null,
      builder: (state) {
        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: label,
              hintText: hint,
              errorText: state.errorText,
              suffixIcon: const Icon(Icons.arrow_drop_down),
            ),
            child: Text(
              value.isEmpty ? 'Chạm để chọn' : value,
              style: TextStyle(
                color: value.isEmpty
                    ? Theme.of(context).hintColor
                    : Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ),
        );
      },
    );
  }
}
