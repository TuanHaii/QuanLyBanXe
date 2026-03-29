import 'package:flutter/material.dart';
// Đảm bảo đường dẫn import này khớp với cấu trúc thư mục của bạn
import 'features/authentication/screens/login_screen.dart'; 

void main() {
  runApp(const PrecisionApp());
}

class PrecisionApp extends StatelessWidget {
  const PrecisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Precision Auto',
      debugShowCheckedModeBanner: false, // Tắt chữ DEBUG ở góc phải
      theme: ThemeData.dark(), // Mặc định bật Dark Theme
      home: const LoginScreen(), // Gọi trang Login bạn vừa code
    );
  }
}