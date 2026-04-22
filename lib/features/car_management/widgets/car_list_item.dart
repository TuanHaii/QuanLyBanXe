// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';

// Nap thu vien hoac module can thiet.
import '../models/car_model.dart';
// Nap thu vien hoac module can thiet.
import '../../../shared/themes/app_colors.dart';

// Dinh nghia lop CarListItem de gom nhom logic lien quan.
class CarListItem extends StatelessWidget {
  // Khai bao bien CarModel de luu du lieu su dung trong xu ly.
  final CarModel car;
  // Khai bao bien VoidCallback de luu du lieu su dung trong xu ly.
  final VoidCallback onTap;

  // Khai bao bien CarListItem de luu du lieu su dung trong xu ly.
  const CarListItem({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.key,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.car,
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
          padding: const EdgeInsets.all(12),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Row(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Car image
              // Goi ham de thuc thi tac vu can thiet.
              Container(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                width: 100,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                height: 80,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                decoration: BoxDecoration(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: Colors.grey[200],
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  borderRadius: BorderRadius.circular(8),
                ),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: car.images.isNotEmpty
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    ? ClipRRect(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        borderRadius: BorderRadius.circular(8),
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        child: Image.network(
                          // Thuc thi cau lenh hien tai theo luong xu ly.
                          car.images.first,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          fit: BoxFit.cover,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          errorBuilder: (_, __, ___) => const Icon(
                            // Thuc thi cau lenh hien tai theo luong xu ly.
                            Icons.directions_car,
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            size: 40,
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            color: Colors.grey,
                          ),
                        ),
                      )
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    : const Icon(
                        // Thuc thi cau lenh hien tai theo luong xu ly.
                        Icons.directions_car,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        size: 40,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        color: Colors.grey,
                      ),
              ),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(width: 12),
              // Car info
              // Goi ham de thuc thi tac vu can thiet.
              Expanded(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: Column(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  children: [
                    // Goi ham de thuc thi tac vu can thiet.
                    Text(
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      car.name,
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
                    // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                    const SizedBox(height: 4),
                    // Goi ham de thuc thi tac vu can thiet.
                    Text(
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      '${car.brand} • ${car.year} • ${car.color}',
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            color: Colors.grey,
                          ),
                    ),
                    // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                    const SizedBox(height: 8),
                    // Goi ham de thuc thi tac vu can thiet.
                    Row(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      children: [
                        // Goi ham de thuc thi tac vu can thiet.
                        Text(
                          // Thuc thi cau lenh hien tai theo luong xu ly.
                          car.formattedPrice,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          style:
                              // Thuc thi cau lenh hien tai theo luong xu ly.
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                                    color: Theme.of(context).primaryColor,
                                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                                    fontWeight: FontWeight.bold,
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
                            color: _getStatusColor(car.status).withValues(alpha: .1),
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            borderRadius: BorderRadius.circular(12),
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
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(width: 8),
              // Khai bao bien Icon de luu du lieu su dung trong xu ly.
              const Icon(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                Icons.chevron_right,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                color: Colors.grey,
              ),
            ],
          ),
        ),
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
}
