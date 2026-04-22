// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';
// Nap thu vien hoac module can thiet.
import 'package:intl/intl.dart';

// Nap thu vien hoac module can thiet.
import '../models/mall_model.dart';
// Nap thu vien hoac module can thiet.
import '../../../shared/themes/app_colors.dart';

// Dinh nghia lop SaleListItem de gom nhom logic lien quan.
class SaleListItem extends StatelessWidget {
  // Khai bao bien SaleModel de luu du lieu su dung trong xu ly.
  final SaleModel sale;
  // Khai bao bien VoidCallback de luu du lieu su dung trong xu ly.
  final VoidCallback onTap;

  // Khai bao bien SaleListItem de luu du lieu su dung trong xu ly.
  const SaleListItem({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.key,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.sale,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.onTap,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Tra ve ket qua cho noi goi ham.
    return Card(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      margin: const EdgeInsets.only(bottom: 12),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: InkWell(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onTap: onTap,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(12),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: Padding(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          padding: const EdgeInsets.all(16),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Column(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            crossAxisAlignment: CrossAxisAlignment.start,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
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
                      sale.carName,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            fontWeight: FontWeight.bold,
                          ),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      maxLines: 1,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Goi ham de thuc thi tac vu can thiet.
                  Container(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    padding: const EdgeInsets.symmetric(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      horizontal: 8,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      vertical: 4,
                    ),
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    decoration: BoxDecoration(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      color: _getStatusColor(sale.status).withValues(alpha: 0.1),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      borderRadius: BorderRadius.circular(12),
                    ),
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    child: Text(
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      sale.statusText,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      style: AppTextStyles.labelMedium.copyWith(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        color: _getStatusColor(sale.status),
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 8),
              // Goi ham de thuc thi tac vu can thiet.
              Row(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                children: [
                  // Khai bao bien Icon de luu du lieu su dung trong xu ly.
                  const Icon(
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    Icons.person_outline,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    size: 16,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: Colors.grey,
                  ),
                  // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                  const SizedBox(width: 4),
                  // Goi ham de thuc thi tac vu can thiet.
                  Text(
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    sale.customerName,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 12),
              // Goi ham de thuc thi tac vu can thiet.
              Row(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                children: [
                  // Goi ham de thuc thi tac vu can thiet.
                  Text(
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    sale.formattedPrice,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          color: Theme.of(context).primaryColor,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  // Goi ham de thuc thi tac vu can thiet.
                  Row(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    children: [
                      // Khai bao bien Icon de luu du lieu su dung trong xu ly.
                      const Icon(
                        // Thuc thi cau lenh hien tai theo luong xu ly.
                        Icons.calendar_today,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        size: 14,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        color: Colors.grey,
                      ),
                      // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                      const SizedBox(width: 4),
                      // Goi ham de thuc thi tac vu can thiet.
                      Text(
                        // Goi ham de thuc thi tac vu can thiet.
                        DateFormat('dd/MM/yyyy').format(sale.saleDate),
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                              color: Colors.grey,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Khai bao bien _getStatusColor de luu du lieu su dung trong xu ly.
  Color _getStatusColor(SaleStatus status) {
    // Bat dau re nhanh theo nhieu truong hop gia tri.
    switch (status) {
      // Xu ly mot truong hop cu the trong switch.
      case SaleStatus.pending:
        // Tra ve ket qua cho noi goi ham.
        return Colors.orange;
      // Xu ly mot truong hop cu the trong switch.
      case SaleStatus.completed:
        // Tra ve ket qua cho noi goi ham.
        return Colors.green;
      // Xu ly mot truong hop cu the trong switch.
      case SaleStatus.cancelled:
        // Tra ve ket qua cho noi goi ham.
        return Colors.red;
    }
  }
}
