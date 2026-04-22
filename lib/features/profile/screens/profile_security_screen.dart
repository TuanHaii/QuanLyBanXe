import 'package:flutter/material.dart';

import '../../../shared/constants/app_constants.dart';
import '../../../shared/themes/app_colors.dart';

class ProfileSecurityScreen extends StatefulWidget {
  const ProfileSecurityScreen({super.key});

  @override
  State<ProfileSecurityScreen> createState() => _ProfileSecurityScreenState();
}

class _ProfileSecurityScreenState extends State<ProfileSecurityScreen> {
  _ProfileSecurityPalette _palette(BuildContext context) {
    return _ProfileSecurityPalette.fromTheme(Theme.of(context));
  }

  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _twoFactorEnabled = true;
  bool _loginAlertEnabled = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _saveSecurityChanges() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Cài đặt bảo mật đã được cập nhật.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final metrics = _ProfileSecurityMetrics.fromWidth(
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
          'Bảo Mật',
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
                _buildSectionTitle('ĐĂNG NHẬP AN TOÀN', metrics),
                SizedBox(height: metrics.px(8)),
                _buildSwitchCard(metrics),
                SizedBox(height: metrics.px(14)),
                _buildSectionTitle('ĐỔI MẬT KHẨU', metrics),
                SizedBox(height: metrics.px(8)),
                _buildPasswordCard(metrics),
                SizedBox(height: metrics.px(14)),
                _buildSectionTitle('PHIÊN GẦN ĐÂY', metrics),
                SizedBox(height: metrics.px(8)),
                _buildSessionCard(metrics),
                SizedBox(height: metrics.px(16)),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _saveSecurityChanges,
                    style: FilledButton.styleFrom(
                      backgroundColor: palette.accent,
                      foregroundColor: palette.buttonForeground,
                      padding: EdgeInsets.symmetric(vertical: metrics.px(14)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(metrics.px(14)),
                      ),
                    ),
                    icon: Icon(
                      Icons.verified_user_outlined,
                      size: metrics.px(18),
                    ),
                    label: Text(
                      'Cập Nhật Bảo Mật',
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

  Widget _buildSectionTitle(String text, _ProfileSecurityMetrics metrics) {
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

  Widget _buildSwitchCard(_ProfileSecurityMetrics metrics) {
    final palette = _palette(context);

    return Container(
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(metrics.px(17)),
        border: Border.all(color: palette.cardBorder),
      ),
      child: Column(
        children: [
          _buildSwitchTile(
            metrics: metrics,
            icon: Icons.phonelink_lock_rounded,
            title: 'Xác Thực Hai Lớp',
            subtitle: 'Yêu cầu mã OTP khi đăng nhập trên thiết bị mới.',
            value: _twoFactorEnabled,
            onChanged: (value) => setState(() => _twoFactorEnabled = value),
          ),
          Divider(
            color: palette.divider,
            height: 1,
            indent: metrics.px(13),
            endIndent: metrics.px(13),
          ),
          _buildSwitchTile(
            metrics: metrics,
            icon: Icons.notifications_active_outlined,
            title: 'Cảnh Báo Đăng Nhập',
            subtitle: 'Nhận cảnh báo khi có đăng nhập bất thường.',
            value: _loginAlertEnabled,
            onChanged: (value) => setState(() => _loginAlertEnabled = value),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required _ProfileSecurityMetrics metrics,
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final palette = _palette(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        metrics.px(12),
        metrics.px(12),
        metrics.px(12),
        metrics.px(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: metrics.px(30),
            height: metrics.px(30),
            decoration: BoxDecoration(
              color: palette.iconContainer,
              borderRadius: BorderRadius.circular(metrics.px(9)),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: palette.accent, size: metrics.px(16)),
          ),
          SizedBox(width: metrics.px(9)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: palette.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: metrics.fs(15),
                  ),
                ),
                SizedBox(height: metrics.px(3)),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: palette.textSecondary,
                    fontSize: metrics.fs(12),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: metrics.px(10)),
          _DualToneSwitch(
            value: value,
            onChanged: onChanged,
            accentColor: palette.accent,
            tealAccentColor: palette.tealAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordCard(_ProfileSecurityMetrics metrics) {
    final palette = _palette(context);

    return Container(
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(metrics.px(17)),
        border: Border.all(color: palette.cardBorder),
      ),
      child: Column(
        children: [
          _buildPasswordField(
            metrics: metrics,
            controller: _currentPasswordController,
            label: 'Mật Khẩu Hiện Tại',
            icon: Icons.lock_outline,
            obscureText: _obscureCurrentPassword,
            onToggle: () {
              setState(
                () => _obscureCurrentPassword = !_obscureCurrentPassword,
              );
            },
          ),
          _buildPasswordField(
            metrics: metrics,
            controller: _newPasswordController,
            label: 'Mật Khẩu Mới',
            icon: Icons.lock_reset_outlined,
            obscureText: _obscureNewPassword,
            onToggle: () {
              setState(() => _obscureNewPassword = !_obscureNewPassword);
            },
          ),
          _buildPasswordField(
            metrics: metrics,
            controller: _confirmPasswordController,
            label: 'Xác Nhận Mật Khẩu',
            icon: Icons.lock_person_outlined,
            obscureText: _obscureConfirmPassword,
            onToggle: () {
              setState(
                () => _obscureConfirmPassword = !_obscureConfirmPassword,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required _ProfileSecurityMetrics metrics,
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool obscureText,
    required VoidCallback onToggle,
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
        obscureText: obscureText,
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
          suffixIcon: IconButton(
            onPressed: onToggle,
            icon: Icon(
              obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: palette.textSecondary,
              size: metrics.px(18),
            ),
          ),
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

  Widget _buildSessionCard(_ProfileSecurityMetrics metrics) {
    final palette = _palette(context);

    const sessions = [
      _SessionItem(
        device: 'iPhone 15 Pro - iOS 18',
        location: 'Hà Nội, Việt Nam',
        lastSeen: 'Đang hoạt động',
        isCurrent: true,
      ),
      _SessionItem(
        device: 'MacBook Pro - Chrome',
        location: 'Hà Nội, Việt Nam',
        lastSeen: 'Hôm nay, 08:45',
        isCurrent: false,
      ),
      _SessionItem(
        device: 'Windows PC - Edge',
        location: 'TP. Hồ Chí Minh, Việt Nam',
        lastSeen: '20/04, 22:31',
        isCurrent: false,
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(metrics.px(17)),
        border: Border.all(color: palette.cardBorder),
      ),
      child: Column(
        children: List.generate(sessions.length, (index) {
          final session = sessions[index];
          return Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: metrics.px(12),
                  vertical: metrics.px(2),
                ),
                leading: Container(
                  width: metrics.px(32),
                  height: metrics.px(32),
                  decoration: BoxDecoration(
                    color: palette.iconContainer,
                    borderRadius: BorderRadius.circular(metrics.px(10)),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.devices_outlined,
                    color: palette.accent,
                    size: metrics.px(17),
                  ),
                ),
                title: Text(
                  session.device,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: palette.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: metrics.fs(14),
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: metrics.px(3)),
                  child: Text(
                    '${session.location} • ${session.lastSeen}',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: palette.textSecondary,
                      fontSize: metrics.fs(12),
                    ),
                  ),
                ),
                trailing: session.isCurrent
                    ? Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: metrics.px(8),
                          vertical: metrics.px(4),
                        ),
                        decoration: BoxDecoration(
                          color: palette.tealAccent.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          'Hiện tại',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: palette.tealAccent,
                            fontWeight: FontWeight.w700,
                            fontSize: metrics.fs(10),
                          ),
                        ),
                      )
                    : null,
              ),
              if (index != sessions.length - 1)
                Divider(
                  color: palette.divider,
                  height: 1,
                  indent: metrics.px(13),
                  endIndent: metrics.px(13),
                ),
            ],
          );
        }),
      ),
    );
  }
}

class _ProfileSecurityPalette {
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
  final Color divider;
  final Color iconContainer;
  final Color buttonForeground;

  const _ProfileSecurityPalette({
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
    required this.divider,
    required this.iconContainer,
    required this.buttonForeground,
  });

  factory _ProfileSecurityPalette.fromTheme(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;

    return _ProfileSecurityPalette(
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
      divider: isDark
          ? Colors.white.withValues(alpha: 0.05)
          : Colors.black.withValues(alpha: 0.06),
      iconContainer: isDark
          ? Colors.white.withValues(alpha: 0.03)
          : Colors.black.withValues(alpha: 0.03),
      buttonForeground: const Color(0xFF1A1710),
    );
  }
}

class _DualToneSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color accentColor;
  final Color tealAccentColor;

  const _DualToneSwitch({
    required this.value,
    required this.onChanged,
    required this.accentColor,
    required this.tealAccentColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: AppConstants.shortDuration,
        width: 44,
        height: 24,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: value
                ? [accentColor, tealAccentColor]
                : isDark
                    ? [const Color(0xFF42464E), const Color(0xFF2E3138)]
                    : [const Color(0xFFD8DEE7), const Color(0xFFC6D0DD)],
          ),
        ),
        child: AnimatedAlign(
          duration: AppConstants.shortDuration,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value
                  ? (isDark ? const Color(0xFFF5F7FA) : Colors.white)
                  : (isDark
                        ? const Color(0xFF9CA3AF)
                        : const Color(0xFF7B8794)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.12),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SessionItem {
  final String device;
  final String location;
  final String lastSeen;
  final bool isCurrent;

  const _SessionItem({
    required this.device,
    required this.location,
    required this.lastSeen,
    required this.isCurrent,
  });
}

class _ProfileSecurityMetrics {
  final double scale;
  final double textScale;

  const _ProfileSecurityMetrics._({
    required this.scale,
    required this.textScale,
  });

  factory _ProfileSecurityMetrics.fromWidth(double width) {
    final rawScale = width / 390;
    return _ProfileSecurityMetrics._(
      scale: rawScale.clamp(0.88, 1.14).toDouble(),
      textScale: rawScale.clamp(0.92, 1.09).toDouble(),
    );
  }

  double px(double value) => value * scale;

  double fs(double value) => value * textScale;
}
