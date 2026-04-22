// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';
// Nap thu vien hoac module can thiet.
import 'package:go_router/go_router.dart';

// Nap thu vien hoac module can thiet.
import '../../../shared/constants/app_constants.dart';
// Nap thu vien hoac module can thiet.
import '../../../shared/services/service_locator.dart';
// Nap thu vien hoac module can thiet.
import '../services/auth_service.dart';

// Dinh nghia lop SplashScreen de gom nhom logic lien quan.
class SplashScreen extends StatefulWidget {
  // Khai bao bien SplashScreen de luu du lieu su dung trong xu ly.
  const SplashScreen({super.key});

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Thuc thi cau lenh hien tai theo luong xu ly.
  State<SplashScreen> createState() => _SplashScreenState();
}

// Dinh nghia lop _SplashScreenState de gom nhom logic lien quan.
class _SplashScreenState extends State<SplashScreen> {
  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Dinh nghia ham initState de xu ly nghiep vu tuong ung.
  void initState() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.initState();
    // Khai bao constructor _initApp de khoi tao doi tuong.
    _initApp();
  }

  // Khai bao bien _initApp de luu du lieu su dung trong xu ly.
  Future<void> _initApp() async {
    // Simulate loading time
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await Future.delayed(const Duration(seconds: 2));

    // Kiem tra dieu kien de re nhanh xu ly.
    if (!mounted) return;

    // Check auth state and navigate
    // Khai bao bien authService de luu du lieu su dung trong xu ly.
    final authService = getIt<AuthService>();
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await authService.initializeAuth();

    // Kiem tra dieu kien de re nhanh xu ly.
    if (!mounted) {
      // Tra ve ket qua cho noi goi ham.
      return;
    }

    // Kiem tra dieu kien de re nhanh xu ly.
    if (authService.isLoggedIn) {
      // Thuc thi cau lenh hien tai theo luong xu ly.
      context.go(RouteNames.dashboard);
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } else {
      // Thuc thi cau lenh hien tai theo luong xu ly.
      context.go(RouteNames.login);
    }
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Tra ve ket qua cho noi goi ham.
    return Scaffold(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      body: Center(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: Column(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          mainAxisAlignment: MainAxisAlignment.center,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          children: [
            // App Logo
            // Goi ham de thuc thi tac vu can thiet.
            Icon(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              Icons.directions_car,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              size: 100,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: Theme.of(context).primaryColor,
            ),
            // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
            const SizedBox(height: 24),
            // App Name
            // Goi ham de thuc thi tac vu can thiet.
            Text(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              AppConstants.appName,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontWeight: FontWeight.bold,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
            const SizedBox(height: 48),
            // Loading indicator
            // Khai bao bien CircularProgressIndicator de luu du lieu su dung trong xu ly.
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
