import 'package:flutter/material.dart';

import '../models/mall_product_model.dart';

class SellCarSheet extends StatefulWidget {
  final MallProduct product;
  final Future<Map<String, dynamic>> Function({
    required String hoTen,
    required String sdt,
    String? email,
    String? diaChi,
    required int diemTichLuy,
    required String phuongThucThanhToan,
  })
  onSubmit;

  const SellCarSheet({
    super.key,
    required this.product,
    required this.onSubmit,
  });

  @override
  State<SellCarSheet> createState() => _SellCarSheetState();
}

class _SellCarSheetState extends State<SellCarSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _pointsController = TextEditingController(text: '0');

  bool _isSubmitting = false;
  String _paymentMethod = 'Tiền mặt';

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _pointsController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final result = await widget.onSubmit(
        hoTen: _nameController.text,
        sdt: _phoneController.text,
        email: _emailController.text,
        diaChi: _addressController.text,
        diemTichLuy: int.tryParse(_pointsController.text.trim()) ?? 0,
        phuongThucThanhToan: _paymentMethod,
      );

      if (!mounted) {
        return;
      }

      Navigator.of(context).pop(result);
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            behavior: SnackBarBehavior.floating,
          ),
        );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return SafeArea(
      top: false,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 42,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Thông tin xe',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.04),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 2),
                        Text('${product.year} · ${product.category}'),
                        const SizedBox(height: 4),
                        Text('Giá bán: ${product.priceLabel}'),
                        Text('Tồn kho: ${product.stock}'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Thông tin khách hàng',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Họ tên',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Vui lòng nhập họ tên';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Số điện thoại',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      final input = value?.trim() ?? '';
                      if (input.isEmpty) {
                        return 'Vui lòng nhập số điện thoại';
                      }
                      if (input.length < 8) {
                        return 'Số điện thoại không hợp lệ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email (không bắt buộc)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      final input = value?.trim() ?? '';
                      if (input.isEmpty) {
                        return null;
                      }
                      final isValid = RegExp(r'.+@.+\..+').hasMatch(input);
                      return isValid ? null : 'Email không hợp lệ';
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      labelText: 'Địa chỉ',
                      border: OutlineInputBorder(),
                    ),
                    minLines: 1,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _pointsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Điểm tích lũy cộng thêm',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      final points = int.tryParse(value?.trim() ?? '0');
                      if (points == null || points < 0) {
                        return 'Điểm tích lũy phải >= 0';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _paymentMethod,
                    items: const [
                      DropdownMenuItem(
                        value: 'Tiền mặt',
                        child: Text('Tiền mặt'),
                      ),
                      DropdownMenuItem(
                        value: 'Chuyển khoản',
                        child: Text('Chuyển khoản'),
                      ),
                      DropdownMenuItem(
                        value: 'Quẹt thẻ',
                        child: Text('Quẹt thẻ'),
                      ),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Phương thức thanh toán',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _paymentMethod = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _isSubmitting ? null : _submit,
                      icon: _isSubmitting
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.point_of_sale_rounded),
                      label: Text(
                        _isSubmitting
                            ? 'Đang bán xe...'
                            : 'Bán xe & tạo hóa đơn',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
