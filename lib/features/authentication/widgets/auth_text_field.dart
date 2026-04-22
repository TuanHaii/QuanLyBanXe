// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';

// Dinh nghia lop AuthTextField de gom nhom logic lien quan.
class AuthTextField extends StatelessWidget {
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String label; // Nhãn cho trường nhập liệu, ví dụ: "Email", "Password"
  // Khai bao bien IconData de luu du lieu su dung trong xu ly.
  final IconData
  // Thuc thi cau lenh hien tai theo luong xu ly.
  prefixIcon; // Biểu tượng hiển thị ở đầu trường nhập liệu, ví dụ: Icons.email, Icons.lock
  // Khai bao bien TextEditingController de luu du lieu su dung trong xu ly.
  final TextEditingController
  // Thuc thi cau lenh hien tai theo luong xu ly.
  controller; // Bộ điều khiển để quản lý giá trị của trường nhập liệu
  // Khai bao bien bool de luu du lieu su dung trong xu ly.
  final bool
  // Thuc thi cau lenh hien tai theo luong xu ly.
  isPassword; // Xác định xem trường nhập liệu có phải là trường mật khẩu không
  // Khai bao bien bool de luu du lieu su dung trong xu ly.
  final bool obscureText; // Xác định xem nội dung có bị ẩn không
  // Khai bao bien VoidCallback de luu du lieu su dung trong xu ly.
  final VoidCallback?
  // Thuc thi cau lenh hien tai theo luong xu ly.
  onToggleVisibility; // Callback để chuyển đổi trạng thái hiển thị mật khẩu
  // Khai bao bien Widget de luu du lieu su dung trong xu ly.
  final Widget? suffixIcon; // Widget hiển thị ở cuối trường nhập liệu
  // Khai bao bien Widget de luu du lieu su dung trong xu ly.
  final Widget? trailingAction;
  // Khai bao bien AuthTextField de luu du lieu su dung trong xu ly.
  const AuthTextField({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.key,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.label,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.prefixIcon,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.controller,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.isPassword = false,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.obscureText = false,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.onToggleVisibility,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.suffixIcon,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.trailingAction,
  });
  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien colorScheme de luu du lieu su dung trong xu ly.
    final colorScheme = Theme.of(context).colorScheme;
    // Khai bao bien onSurface de luu du lieu su dung trong xu ly.
    final onSurface = colorScheme.onSurface;

    // Tra ve ket qua cho noi goi ham.
    return Column(
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
            Text(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              label,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              style: TextStyle(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                fontSize: 15,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                fontWeight: FontWeight.w600,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                color: onSurface.withValues(alpha: 0.72),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                letterSpacing: 1.2, // Tăng khoảng cách giữa các chữ cái
              ),
            ),
            // ignore: use_null_aware_elements
            // Kiem tra dieu kien de re nhanh xu ly.
            if (trailingAction != null) trailingAction!,
          ],
        ),
        // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
        const SizedBox(height: 8),
        // Goi ham de thuc thi tac vu can thiet.
        Container(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          decoration: BoxDecoration(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: colorScheme.surface,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            borderRadius: BorderRadius.circular(8),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            border: Border.all(color: onSurface.withValues(alpha: 0.08)),
          ),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: TextFormField(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            controller: controller,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            obscureText: obscureText,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            style: TextStyle(color: onSurface, fontSize: 14),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            decoration: InputDecoration(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              border: InputBorder.none,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              prefixIcon: Icon(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                prefixIcon,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                color: onSurface.withValues(alpha: 0.58),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                size: 20,
              ),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              suffixIcon: isPassword
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  ? IconButton(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      icon: Icon(
                        // Thuc thi cau lenh hien tai theo luong xu ly.
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        color: onSurface.withValues(alpha: 0.58),
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        size: 20,
                      ),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      onPressed: onToggleVisibility,
                    )
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
