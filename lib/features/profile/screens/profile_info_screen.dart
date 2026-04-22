import 'package:flutter/material.dart';

import '../../../shared/constants/app_constants.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/themes/app_colors.dart';
import '../../authentication/services/auth_service.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  _ProfileInfoPalette _palette(BuildContext context) {
    return _ProfileInfoPalette.fromTheme(Theme.of(context));
  }

  final AuthService _authService = getIt<AuthService>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _positionController;
  late final TextEditingController _departmentController;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final user = _authService.currentUser;
    _nameController = TextEditingController(text: user?.name ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
    _phoneController = TextEditingController(text: user?.phone ?? '');
    _positionController = TextEditingController(text: _roleLabel(user?.role));
    _departmentController = TextEditingController(text: 'Phòng Kinh Doanh');
  }

  String _roleLabel(String? role) {
    switch (role?.toLowerCase()) {
      case 'admin':
        return 'Quản trị viên';
      case 'manager':
        return 'Giám Đốc Kinh Doanh';
      default:
        return 'Nhân viên';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _positionController.dispose();
    _departmentController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (_isSaving) return;
    setState(() => _isSaving = true);

    try {
      await _authService.updateProfile({
        'name': _nameController.text.trim(),
        'phone': _phoneController.text.trim(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Đã lưu thay đổi thông tin cá nhân.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Không thể lưu. Vui lòng thử lại.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final metrics = _ProfileInfoMetrics.fromWidth(
      MediaQuery.sizeOf(context).width,
    );
    final palette = _palette(context);

    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Thông Tin Cá Nhân',
          style: AppTextStyles.titleLarge.copyWith(
            color: palette.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: metrics.fs(20),
          ),
        ),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [palette.gradientTop, palette.gradientBottom],
          ),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              metrics.px(14),
              metrics.px(10),
              metrics.px(14),
              metrics.px(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIdentityCard(metrics),
                SizedBox(height: metrics.px(16)),
                _buildSectionTitle('THÔNG TIN CƠ BẢN', metrics),
                SizedBox(height: metrics.px(8)),
                _buildFormCard(
                  metrics: metrics,
                  children: [
                    _buildInputField(
                      metrics: metrics,
                      label: 'Họ Và Tên',
                      icon: Icons.person_outline_rounded,
                      controller: _nameController,
                    ),
                    _buildInputField(
                      metrics: metrics,
                      label: 'Email',
                      icon: Icons.email_outlined,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    _buildInputField(
                      metrics: metrics,
                      label: 'Số Điện Thoại',
                      icon: Icons.phone_outlined,
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
                SizedBox(height: metrics.px(14)),
                _buildSectionTitle('THÔNG TIN CÔNG VIỆC', metrics),
                SizedBox(height: metrics.px(8)),
                _buildFormCard(
                  metrics: metrics,
                  children: [
                    _buildInputField(
                      metrics: metrics,
                      label: 'Chức Danh',
                      icon: Icons.badge_outlined,
                      controller: _positionController,
                    ),
                    _buildInputField(
                      metrics: metrics,
                      label: 'Phòng Ban',
                      icon: Icons.apartment_outlined,
                      controller: _departmentController,
                    ),
                  ],
                ),
                SizedBox(height: metrics.px(16)),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _saveProfile,
                    style: FilledButton.styleFrom(
                      backgroundColor: palette.accent,
                      foregroundColor: palette.buttonForeground,
                      padding: EdgeInsets.symmetric(vertical: metrics.px(14)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(metrics.px(14)),
                      ),
                    ),
                    icon: Icon(
                      Icons.check_circle_outline,
                      size: metrics.px(18),
                    ),
                    label: Text(
                      'Lưu Thay Đổi',
                      style: AppTextStyles.titleSmall.copyWith(
                        color: palette.buttonForeground,
                        fontWeight: FontWeight.w800,
                        fontSize: metrics.fs(16),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: metrics.px(10)),
                Center(
                  child: Text(
                    'Phiên bản ${AppConstants.appVersion} - Precision Auto',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: palette.textMuted,
                      fontSize: metrics.fs(11),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIdentityCard(_ProfileInfoMetrics metrics) {
    final palette = _palette(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        metrics.px(14),
        metrics.px(14),
        metrics.px(14),
        metrics.px(13),
      ),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(metrics.px(18)),
        border: Border.all(color: palette.cardBorder),
      ),
      child: Row(
        children: [
          Container(
            width: metrics.px(58),
            height: metrics.px(58),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFFE4C15D), Color(0xFFD6A93E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              (_authService.currentUser?.name ?? 'U').substring(0, 1).toUpperCase(),
              style: AppTextStyles.headlineSmall.copyWith(
                color: palette.buttonForeground,
                fontWeight: FontWeight.w800,
                fontSize: metrics.fs(28),
              ),
            ),
          ),
          SizedBox(width: metrics.px(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hồ Sơ Đã Xác Thực',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: palette.tealAccent,
                    fontWeight: FontWeight.w700,
                    fontSize: metrics.fs(12),
                  ),
                ),
                SizedBox(height: metrics.px(3)),
                Text(
                  'Dữ liệu tài khoản của bạn đã đồng bộ với hệ thống nhân sự.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: palette.textSecondary,
                    fontSize: metrics.fs(12),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String text, _ProfileInfoMetrics metrics) {
    final palette = _palette(context);

    return Text(
      text,
      style: AppTextStyles.labelLarge.copyWith(
        color: palette.textMuted,
        letterSpacing: metrics.px(1.05),
        fontWeight: FontWeight.w700,
        fontSize: metrics.fs(13),
      ),
    );
  }

  Widget _buildFormCard({
    required _ProfileInfoMetrics metrics,
    required List<Widget> children,
  }) {
    final palette = _palette(context);

    return Container(
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(metrics.px(17)),
        border: Border.all(color: palette.cardBorder),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildInputField({
    required _ProfileInfoMetrics metrics,
    required String label,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final palette = _palette(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        metrics.px(12),
        metrics.px(10),
        metrics.px(12),
        metrics.px(10),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: AppTextStyles.bodyMedium.copyWith(
          color: palette.textPrimary,
          fontSize: metrics.fs(14),
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: AppTextStyles.bodySmall.copyWith(
            color: palette.textSecondary,
            fontSize: metrics.fs(12),
          ),
          prefixIcon: Icon(icon, color: palette.accent, size: metrics.px(18)),
          filled: true,
          fillColor: palette.surfaceSoft,
          contentPadding: EdgeInsets.symmetric(
            horizontal: metrics.px(12),
            vertical: metrics.px(12),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(metrics.px(12)),
            borderSide: BorderSide(color: palette.cardBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(metrics.px(12)),
            borderSide: BorderSide(color: palette.cardBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(metrics.px(12)),
            borderSide: BorderSide(color: palette.accent, width: 1.1),
          ),
        ),
      ),
    );
  }
}

class _ProfileInfoPalette {
  final Color background;
  final Color gradientTop;
  final Color gradientBottom;
  final Color surface;
  final Color surfaceSoft;
  final Color accent;
  final Color tealAccent;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color cardBorder;
  final Color buttonForeground;

  const _ProfileInfoPalette({
    required this.background,
    required this.gradientTop,
    required this.gradientBottom,
    required this.surface,
    required this.surfaceSoft,
    required this.accent,
    required this.tealAccent,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.cardBorder,
    required this.buttonForeground,
  });

  factory _ProfileInfoPalette.fromTheme(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;

    return _ProfileInfoPalette(
      background: isDark ? const Color(0xFF07080A) : const Color(0xFFF4F7FB),
      gradientTop: isDark ? const Color(0xFF14161A) : const Color(0xFFFBFCFF),
      gradientBottom: isDark
          ? const Color(0xFF060709)
          : const Color(0xFFEEF2F8),
      surface: isDark ? const Color(0xFF16181D) : Colors.white,
      surfaceSoft: isDark ? const Color(0xFF1A1D22) : const Color(0xFFF2F5FA),
      accent: const Color(0xFFD8AD48),
      tealAccent: const Color(0xFF09B7A3),
      textPrimary: onSurface,
      textSecondary: onSurface.withValues(alpha: isDark ? 0.65 : 0.7),
      textMuted: onSurface.withValues(alpha: isDark ? 0.52 : 0.58),
      cardBorder: isDark
          ? Colors.white.withValues(alpha: 0.07)
          : Colors.black.withValues(alpha: 0.08),
      buttonForeground: const Color(0xFF1A1710),
    );
  }
}

class _ProfileInfoMetrics {
  final double scale;
  final double textScale;

  const _ProfileInfoMetrics._({required this.scale, required this.textScale});

  factory _ProfileInfoMetrics.fromWidth(double width) {
    final rawScale = width / 390;
    return _ProfileInfoMetrics._(
      scale: rawScale.clamp(0.88, 1.14).toDouble(),
      textScale: rawScale.clamp(0.92, 1.09).toDouble(),
    );
  }

  double px(double value) => value * scale;

  double fs(double value) => value * textScale;
}
