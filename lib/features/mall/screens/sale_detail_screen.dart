import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/mall_model.dart';
import '../services/sale_service.dart';
import '../../../shared/services/service_locator.dart';

class SaleDetailScreen extends StatefulWidget {
  final String saleId;

  const SaleDetailScreen({super.key, required this.saleId});

  @override
  State<SaleDetailScreen> createState() => _SaleDetailScreenState();
}

class _SaleDetailScreenState extends State<SaleDetailScreen> {
  final SaleService _saleService = getIt<SaleService>();
  SaleModel? _sale;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadSaleDetail();
  }

  Future<void> _loadSaleDetail() async {
    try {
      final sale = await _saleService.fetchSaleById(widget.saleId);
      setState(() {
        _sale = sale;
        _error = null;
      });
    } catch (error) {
      setState(() {
        _error = error.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chi tiết giao dịch')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
              ? Center(
                  child: Text(
                    _error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : _sale == null
              ? const Center(child: Text('Không tìm thấy giao dịch.'))
              : _buildSaleDetail(context),
        ),
      ),
    );
  }

  Widget _buildSaleDetail(BuildContext context) {
    final sale = _sale!;
    return ListView(
      children: [
        _buildSection(
          title: 'Thông tin xe',
          children: [
            _buildDetailRow('Tên xe', sale.carName),
            _buildDetailRow('Giá bán', sale.formattedPrice),
            _buildDetailRow('Trạng thái', sale.statusText),
          ],
        ),
        _buildSection(
          title: 'Khách hàng',
          children: [
            _buildDetailRow('Tên khách hàng', sale.customerName),
            _buildDetailRow('Email', sale.customerEmail ?? '-'),
            _buildDetailRow('Số điện thoại', sale.customerPhone ?? '-'),
          ],
        ),
        _buildSection(
          title: 'Chi tiết thanh toán',
          children: [
            _buildDetailRow('Giá bán', sale.formattedPrice),
            _buildDetailRow(
              'Chiết khấu',
              sale.discount != null
                  ? '${sale.discount!.toStringAsFixed(0)} VNĐ'
                  : '0 VNĐ',
            ),
            _buildDetailRow(
              'Cọc',
              sale.deposit != null
                  ? '${sale.deposit!.toStringAsFixed(0)} VNĐ'
                  : '0 VNĐ',
            ),
            _buildDetailRow(
              'Tổng thanh toán',
              '${sale.finalPrice.toStringAsFixed(0)} VNĐ',
            ),
          ],
        ),
        _buildSection(
          title: 'Thời gian',
          children: [
            _buildDetailRow(
              'Ngày bán',
              DateFormat('dd/MM/yyyy HH:mm').format(sale.saleDate),
            ),
            _buildDetailRow(
              'Tạo lúc',
              sale.createdAt != null
                  ? DateFormat('dd/MM/yyyy HH:mm').format(sale.createdAt!)
                  : '-',
            ),
            _buildDetailRow(
              'Cập nhật',
              sale.updatedAt != null
                  ? DateFormat('dd/MM/yyyy HH:mm').format(sale.updatedAt!)
                  : '-',
            ),
          ],
        ),
        if ((sale.notes ?? '').isNotEmpty)
          _buildSection(
            title: 'Ghi chú',
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  sale.notes!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF121316),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
