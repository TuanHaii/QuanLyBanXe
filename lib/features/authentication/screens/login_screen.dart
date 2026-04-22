// Nap thu vien hoac module can thiet.
import 'dart:ui';
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
// Nap thu vien hoac module can thiet.
import '../widgets/secondary_auth_button.dart';

// Dinh nghia lop LoginScreen de gom nhom logic lien quan.
class LoginScreen extends StatefulWidget {
  // Khai bao bien LoginScreen de luu du lieu su dung trong xu ly.
  const LoginScreen({super.key});

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Thuc thi cau lenh hien tai theo luong xu ly.
  State<LoginScreen> createState() => _LoginScreenState();
}

// Dinh nghia lop _LoginScreenState de gom nhom logic lien quan.
class _LoginScreenState extends State<LoginScreen>
    // Thuc thi cau lenh hien tai theo luong xu ly.
    with SingleTickerProviderStateMixin {
  // Khai bao bien _emailController de luu du lieu su dung trong xu ly.
  final _emailController = TextEditingController(text: 'example@example.com');
  // Khai bao bien _passwordController de luu du lieu su dung trong xu ly.
  final _passwordController = TextEditingController(text: '110505Hai@');

  // Khai bao bien AnimationController de luu du lieu su dung trong xu ly.
  late AnimationController _animationController;
  // Thuc thi cau lenh hien tai theo luong xu ly.
  Animation<double> _headerMoveAnimation = const AlwaysStoppedAnimation<double>(
    // Thuc thi cau lenh hien tai theo luong xu ly.
    1,
  );
  // Thuc thi cau lenh hien tai theo luong xu ly.
  Animation<double> _headerOpacityAnimation =
      // Khai bao bien AlwaysStoppedAnimation de luu du lieu su dung trong xu ly.
      const AlwaysStoppedAnimation<double>(1);
  // Thuc thi cau lenh hien tai theo luong xu ly.
  Animation<Offset> _formSlideAnimation = const AlwaysStoppedAnimation<Offset>(
    // Thuc thi cau lenh hien tai theo luong xu ly.
    Offset.zero,
  );
  // Thuc thi cau lenh hien tai theo luong xu ly.
  Animation<double> _formOpacityAnimation =
      // Khai bao bien AlwaysStoppedAnimation de luu du lieu su dung trong xu ly.
      const AlwaysStoppedAnimation<double>(0);

  // Khai bao bien _isLoading de luu du lieu su dung trong xu ly.
  bool _isLoading = false;
  // Khai bao bien _obscurePassword de luu du lieu su dung trong xu ly.
  bool _obscurePassword = true;

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Dinh nghia ham initState de xu ly nghiep vu tuong ung.
  void initState() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.initState();

    // Gan gia tri cho bien _animationController.
    _animationController = AnimationController(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      vsync: this,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      duration: const Duration(milliseconds: 1800),
    );

    // Gan gia tri cho bien _headerMoveAnimation.
    _headerMoveAnimation = CurvedAnimation(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      parent: _animationController,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic),
    );

    // Gan gia tri cho bien _headerOpacityAnimation.
    _headerOpacityAnimation = CurvedAnimation(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      parent: _animationController,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      curve: const Interval(0.0, 0.2, curve: Curves.easeOut),
    );

    // Gan gia tri cho bien _formSlideAnimation.
    _formSlideAnimation =
        // Thuc thi cau lenh hien tai theo luong xu ly.
        Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero).animate(
          // Goi ham de thuc thi tac vu can thiet.
          CurvedAnimation(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            parent: _animationController,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            curve: const Interval(0.58, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    // Gan gia tri cho bien _formOpacityAnimation.
    _formOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      // Goi ham de thuc thi tac vu can thiet.
      CurvedAnimation(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        parent: _animationController,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        curve: const Interval(0.62, 1.0, curve: Curves.easeOut),
      ),
    );

    // Thuc thi cau lenh hien tai theo luong xu ly.
    _animationController.forward();
  }

  // Khai bao bien _handleLogin de luu du lieu su dung trong xu ly.
  Future<void> _handleLogin() async {
    // Kiem tra dieu kien de re nhanh xu ly.
    if (_isLoading) {
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
      await authService.login(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        email: _emailController.text,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        password: _passwordController.text,
      );

      // Kiem tra dieu kien de re nhanh xu ly.
      if (!mounted) {
        // Tra ve ket qua cho noi goi ham.
        return;
      }

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

  // Dinh nghia ham _openRegisterScreen de xu ly nghiep vu tuong ung.
  void _openRegisterScreen() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    context.push(RouteNames.register);
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Dinh nghia ham dispose de xu ly nghiep vu tuong ung.
  void dispose() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _animationController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _emailController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _passwordController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.dispose();
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien theme de luu du lieu su dung trong xu ly.
    final theme = Theme.of(context);

    // Tra ve ket qua cho noi goi ham.
    return Scaffold(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      backgroundColor: theme.scaffoldBackgroundColor,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      body: SafeArea(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: LayoutBuilder(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          builder: (context, constraints) {
            // Tra ve ket qua cho noi goi ham.
            return Padding(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              padding: const EdgeInsets.symmetric(horizontal: 24),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              child: AnimatedBuilder(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                animation: _animationController,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                builder: (context, _) {
                  // Khai bao bien headerFinalTop de luu du lieu su dung trong xu ly.
                  const headerFinalTop = 35.0;
                  // Khai bao bien headerEstimatedHeight de luu du lieu su dung trong xu ly.
                  const headerEstimatedHeight = 170.0;
                  // Khai bao bien headerStartTop de luu du lieu su dung trong xu ly.
                  final headerStartTop =
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      (constraints.maxHeight - headerEstimatedHeight) / 2;
                  // Khai bao bien headerTop de luu du lieu su dung trong xu ly.
                  final headerTop = lerpDouble(
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    headerStartTop,
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    headerFinalTop,
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    _headerMoveAnimation.value,
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  )!;

                  // Tra ve ket qua cho noi goi ham.
                  return Stack(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    children: [
                      // Goi ham de thuc thi tac vu can thiet.
                      Positioned(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        top: headerTop,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        left: 0,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        right: 0,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        child: FadeTransition(
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          opacity: _headerOpacityAnimation,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          child: const AuthHeader(),
                        ),
                      ),
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      Positioned.fill(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        child: Align(
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          alignment: Alignment.topCenter,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          child: Padding(
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            padding: const EdgeInsets.only(top: 260),
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            child: FadeTransition(
                              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                              opacity: _formOpacityAnimation,
                              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                              child: SlideTransition(
                                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                                position: _formSlideAnimation,
                                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                                child: SingleChildScrollView(
                                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                                  child: _buildLoginCard(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  // Khai bao bien _buildLoginCard de luu du lieu su dung trong xu ly.
  Widget _buildLoginCard() {
    // Khai bao bien colorScheme de luu du lieu su dung trong xu ly.
    final colorScheme = Theme.of(context).colorScheme;
    // Khai bao bien onSurface de luu du lieu su dung trong xu ly.
    final onSurface = colorScheme.onSurface;

    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: const EdgeInsets.all(24),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: colorScheme.surface,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(16),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: Border.all(color: onSurface.withValues(alpha: 0.08)),
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
            'Welcome Back',
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
            'Please sign in to continue',
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            style: TextStyle(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              fontSize: 14,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: onSurface.withValues(alpha: 0.68),
            ),
          ),
          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
          const SizedBox(height: 32),
          // Goi ham de thuc thi tac vu can thiet.
          AuthTextField(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            label: 'Email',
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            prefixIcon: Icons.email_outlined,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            controller: _emailController,
          ),
          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
          const SizedBox(height: 20),
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
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            trailingAction: TextButton(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              onPressed: () {
                // Thuc thi cau lenh hien tai theo luong xu ly.
                ScaffoldMessenger.of(context).showSnackBar(
                  // Khai bao bien SnackBar de luu du lieu su dung trong xu ly.
                  const SnackBar(content: Text('Forgot password?')),
                );
              },
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              style: TextButton.styleFrom(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                padding: EdgeInsets.zero,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                minimumSize: const Size(0, 0),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              child: Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                'Forgot?',
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: TextStyle(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontSize: 12,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: onSurface.withValues(alpha: 0.7),
                ),
              ),
            ),
          ),
          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
          const SizedBox(height: 32),
          // Goi ham de thuc thi tac vu can thiet.
          PrimaryAuthButton(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            text: 'SIGN IN',
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onTap: _handleLogin,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            isLoading: _isLoading,
          ),
          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
          const SizedBox(height: 32),
          // Goi ham de thuc thi tac vu can thiet.
          Row(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Goi ham de thuc thi tac vu can thiet.
              Expanded(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: Divider(color: onSurface.withValues(alpha: 0.12)),
              ),
              // Goi ham de thuc thi tac vu can thiet.
              Padding(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                padding: const EdgeInsets.symmetric(horizontal: 12),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: Text(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  'SECURE ACCESS ONLY',
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: TextStyle(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontSize: 10,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: onSurface.withValues(alpha: 0.68),
                  ),
                ),
              ),
              // Goi ham de thuc thi tac vu can thiet.
              Expanded(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: Divider(color: onSurface.withValues(alpha: 0.12)),
              ),
            ],
          ),
          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
          const SizedBox(height: 24),
          // Goi ham de thuc thi tac vu can thiet.
          Row(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Goi ham de thuc thi tac vu can thiet.
              Expanded(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: SecondaryAuthButton(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  icon: Icons.g_mobiledata_outlined,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  label: 'GOOGLE',
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  onTap: () {
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    ScaffoldMessenger.of(
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      context,
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    ).showSnackBar(const SnackBar(content: Text('GG login')));
                  },
                ),
              ),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(width: 16),
              // Goi ham de thuc thi tac vu can thiet.
              Expanded(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: SecondaryAuthButton(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  icon: Icons.facebook_outlined,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  label: 'FACEBOOK',
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  onTap: () {
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    ScaffoldMessenger.of(context).showSnackBar(
                      // Khai bao bien SnackBar de luu du lieu su dung trong xu ly.
                      const SnackBar(content: Text('Facebook login')),
                    );
                  },
                ),
              ),
            ],
          ),
          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
          const SizedBox(height: 20),
          // Goi ham de thuc thi tac vu can thiet.
          Row(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            mainAxisAlignment: MainAxisAlignment.center,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Goi ham de thuc thi tac vu can thiet.
              Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                "Don't have an account yet?",
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
                onPressed: _openRegisterScreen,
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
                  'Sign up',
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
