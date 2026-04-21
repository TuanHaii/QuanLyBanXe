//import thư viện dùng các widget như: Text, Icon, Container, TextFormField,...
import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String label; // Nhãn cho trường nhập liệu, ví dụ: "Email", "Password"
  final IconData
  prefixIcon; // Biểu tượng hiển thị ở đầu trường nhập liệu, ví dụ: Icons.email, Icons.lock
  final TextEditingController
  controller; // Bộ điều khiển để quản lý giá trị của trường nhập liệu
  final bool
  isPassword; // Xác định xem trường nhập liệu có phải là trường mật khẩu không
  final bool obscureText; // Xác định xem nội dung có bị ẩn không
  final VoidCallback?
  onToggleVisibility; // Callback để chuyển đổi trạng thái hiển thị mật khẩu
  final Widget? suffixIcon; // Widget hiển thị ở cuối trường nhập liệu
  final Widget? trailingAction;
  const AuthTextField({
    super.key,
    required this.label,
    required this.prefixIcon,
    required this.controller,
    this.isPassword = false,
    this.obscureText = false,
    this.onToggleVisibility,
    this.suffixIcon,
    this.trailingAction,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // label và nút forgot
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: 0.7),
                letterSpacing: 1.2, // Tăng khoảng cách giữa các chữ cái
              ),
            ),
            if (trailingAction != null) trailingAction!,
          ],
        ),
        const SizedBox(height: 8),
        // ô nhập liệu
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF121316),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              prefixIcon: Icon(
                prefixIcon,
                color: Colors.white.withValues(alpha: 0.5),
                size: 20,
              ),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white.withValues(alpha: 0.5),
                        size: 20,
                      ),
                      onPressed: onToggleVisibility,
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
