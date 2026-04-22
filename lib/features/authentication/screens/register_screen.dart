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
// Nap thu vien hoac module can thiet.
import '../widgets/auth_header.dart';
// Nap thu vien hoac module can thiet.
import '../widgets/auth_text_field.dart';
// Nap thu vien hoac module can thiet.
import '../widgets/primary_auth_button.dart';

// Dinh nghia lop RegisterScreen de gom nhom logic lien quan.
class RegisterScreen extends StatefulWidget {
  // Khai bao bien RegisterScreen de luu du lieu su dung trong xu ly.
  const RegisterScreen({super.key});

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Thuc thi cau lenh hien tai theo luong xu ly.
  State<RegisterScreen> createState() => _RegisterScreenState();
}

// Dinh nghia lop _RegisterScreenState de gom nhom logic lien quan.
class _RegisterScreenState extends State<RegisterScreen> {
  // Khai bao bien _fullNameController de luu du lieu su dung trong xu ly.
  final _fullNameController = TextEditingController();
  // Khai bao bien _emailController de luu du lieu su dung trong xu ly.
  final _emailController = TextEditingController();
  // Khai bao bien _phoneController de luu du lieu su dung trong xu ly.
  final _phoneController = TextEditingController();
  // Khai bao bien _passwordController de luu du lieu su dung trong xu ly.
  final _passwordController = TextEditingController();
  // Khai bao bien _confirmPasswordController de luu du lieu su dung trong xu ly.
  final _confirmPasswordController = TextEditingController();

  // Khai bao bien _isLoading de luu du lieu su dung trong xu ly.
  bool _isLoading = false;
  // Khai bao bien _obscurePassword de luu du lieu su dung trong xu ly.
  bool _obscurePassword = true;
  // Khai bao bien _obscureConfirmPassword de luu du lieu su dung trong xu ly.
  bool _obscureConfirmPassword = true;

  // Khai bao bien _handleRegister de luu du lieu su dung trong xu ly.
  Future<void> _handleRegister() async {
    // Kiem tra dieu kien de re nhanh xu ly.
    if (_isLoading) {
      // Tra ve ket qua cho noi goi ham.
      return;
    }

    // Khai bao bien fullName de luu du lieu su dung trong xu ly.
    final fullName = _fullNameController.text.trim();
    // Khai bao bien email de luu du lieu su dung trong xu ly.
    final email = _emailController.text.trim();
    // Khai bao bien phone de luu du lieu su dung trong xu ly.
    final phone = _phoneController.text.trim();
    // Khai bao bien password de luu du lieu su dung trong xu ly.
    final password = _passwordController.text;
    // Khai bao bien confirmPassword de luu du lieu su dung trong xu ly.
    final confirmPassword = _confirmPasswordController.text;

    // Kiem tra dieu kien de re nhanh xu ly.
    if (fullName.isEmpty ||
        // Thuc thi cau lenh hien tai theo luong xu ly.
        email.isEmpty ||
        // Thuc thi cau lenh hien tai theo luong xu ly.
        phone.isEmpty ||
        // Thuc thi cau lenh hien tai theo luong xu ly.
        password.isEmpty ||
        // Thuc thi cau lenh hien tai theo luong xu ly.
        confirmPassword.isEmpty) {
      // Thuc thi cau lenh hien tai theo luong xu ly.
      ScaffoldMessenger.of(context).showSnackBar(
        // Khai bao bien SnackBar de luu du lieu su dung trong xu ly.
        const SnackBar(content: Text('Please complete all fields.')),
      );
      // Tra ve ket qua cho noi goi ham.
      return;
    }

    // Kiem tra dieu kien de re nhanh xu ly.
    if (!email.contains('@')) {
      // Thuc thi cau lenh hien tai theo luong xu ly.
      ScaffoldMessenger.of(
        // Thuc thi cau lenh hien tai theo luong xu ly.
        context,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      ).showSnackBar(const SnackBar(content: Text('Email format is invalid.')));
      // Tra ve ket qua cho noi goi ham.
      return;
    }

    // Kiem tra dieu kien de re nhanh xu ly.
    if (password.length < 6) {
      // Thuc thi cau lenh hien tai theo luong xu ly.
      ScaffoldMessenger.of(context).showSnackBar(
        // Khai bao bien SnackBar de luu du lieu su dung trong xu ly.
        const SnackBar(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          content: Text('Password must be at least 6 characters.'),
        ),
      );
      // Tra ve ket qua cho noi goi ham.
      return;
    }

    // Kiem tra dieu kien de re nhanh xu ly.
    if (password != confirmPassword) {
      // Thuc thi cau lenh hien tai theo luong xu ly.
      ScaffoldMessenger.of(context).showSnackBar(
        // Khai bao bien SnackBar de luu du lieu su dung trong xu ly.
        const SnackBar(content: Text('Password confirmation does not match.')),
      );
      // Tra ve ket qua cho noi goi ham.
      return;
    }

    // Cap nhat state de giao dien duoc render lai.
    setState(() => _isLoading = true);

    // Bao boc khoi lenh co the phat sinh loi de xu ly an toan.
    try {
      // Khai bao bien authService de luu du lieu su dung trong xu ly.
      final authService = getIt<AuthService>();
      // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
      await authService.register(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        name: fullName,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        email: email,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        password: password,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        phone: phone,
      );

      // Kiem tra dieu kien de re nhanh xu ly.
      if (!mounted) {
        // Tra ve ket qua cho noi goi ham.
        return;
      }

      // Thuc thi cau lenh hien tai theo luong xu ly.
      ScaffoldMessenger.of(context)
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ..hideCurrentSnackBar()
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ..showSnackBar(
          // Khai bao bien SnackBar de luu du lieu su dung trong xu ly.
          const SnackBar(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            content: Text('Đăng ký thành công.'),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            behavior: SnackBarBehavior.floating,
          ),
        );
      // Thuc thi cau lenh hien tai theo luong xu ly.
      context.go(RouteNames.dashboard);
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } catch (error) {
      // Kiem tra dieu kien de re nhanh xu ly.
      if (!mounted) {
        // Tra ve ket qua cho noi goi ham.
        return;
      }

      // Thuc thi cau lenh hien tai theo luong xu ly.
      ScaffoldMessenger.of(context)
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ..hideCurrentSnackBar()
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ..showSnackBar(
          // Goi ham de thuc thi tac vu can thiet.
          SnackBar(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            content: Text(error.toString().replaceFirst('Exception: ', '')),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            behavior: SnackBarBehavior.floating,
          ),
        );
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } finally {
      // Kiem tra dieu kien de re nhanh xu ly.
      if (mounted) {
        // Cap nhat state de giao dien duoc render lai.
        setState(() => _isLoading = false);
      }
    }
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Dinh nghia ham dispose de xu ly nghiep vu tuong ung.
  void dispose() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _fullNameController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _emailController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _phoneController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _passwordController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _confirmPasswordController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.dispose();
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien theme de luu du lieu su dung trong xu ly.
    final theme = Theme.of(context);
    // Khai bao bien colorScheme de luu du lieu su dung trong xu ly.
    final colorScheme = theme.colorScheme;
    // Khai bao bien onSurface de luu du lieu su dung trong xu ly.
    final onSurface = colorScheme.onSurface;

    // Tra ve ket qua cho noi goi ham.
    return Scaffold(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      backgroundColor: theme.scaffoldBackgroundColor,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      appBar: AppBar(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        backgroundColor: Colors.transparent,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        elevation: 0,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        centerTitle: true,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        title: Text(
          // Thuc thi cau lenh hien tai theo luong xu ly.
          'Create Account',
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          style: TextStyle(color: onSurface),
        ),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      body: SafeArea(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: SingleChildScrollView(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Column(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 12),
              // Khai bao bien AuthHeader de luu du lieu su dung trong xu ly.
              const AuthHeader(),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 24),
              // Goi ham de thuc thi tac vu can thiet.
              Container(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                padding: const EdgeInsets.all(24),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                decoration: BoxDecoration(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: colorScheme.surface,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  borderRadius: BorderRadius.circular(16),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  border: Border.all(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: onSurface.withValues(alpha: 0.08),
                  ),
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
                      'Register',
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      style: TextStyle(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        fontSize: 24,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        fontWeight: FontWeight.bold,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        color: onSurface,
                      ),
                    ),
                    // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                    const SizedBox(height: 8),
                    // Goi ham de thuc thi tac vu can thiet.
                    Text(
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      'Fill your details to create a secure account.',
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      style: TextStyle(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        fontSize: 14,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        color: onSurface.withValues(alpha: 0.68),
                      ),
                    ),
                    // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                    const SizedBox(height: 28),
                    // Goi ham de thuc thi tac vu can thiet.
                    AuthTextField(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      label: 'FULL NAME',
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      prefixIcon: Icons.person_outline,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      controller: _fullNameController,
                    ),
                    // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                    const SizedBox(height: 18),
                    // Goi ham de thuc thi tac vu can thiet.
                    AuthTextField(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      label: 'EMAIL',
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      prefixIcon: Icons.email_outlined,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      controller: _emailController,
                    ),
                    // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                    const SizedBox(height: 18),
                    // Goi ham de thuc thi tac vu can thiet.
                    AuthTextField(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      label: 'PHONE',
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      prefixIcon: Icons.phone_outlined,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      controller: _phoneController,
                    ),
                    // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                    const SizedBox(height: 18),
                    // Goi ham de thuc thi tac vu can thiet.
                    AuthTextField(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      label: 'SECURITY KEY',
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      prefixIcon: Icons.lock_outline,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      controller: _passwordController,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      isPassword: true,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      obscureText: _obscurePassword,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      onToggleVisibility: () {
                        // Cap nhat state de giao dien duoc render lai.
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                    // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                    const SizedBox(height: 18),
                    // Goi ham de thuc thi tac vu can thiet.
                    AuthTextField(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      label: 'CONFIRM KEY',
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      prefixIcon: Icons.lock_person_outlined,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      controller: _confirmPasswordController,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      isPassword: true,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      obscureText: _obscureConfirmPassword,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      onToggleVisibility: () {
                        // Cap nhat state de giao dien duoc render lai.
                        setState(
                          // Thuc thi cau lenh hien tai theo luong xu ly.
                          () => _obscureConfirmPassword =
                              // Thuc thi cau lenh hien tai theo luong xu ly.
                              !_obscureConfirmPassword,
                        );
                      },
                    ),
                    // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                    const SizedBox(height: 28),
                    // Goi ham de thuc thi tac vu can thiet.
                    PrimaryAuthButton(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      text: 'CREATE ACCOUNT',
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      onTap: _handleRegister,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      isLoading: _isLoading,
                    ),
                    // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                    const SizedBox(height: 16),
                    // Goi ham de thuc thi tac vu can thiet.
                    Row(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      mainAxisAlignment: MainAxisAlignment.center,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      children: [
                        // Goi ham de thuc thi tac vu can thiet.
                        Text(
                          // Thuc thi cau lenh hien tai theo luong xu ly.
                          'Already have an account?',
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          style: TextStyle(
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            color: onSurface.withValues(alpha: 0.74),
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            fontSize: 12,
                          ),
                        ),
                        // Goi ham de thuc thi tac vu can thiet.
                        TextButton(
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          onPressed: () => context.pop(),
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          style: TextButton.styleFrom(
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            foregroundColor: colorScheme.primary,
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          child: const Text(
                            // Thuc thi cau lenh hien tai theo luong xu ly.
                            'Sign in',
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
