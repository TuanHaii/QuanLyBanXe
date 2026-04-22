import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/constants/app_constants.dart';
import '../../../shared/services/service_locator.dart';
import '../services/auth_service.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/primary_auth_button.dart';
import '../widgets/secondary_auth_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController(text: 'example@example.com');
  final _passwordController = TextEditingController(text: '110505Hai@');

  late AnimationController _animationController;
  Animation<double> _headerMoveAnimation = const AlwaysStoppedAnimation<double>(
    1,
  );
  Animation<double> _headerOpacityAnimation =
      const AlwaysStoppedAnimation<double>(1);
  Animation<Offset> _formSlideAnimation = const AlwaysStoppedAnimation<Offset>(
    Offset.zero,
  );
  Animation<double> _formOpacityAnimation =
      const AlwaysStoppedAnimation<double>(0);

  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _headerMoveAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic),
    );

    _headerOpacityAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.2, curve: Curves.easeOut),
    );

    _formSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.58, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    _formOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.62, 1.0, curve: Curves.easeOut),
      ),
    );

    _animationController.forward();
  }

  Future<void> _handleLogin() async {
    if (_isLoading) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final authService = getIt<AuthService>();
      await authService.login(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (!mounted) {
        return;
      }

      context.go(RouteNames.dashboard);
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(error.toString().replaceFirst('Exception: ', '')),
            behavior: SnackBarBehavior.floating,
          ),
        );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _openRegisterScreen() {
    context.push(RouteNames.register);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, _) {
                  const headerFinalTop = 35.0;
                  const headerEstimatedHeight = 170.0;
                  final headerStartTop =
                      (constraints.maxHeight - headerEstimatedHeight) / 2;
                  final headerTop = lerpDouble(
                    headerStartTop,
                    headerFinalTop,
                    _headerMoveAnimation.value,
                  )!;

                  return Stack(
                    children: [
                      Positioned(
                        top: headerTop,
                        left: 0,
                        right: 0,
                        child: FadeTransition(
                          opacity: _headerOpacityAnimation,
                          child: const AuthHeader(),
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 260),
                            child: FadeTransition(
                              opacity: _formOpacityAnimation,
                              child: SlideTransition(
                                position: _formSlideAnimation,
                                child: SingleChildScrollView(
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

  Widget _buildLoginCard() {
    final colorScheme = Theme.of(context).colorScheme;
    final onSurface = colorScheme.onSurface;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: onSurface.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please sign in to continue',
            style: TextStyle(
              fontSize: 14,
              color: onSurface.withValues(alpha: 0.68),
            ),
          ),
          const SizedBox(height: 32),
          AuthTextField(
            label: 'Email',
            prefixIcon: Icons.email_outlined,
            controller: _emailController,
          ),
          const SizedBox(height: 20),
          AuthTextField(
            label: 'SECURITY KEY',
            prefixIcon: Icons.lock_outline,
            controller: _passwordController,
            isPassword: true,
            obscureText: _obscurePassword,
            onToggleVisibility: () {
              setState(() => _obscurePassword = !_obscurePassword);
            },
            trailingAction: TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Forgot password?')),
                );
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Forgot?',
                style: TextStyle(
                  fontSize: 12,
                  color: onSurface.withValues(alpha: 0.7),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          PrimaryAuthButton(
            text: 'SIGN IN',
            onTap: _handleLogin,
            isLoading: _isLoading,
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: Divider(color: onSurface.withValues(alpha: 0.12)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'SECURE ACCESS ONLY',
                  style: TextStyle(
                    fontSize: 10,
                    color: onSurface.withValues(alpha: 0.68),
                  ),
                ),
              ),
              Expanded(
                child: Divider(color: onSurface.withValues(alpha: 0.12)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: SecondaryAuthButton(
                  icon: Icons.g_mobiledata_outlined,
                  label: 'GOOGLE',
                  onTap: () {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('GG login')));
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SecondaryAuthButton(
                  icon: Icons.facebook_outlined,
                  label: 'FACEBOOK',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Facebook login')),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account yet?",
                style: TextStyle(
                  color: onSurface.withValues(alpha: 0.74),
                  fontSize: 12,
                ),
              ),
              TextButton(
                onPressed: _openRegisterScreen,
                style: TextButton.styleFrom(
                  foregroundColor: colorScheme.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
                child: const Text(
                  'Sign up',
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
