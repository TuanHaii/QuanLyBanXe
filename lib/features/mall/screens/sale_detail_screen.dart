// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';
// Nap thu vien hoac module can thiet.
import 'package:intl/intl.dart';

// Nap thu vien hoac module can thiet.
import '../models/mall_model.dart';
// Nap thu vien hoac module can thiet.
import '../services/sale_service.dart';
// Nap thu vien hoac module can thiet.
import '../../../shared/services/service_locator.dart';

// Dinh nghia lop SaleDetailScreen de gom nhom logic lien quan.
class SaleDetailScreen extends StatefulWidget {
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String saleId;

  // Khai bao bien SaleDetailScreen de luu du lieu su dung trong xu ly.
  const SaleDetailScreen({super.key, required this.saleId});

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Thuc thi cau lenh hien tai theo luong xu ly.
  State<SaleDetailScreen> createState() => _SaleDetailScreenState();
}

// Dinh nghia lop _SaleDetailScreenState de gom nhom logic lien quan.
class _SaleDetailScreenState extends State<SaleDetailScreen> {
  // Khai bao bien SaleService de luu du lieu su dung trong xu ly.
  final SaleService _saleService = getIt<SaleService>();
  // Thuc thi cau lenh hien tai theo luong xu ly.
  SaleModel? _sale;
  // Khai bao bien _isLoading de luu du lieu su dung trong xu ly.
  bool _isLoading = true;
  // Thuc thi cau lenh hien tai theo luong xu ly.
  String? _error;

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Dinh nghia ham initState de xu ly nghiep vu tuong ung.
  void initState() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.initState();
    // Khai bao constructor _loadSaleDetail de khoi tao doi tuong.
    _loadSaleDetail();
  }

  // Khai bao bien _loadSaleDetail de luu du lieu su dung trong xu ly.
  Future<void> _loadSaleDetail() async {
    // Bao boc khoi lenh co the phat sinh loi de xu ly an toan.
    try {
      // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
      final sale = await _saleService.fetchSaleById(widget.saleId);
      // Cap nhat state de giao dien duoc render lai.
      setState(() {
        // Gan gia tri cho bien _sale.
        _sale = sale;
        // Gan gia tri cho bien _error.
        _error = null;
      });
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } catch (error) {
      // Cap nhat state de giao dien duoc render lai.
      setState(() {
        // Gan gia tri cho bien _error.
        _error = error.toString();
      });
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } finally {
      // Cap nhat state de giao dien duoc render lai.
      setState(() {
        // Gan gia tri cho bien _isLoading.
        _isLoading = false;
      });
    }
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Tra ve ket qua cho noi goi ham.
    return Scaffold(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      appBar: AppBar(title: const Text('Chi tiết giao dịch')),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      body: SafeArea(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: Padding(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          padding: const EdgeInsets.all(16),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: _isLoading
              // Thuc thi cau lenh hien tai theo luong xu ly.
              ? const Center(child: CircularProgressIndicator())
              // Thuc thi cau lenh hien tai theo luong xu ly.
              : _error != null
              // Thuc thi cau lenh hien tai theo luong xu ly.
              ? Center(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  child: Text(
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    _error!,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              // Thuc thi cau lenh hien tai theo luong xu ly.
              : _sale == null
              // Thuc thi cau lenh hien tai theo luong xu ly.
              ? const Center(child: Text('Không tìm thấy giao dịch.'))
              // Thuc thi cau lenh hien tai theo luong xu ly.
              : _buildSaleDetail(context),
        ),
      ),
    );
  }

  // Khai bao bien _buildSaleDetail de luu du lieu su dung trong xu ly.
  Widget _buildSaleDetail(BuildContext context) {
    // Khai bao bien sale de luu du lieu su dung trong xu ly.
    final sale = _sale!;
    // Tra ve ket qua cho noi goi ham.
    return ListView(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      children: [
        // Goi ham de thuc thi tac vu can thiet.
        _buildSection(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          title: 'Thông tin xe',
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          children: [
            // Goi ham de thuc thi tac vu can thiet.
            _buildDetailRow('Tên xe', sale.carName),
            // Goi ham de thuc thi tac vu can thiet.
            _buildDetailRow('Giá bán', sale.formattedPrice),
            // Goi ham de thuc thi tac vu can thiet.
            _buildDetailRow('Trạng thái', sale.statusText),
          ],
        ),
        // Goi ham de thuc thi tac vu can thiet.
        _buildSection(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          title: 'Khách hàng',
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          children: [
            // Goi ham de thuc thi tac vu can thiet.
            _buildDetailRow('Tên khách hàng', sale.customerName),
            // Goi ham de thuc thi tac vu can thiet.
            _buildDetailRow('Email', sale.customerEmail ?? '-'),
            // Goi ham de thuc thi tac vu can thiet.
            _buildDetailRow('Số điện thoại', sale.customerPhone ?? '-'),
          ],
        ),
        // Goi ham de thuc thi tac vu can thiet.
        _buildSection(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          title: 'Chi tiết thanh toán',
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          children: [
            // Goi ham de thuc thi tac vu can thiet.
            _buildDetailRow('Giá bán', sale.formattedPrice),
            // Goi ham de thuc thi tac vu can thiet.
            _buildDetailRow(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              'Chiết khấu',
              // Thuc thi cau lenh hien tai theo luong xu ly.
              sale.discount != null
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  ? '${sale.discount!.toStringAsFixed(0)} VNĐ'
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  : '0 VNĐ',
            ),
            // Goi ham de thuc thi tac vu can thiet.
            _buildDetailRow(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              'Cọc',
              // Thuc thi cau lenh hien tai theo luong xu ly.
              sale.deposit != null
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  ? '${sale.deposit!.toStringAsFixed(0)} VNĐ'
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  : '0 VNĐ',
            ),
            // Goi ham de thuc thi tac vu can thiet.
            _buildDetailRow(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              'Tổng thanh toán',
              // Thuc thi cau lenh hien tai theo luong xu ly.
              '${sale.finalPrice.toStringAsFixed(0)} VNĐ',
            ),
          ],
        ),
        // Goi ham de thuc thi tac vu can thiet.
        _buildSection(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          title: 'Thời gian',
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          children: [
            // Goi ham de thuc thi tac vu can thiet.
            _buildDetailRow(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              'Ngày bán',
              // Goi ham de thuc thi tac vu can thiet.
              DateFormat('dd/MM/yyyy HH:mm').format(sale.saleDate),
            ),
            // Goi ham de thuc thi tac vu can thiet.
            _buildDetailRow(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              'Tạo lúc',
              // Thuc thi cau lenh hien tai theo luong xu ly.
              sale.createdAt != null
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  ? DateFormat('dd/MM/yyyy HH:mm').format(sale.createdAt!)
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  : '-',
            ),
            // Goi ham de thuc thi tac vu can thiet.
            _buildDetailRow(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              'Cập nhật',
              // Thuc thi cau lenh hien tai theo luong xu ly.
              sale.updatedAt != null
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  ? DateFormat('dd/MM/yyyy HH:mm').format(sale.updatedAt!)
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  : '-',
            ),
          ],
        ),
        // Kiem tra dieu kien de re nhanh xu ly.
        if ((sale.notes ?? '').isNotEmpty)
          // Goi ham de thuc thi tac vu can thiet.
          _buildSection(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            title: 'Ghi chú',
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Goi ham de thuc thi tac vu can thiet.
              Padding(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: Text(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  sale.notes!,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
      ],
    );
  }

  // Khai bao bien _buildSection de luu du lieu su dung trong xu ly.
  Widget _buildSection({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required String title,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required List<Widget> children,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) {
    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      margin: const EdgeInsets.only(bottom: 16),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: const EdgeInsets.all(16),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: const Color(0xFF121316),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(16),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Column(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        crossAxisAlignment: CrossAxisAlignment.start,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: [
          // Goi ham de thuc thi tac vu can thiet.
          Text(
            // Thuc thi cau lenh hien tai theo luong xu ly.
            title,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            style: Theme.of(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              context,
            // Thuc thi cau lenh hien tai theo luong xu ly.
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
          const SizedBox(height: 10),
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ...children,
        ],
      ),
    );
  }

  // Khai bao bien _buildDetailRow de luu du lieu su dung trong xu ly.
  Widget _buildDetailRow(String label, String value) {
    // Tra ve ket qua cho noi goi ham.
    return Padding(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: const EdgeInsets.symmetric(vertical: 6.0),
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
            style: Theme.of(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              context,
            // Thuc thi cau lenh hien tai theo luong xu ly.
            ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          Flexible(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Text(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              value,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              textAlign: TextAlign.right,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              style: Theme.of(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                context,
              // Thuc thi cau lenh hien tai theo luong xu ly.
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
