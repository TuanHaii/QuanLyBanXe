import 'package:flutter/material.dart';

import '../../../shared/constants/app_constants.dart';
import '../../../shared/themes/app_colors.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  static const Color _backgroundColor = Color(0xFF07080A);
  static const Color _surfaceColor = Color(0xFF16181D);
  static const Color _surfaceSoftColor = Color(0xFF1A1D22);
  static const Color _accentColor = Color(0xFFD8AD48);
  static const Color _tealAccentColor = Color(0xFF09B7A3);

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _positionController;
  late final TextEditingController _departmentController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'Alex Sterling');
    _emailController = TextEditingController(text: 'alex@precisionauto.vn');
    _phoneController = TextEditingController(text: '0901 234 567');
    _positionController = TextEditingController(text: 'Giám Đốc Kinh Doanh');
    _departmentController = TextEditingController(text: 'Phòng Kinh Doanh');
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

  void _saveProfile() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Đã lưu thay đổi thông tin cá nhân.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final metrics = _ProfileInfoMetrics.fromWidth(
      MediaQuery.sizeOf(context).width,
    );

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Thông Tin Cá Nhân',
          style: AppTextStyles.titleLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: metrics.fs(20),
          ),
        ),
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF14161A), Color(0xFF060709)],
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
                      backgroundColor: _accentColor,
                      foregroundColor: const Color(0xFF1A1710),
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
                        color: const Color(0xFF1A1710),
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
                      color: Colors.white.withValues(alpha: 0.42),
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
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        metrics.px(14),
        metrics.px(14),
        metrics.px(14),
        metrics.px(13),
      ),
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(metrics.px(18)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
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
              'A',
              style: AppTextStyles.headlineSmall.copyWith(
                color: const Color(0xFF1A1710),
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
                    color: _tealAccentColor,
                    fontWeight: FontWeight.w700,
                    fontSize: metrics.fs(12),
                  ),
                ),
                SizedBox(height: metrics.px(3)),
                Text(
                  'Dữ liệu tài khoản của bạn đã đồng bộ với hệ thống nhân sự.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.65),
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
    return Text(
      text,
      style: AppTextStyles.labelLarge.copyWith(
        color: Colors.white.withValues(alpha: 0.55),
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
    return Container(
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(metrics.px(17)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
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
          color: Colors.white,
          fontSize: metrics.fs(14),
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: AppTextStyles.bodySmall.copyWith(
            color: Colors.white.withValues(alpha: 0.58),
            fontSize: metrics.fs(12),
          ),
          prefixIcon: Icon(icon, color: _accentColor, size: metrics.px(18)),
          filled: true,
          fillColor: _surfaceSoftColor,
          contentPadding: EdgeInsets.symmetric(
            horizontal: metrics.px(12),
            vertical: metrics.px(12),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(metrics.px(12)),
            borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(metrics.px(12)),
            borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(metrics.px(12)),
            borderSide: const BorderSide(color: _accentColor, width: 1.1),
          ),
        ),
      ),
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
