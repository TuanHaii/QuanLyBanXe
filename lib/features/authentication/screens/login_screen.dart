import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/constants/app_constants.dart';
import '../../../shared/themes/app_colors.dart';
import '../../../shared/services/service_locator.dart';
import '../services/auth_service.dart';
import '../widgets/precision_text_field.dart';
import '../widgets/precision_primary_button.dart';
import '../widgets/precision_secondary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: AuthService.mockEmail);// su dung mock data
  final _passwordController = TextEditingController(
    text: AuthService.mockPassword,
  );
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authService = getIt<AuthService>();
      await authService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (mounted) {
        context.go(RouteNames.dashboard);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Authentication Failed: ${e.toString()}'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _handleForgotPassword() {
    // TODO: Navigate to forgot password screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password recovery feature coming soon'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _handleSSO() {
    // TODO: Implement SSO Gateway integration
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('SSO Gateway integration in progress'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _handleBiometric() {
    // TODO: Implement Biometric authentication
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Biometric authentication in progress'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E27),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header Section
                _buildHeaderSection(),
                const SizedBox(height: 48),
                // Login Card
                _buildLoginCard(),
                const SizedBox(height: 32),
                // Secure Access Divider
                _buildSecureAccessDivider(),
                const SizedBox(height: 20),
                // SSO & Biometric Buttons
                _buildAuthenticationOptions(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      children: [
        // Robotic Arm Icon
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1E90FF).withValues(alpha: 0.2),
                const Color(0xFF00D4FF).withValues(alpha: 0.1),
              ],
            ),
            border: Border.all(
              color: const Color(0xFF00D4FF).withValues(alpha: 0.3),
              width: 1.5,
            ),
          ),
          child: const Icon(
            Icons.precision_manufacturing,
            size: 48,
            color: Color(0xFF00D4FF),
          ),
        ),
        const SizedBox(height: 24),
        // Logo Text
        Text(
          'PRECISION',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                letterSpacing: 3,
              ),
        ),
        const SizedBox(height: 8),
        // Subtitle
        Text(
          'AUTOMOTIVE INTELLIGENCE',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: const Color(0xFF00D4FF),
                letterSpacing: 2,
                fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F3A).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF00D4FF).withValues(alpha: 0.15),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00D4FF).withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Welcome Back',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            // Subtitle
            Text(
              'Enter your credentials to access the cockpit.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFFB0B0B0),
                    height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            // Email Field
            PrecisionTextField(
              controller: _emailController,
              label: 'OPERATIONAL EMAIL',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Invalid email format';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            // Password Field with Forgot Button
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SECURITY KEY',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: const Color(0xFF00D4FF),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                      ),
                    ),
                    TextButton(
                      onPressed: _handleForgotPassword,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'FORGOT?',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: const Color(0xFF00D4FF),
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                PrecisionTextField(
                  controller: _passwordController,
                  label: '',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xFF00D4FF),
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
              ],
            ),
            const SizedBox(height: 28),
            // Primary Button
            PrecisionPrimaryButton(
              label: 'INITIATE SESSION',
              isLoading: _isLoading,
              onPressed: _handleLogin,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecureAccessDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF00D4FF).withValues(alpha: 0.0),
                  const Color(0xFF00D4FF).withValues(alpha: 0.3),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'SECURE ACCESS ONLY',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: const Color(0xFF00D4FF).withValues(alpha: 0.6),
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF00D4FF).withValues(alpha: 0.3),
                  const Color(0xFF00D4FF).withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAuthenticationOptions() {
    return Row(
      children: [
        Expanded(
          child: PrecisionSecondaryButton(
            label: 'SSO GATEWAY',
            icon: Icons.cloud_outlined,
            onPressed: _handleSSO,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: PrecisionSecondaryButton(
            label: 'BIOMETRIC',
            icon: Icons.fingerprint,
            onPressed: _handleBiometric,
          ),
        ),
      ],
    );
  }
}