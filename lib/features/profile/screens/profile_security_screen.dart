// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';

// Nap thu vien hoac module can thiet.
import '../../../shared/constants/app_constants.dart';
// Nap thu vien hoac module can thiet.
import '../../../shared/themes/app_colors.dart';

// Dinh nghia lop ProfileSecurityScreen de gom nhom logic lien quan.
class ProfileSecurityScreen extends StatefulWidget {
  // Khai bao bien ProfileSecurityScreen de luu du lieu su dung trong xu ly.
  const ProfileSecurityScreen({super.key});

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Thuc thi cau lenh hien tai theo luong xu ly.
  State<ProfileSecurityScreen> createState() => _ProfileSecurityScreenState();
}

// Dinh nghia lop _ProfileSecurityScreenState de gom nhom logic lien quan.
class _ProfileSecurityScreenState extends State<ProfileSecurityScreen> {
  // Dinh nghia ham _palette de xu ly nghiep vu tuong ung.
  _ProfileSecurityPalette _palette(BuildContext context) {
    // Tra ve ket qua cho noi goi ham.
    return _ProfileSecurityPalette.fromTheme(Theme.of(context));
  }

  // Khai bao bien TextEditingController de luu du lieu su dung trong xu ly.
  final TextEditingController _currentPasswordController =
      // Khai bao constructor TextEditingController de khoi tao doi tuong.
      TextEditingController();
  // Khai bao bien TextEditingController de luu du lieu su dung trong xu ly.
  final TextEditingController _newPasswordController = TextEditingController();
  // Khai bao bien TextEditingController de luu du lieu su dung trong xu ly.
  final TextEditingController _confirmPasswordController =
      // Khai bao constructor TextEditingController de khoi tao doi tuong.
      TextEditingController();

  // Khai bao bien _obscureCurrentPassword de luu du lieu su dung trong xu ly.
  bool _obscureCurrentPassword = true;
  // Khai bao bien _obscureNewPassword de luu du lieu su dung trong xu ly.
  bool _obscureNewPassword = true;
  // Khai bao bien _obscureConfirmPassword de luu du lieu su dung trong xu ly.
  bool _obscureConfirmPassword = true;
  // Khai bao bien _twoFactorEnabled de luu du lieu su dung trong xu ly.
  bool _twoFactorEnabled = true;
  // Khai bao bien _loginAlertEnabled de luu du lieu su dung trong xu ly.
  bool _loginAlertEnabled = true;

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Dinh nghia ham dispose de xu ly nghiep vu tuong ung.
  void dispose() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _currentPasswordController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _newPasswordController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _confirmPasswordController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.dispose();
  }

  // Dinh nghia ham _saveSecurityChanges de xu ly nghiep vu tuong ung.
  void _saveSecurityChanges() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    ScaffoldMessenger.of(context)
      // Thuc thi cau lenh hien tai theo luong xu ly.
      ..hideCurrentSnackBar()
      // Thuc thi cau lenh hien tai theo luong xu ly.
      ..showSnackBar(
        // Khai bao bien SnackBar de luu du lieu su dung trong xu ly.
        const SnackBar(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          content: Text('Cài đặt bảo mật đã được cập nhật.'),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien metrics de luu du lieu su dung trong xu ly.
    final metrics = _ProfileSecurityMetrics.fromWidth(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      MediaQuery.sizeOf(context).width,
    );
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return Scaffold(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      backgroundColor: palette.background,
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
          'Bảo Mật',
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          style: AppTextStyles.titleLarge.copyWith(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: palette.textPrimary,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            fontWeight: FontWeight.w700,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            fontSize: metrics.fs(20),
          ),
        ),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      body: DecoratedBox(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        decoration: BoxDecoration(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          gradient: LinearGradient(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            begin: Alignment.topCenter,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            end: Alignment.bottomCenter,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            colors: [palette.gradientTop, palette.gradientBottom],
          ),
        ),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: SafeArea(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          top: false,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: SingleChildScrollView(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            physics: const BouncingScrollPhysics(),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            padding: EdgeInsets.fromLTRB(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              metrics.px(14),
              // Thuc thi cau lenh hien tai theo luong xu ly.
              metrics.px(10),
              // Thuc thi cau lenh hien tai theo luong xu ly.
              metrics.px(14),
              // Thuc thi cau lenh hien tai theo luong xu ly.
              metrics.px(20),
            ),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Column(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              crossAxisAlignment: CrossAxisAlignment.start,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              children: [
                // Goi ham de thuc thi tac vu can thiet.
                _buildSectionTitle('ĐĂNG NHẬP AN TOÀN', metrics),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(8)),
                // Goi ham de thuc thi tac vu can thiet.
                _buildSwitchCard(metrics),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(14)),
                // Goi ham de thuc thi tac vu can thiet.
                _buildSectionTitle('ĐỔI MẬT KHẨU', metrics),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(8)),
                // Goi ham de thuc thi tac vu can thiet.
                _buildPasswordCard(metrics),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(14)),
                // Goi ham de thuc thi tac vu can thiet.
                _buildSectionTitle('PHIÊN GẦN ĐÂY', metrics),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(8)),
                // Goi ham de thuc thi tac vu can thiet.
                _buildSessionCard(metrics),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(16)),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  width: double.infinity,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  child: FilledButton.icon(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    onPressed: _saveSecurityChanges,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    style: FilledButton.styleFrom(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      backgroundColor: palette.accent,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      foregroundColor: palette.buttonForeground,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      padding: EdgeInsets.symmetric(vertical: metrics.px(14)),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      shape: RoundedRectangleBorder(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        borderRadius: BorderRadius.circular(metrics.px(14)),
                      ),
                    ),
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    icon: Icon(
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      Icons.verified_user_outlined,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      size: metrics.px(18),
                    ),
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    label: Text(
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      'Cập Nhật Bảo Mật',
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      style: AppTextStyles.titleSmall.copyWith(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        color: palette.buttonForeground,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        fontWeight: FontWeight.w800,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        fontSize: metrics.fs(16),
                      ),
                    ),
                  ),
                ),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(10)),
                // Goi ham de thuc thi tac vu can thiet.
                Center(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  child: Text(
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    'Phiên bản ${AppConstants.appVersion} - Precision Auto',
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    style: AppTextStyles.labelMedium.copyWith(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      color: palette.textMuted,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
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

  // Khai bao bien _buildSectionTitle de luu du lieu su dung trong xu ly.
  Widget _buildSectionTitle(String text, _ProfileSecurityMetrics metrics) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return Text(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      text,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      style: AppTextStyles.labelLarge.copyWith(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.textMuted,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        letterSpacing: metrics.px(1.05),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        fontWeight: FontWeight.w700,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        fontSize: metrics.fs(13),
      ),
    );
  }

  // Khai bao bien _buildSwitchCard de luu du lieu su dung trong xu ly.
  Widget _buildSwitchCard(_ProfileSecurityMetrics metrics) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.surface,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(metrics.px(17)),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: Border.all(color: palette.cardBorder),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Column(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: [
          // Goi ham de thuc thi tac vu can thiet.
          _buildSwitchTile(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            metrics: metrics,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            icon: Icons.phonelink_lock_rounded,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            title: 'Xác Thực Hai Lớp',
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            subtitle: 'Yêu cầu mã OTP khi đăng nhập trên thiết bị mới.',
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            value: _twoFactorEnabled,
            // Cap nhat state de giao dien duoc render lai.
            onChanged: (value) => setState(() => _twoFactorEnabled = value),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          Divider(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: palette.divider,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            height: 1,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            indent: metrics.px(13),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            endIndent: metrics.px(13),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          _buildSwitchTile(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            metrics: metrics,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            icon: Icons.notifications_active_outlined,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            title: 'Cảnh Báo Đăng Nhập',
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            subtitle: 'Nhận cảnh báo khi có đăng nhập bất thường.',
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            value: _loginAlertEnabled,
            // Cap nhat state de giao dien duoc render lai.
            onChanged: (value) => setState(() => _loginAlertEnabled = value),
          ),
        ],
      ),
    );
  }

  // Khai bao bien _buildSwitchTile de luu du lieu su dung trong xu ly.
  Widget _buildSwitchTile({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required _ProfileSecurityMetrics metrics,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required IconData icon,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required String title,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required String subtitle,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required bool value,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required ValueChanged<bool> onChanged,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return Padding(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: EdgeInsets.fromLTRB(
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(12),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(12),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(12),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(12),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Row(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        crossAxisAlignment: CrossAxisAlignment.start,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: [
          // Goi ham de thuc thi tac vu can thiet.
          Container(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            width: metrics.px(30),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            height: metrics.px(30),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            decoration: BoxDecoration(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: palette.iconContainer,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              borderRadius: BorderRadius.circular(metrics.px(9)),
            ),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            alignment: Alignment.center,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Icon(icon, color: palette.accent, size: metrics.px(16)),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          SizedBox(width: metrics.px(9)),
          // Goi ham de thuc thi tac vu can thiet.
          Expanded(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Column(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              crossAxisAlignment: CrossAxisAlignment.start,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              children: [
                // Goi ham de thuc thi tac vu can thiet.
                Text(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  title,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: AppTextStyles.titleSmall.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: palette.textPrimary,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontWeight: FontWeight.w700,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontSize: metrics.fs(15),
                  ),
                ),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(3)),
                // Goi ham de thuc thi tac vu can thiet.
                Text(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  subtitle,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: AppTextStyles.bodySmall.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: palette.textSecondary,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontSize: metrics.fs(12),
                  ),
                ),
              ],
            ),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          SizedBox(width: metrics.px(10)),
          // Goi ham de thuc thi tac vu can thiet.
          _DualToneSwitch(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            value: value,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onChanged: onChanged,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            accentColor: palette.accent,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            tealAccentColor: palette.tealAccent,
          ),
        ],
      ),
    );
  }

  // Khai bao bien _buildPasswordCard de luu du lieu su dung trong xu ly.
  Widget _buildPasswordCard(_ProfileSecurityMetrics metrics) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.surface,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(metrics.px(17)),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: Border.all(color: palette.cardBorder),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Column(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: [
          // Goi ham de thuc thi tac vu can thiet.
          _buildPasswordField(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            metrics: metrics,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            controller: _currentPasswordController,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            label: 'Mật Khẩu Hiện Tại',
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            icon: Icons.lock_outline,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            obscureText: _obscureCurrentPassword,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onToggle: () {
              // Cap nhat state de giao dien duoc render lai.
              setState(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                () => _obscureCurrentPassword = !_obscureCurrentPassword,
              );
            },
          ),
          // Goi ham de thuc thi tac vu can thiet.
          _buildPasswordField(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            metrics: metrics,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            controller: _newPasswordController,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            label: 'Mật Khẩu Mới',
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            icon: Icons.lock_reset_outlined,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            obscureText: _obscureNewPassword,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onToggle: () {
              // Cap nhat state de giao dien duoc render lai.
              setState(() => _obscureNewPassword = !_obscureNewPassword);
            },
          ),
          // Goi ham de thuc thi tac vu can thiet.
          _buildPasswordField(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            metrics: metrics,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            controller: _confirmPasswordController,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            label: 'Xác Nhận Mật Khẩu',
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            icon: Icons.lock_person_outlined,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            obscureText: _obscureConfirmPassword,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onToggle: () {
              // Cap nhat state de giao dien duoc render lai.
              setState(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                () => _obscureConfirmPassword = !_obscureConfirmPassword,
              );
            },
          ),
        ],
      ),
    );
  }

  // Khai bao bien _buildPasswordField de luu du lieu su dung trong xu ly.
  Widget _buildPasswordField({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required _ProfileSecurityMetrics metrics,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required TextEditingController controller,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required String label,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required IconData icon,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required bool obscureText,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required VoidCallback onToggle,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return Padding(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: EdgeInsets.fromLTRB(
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(12),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(10),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(12),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(10),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: TextField(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        controller: controller,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        obscureText: obscureText,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        style: AppTextStyles.bodyMedium.copyWith(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          color: palette.textPrimary,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          fontSize: metrics.fs(14),
        ),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        decoration: InputDecoration(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          labelText: label,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          labelStyle: AppTextStyles.bodySmall.copyWith(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: palette.textSecondary,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            fontSize: metrics.fs(12),
          ),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          prefixIcon: Icon(icon, color: palette.accent, size: metrics.px(18)),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          suffixIcon: IconButton(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onPressed: onToggle,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            icon: Icon(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              obscureText
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  ? Icons.visibility_off_outlined
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  : Icons.visibility_outlined,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: palette.textSecondary,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              size: metrics.px(18),
            ),
          ),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          filled: true,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          fillColor: palette.surfaceSoft,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          contentPadding: EdgeInsets.symmetric(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            horizontal: metrics.px(12),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            vertical: metrics.px(12),
          ),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          border: OutlineInputBorder(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            borderRadius: BorderRadius.circular(metrics.px(12)),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            borderSide: BorderSide(color: palette.cardBorder),
          ),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          enabledBorder: OutlineInputBorder(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            borderRadius: BorderRadius.circular(metrics.px(12)),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            borderSide: BorderSide(color: palette.cardBorder),
          ),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          focusedBorder: OutlineInputBorder(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            borderRadius: BorderRadius.circular(metrics.px(12)),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            borderSide: BorderSide(color: palette.accent, width: 1.1),
          ),
        ),
      ),
    );
  }

  // Khai bao bien _buildSessionCard de luu du lieu su dung trong xu ly.
  Widget _buildSessionCard(_ProfileSecurityMetrics metrics) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Khai bao bien sessions de luu du lieu su dung trong xu ly.
    const sessions = [
      // Goi ham de thuc thi tac vu can thiet.
      _SessionItem(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        device: 'iPhone 15 Pro - iOS 18',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        location: 'Hà Nội, Việt Nam',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        lastSeen: 'Đang hoạt động',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        isCurrent: true,
      ),
      // Goi ham de thuc thi tac vu can thiet.
      _SessionItem(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        device: 'MacBook Pro - Chrome',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        location: 'Hà Nội, Việt Nam',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        lastSeen: 'Hôm nay, 08:45',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        isCurrent: false,
      ),
      // Goi ham de thuc thi tac vu can thiet.
      _SessionItem(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        device: 'Windows PC - Edge',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        location: 'TP. Hồ Chí Minh, Việt Nam',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        lastSeen: '20/04, 22:31',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        isCurrent: false,
      ),
    ];

    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.surface,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(metrics.px(17)),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: Border.all(color: palette.cardBorder),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Column(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: List.generate(sessions.length, (index) {
          // Khai bao bien session de luu du lieu su dung trong xu ly.
          final session = sessions[index];
          // Tra ve ket qua cho noi goi ham.
          return Column(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Goi ham de thuc thi tac vu can thiet.
              ListTile(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                contentPadding: EdgeInsets.symmetric(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  horizontal: metrics.px(12),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  vertical: metrics.px(2),
                ),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                leading: Container(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  width: metrics.px(32),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  height: metrics.px(32),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  decoration: BoxDecoration(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: palette.iconContainer,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    borderRadius: BorderRadius.circular(metrics.px(10)),
                  ),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  alignment: Alignment.center,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  child: Icon(
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    Icons.devices_outlined,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: palette.accent,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    size: metrics.px(17),
                  ),
                ),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                title: Text(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  session.device,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: AppTextStyles.titleSmall.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: palette.textPrimary,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontWeight: FontWeight.w700,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontSize: metrics.fs(14),
                  ),
                ),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                subtitle: Padding(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  padding: EdgeInsets.only(top: metrics.px(3)),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  child: Text(
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    '${session.location} • ${session.lastSeen}',
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    style: AppTextStyles.bodySmall.copyWith(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      color: palette.textSecondary,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      fontSize: metrics.fs(12),
                    ),
                  ),
                ),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                trailing: session.isCurrent
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    ? Container(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        padding: EdgeInsets.symmetric(
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          horizontal: metrics.px(8),
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          vertical: metrics.px(4),
                        ),
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        decoration: BoxDecoration(
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          color: palette.tealAccent.withValues(alpha: 0.18),
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          borderRadius: BorderRadius.circular(999),
                        ),
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        child: Text(
                          // Thuc thi cau lenh hien tai theo luong xu ly.
                          'Hiện tại',
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          style: AppTextStyles.labelSmall.copyWith(
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            color: palette.tealAccent,
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            fontWeight: FontWeight.w700,
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            fontSize: metrics.fs(10),
                          ),
                        ),
                      )
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    : null,
              ),
              // Kiem tra dieu kien de re nhanh xu ly.
              if (index != sessions.length - 1)
                // Goi ham de thuc thi tac vu can thiet.
                Divider(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: palette.divider,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  height: 1,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  indent: metrics.px(13),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  endIndent: metrics.px(13),
                ),
            ],
          );
        }),
      ),
    );
  }
}

// Dinh nghia lop _ProfileSecurityPalette de gom nhom logic lien quan.
class _ProfileSecurityPalette {
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color background;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color gradientTop;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color gradientBottom;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color surface;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color surfaceSoft;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color accent;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color tealAccent;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color textPrimary;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color textSecondary;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color textMuted;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color cardBorder;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color divider;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color iconContainer;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color buttonForeground;

  // Khai bao bien _ProfileSecurityPalette de luu du lieu su dung trong xu ly.
  const _ProfileSecurityPalette({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.background,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.gradientTop,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.gradientBottom,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.surface,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.surfaceSoft,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.accent,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.tealAccent,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.textPrimary,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.textSecondary,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.textMuted,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.cardBorder,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.divider,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.iconContainer,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.buttonForeground,
  });

  // Thuc thi cau lenh hien tai theo luong xu ly.
  factory _ProfileSecurityPalette.fromTheme(ThemeData theme) {
    // Khai bao bien isDark de luu du lieu su dung trong xu ly.
    final isDark = theme.brightness == Brightness.dark;
    // Khai bao bien onSurface de luu du lieu su dung trong xu ly.
    final onSurface = theme.colorScheme.onSurface;

    // Tra ve ket qua cho noi goi ham.
    return _ProfileSecurityPalette(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      background: isDark ? const Color(0xFF07080A) : const Color(0xFFF4F7FB),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      gradientTop: isDark ? const Color(0xFF14161A) : const Color(0xFFFBFCFF),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      gradientBottom: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? const Color(0xFF060709)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : const Color(0xFFEEF2F8),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      surface: isDark ? const Color(0xFF16181D) : Colors.white,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      surfaceSoft: isDark ? const Color(0xFF1A1D22) : const Color(0xFFF2F5FA),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      accent: const Color(0xFFD8AD48),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      tealAccent: const Color(0xFF09B7A3),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      textPrimary: onSurface,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      textSecondary: onSurface.withValues(alpha: isDark ? 0.65 : 0.7),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      textMuted: onSurface.withValues(alpha: isDark ? 0.52 : 0.58),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      cardBorder: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? Colors.white.withValues(alpha: 0.07)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : Colors.black.withValues(alpha: 0.08),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      divider: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? Colors.white.withValues(alpha: 0.05)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : Colors.black.withValues(alpha: 0.06),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      iconContainer: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? Colors.white.withValues(alpha: 0.03)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : Colors.black.withValues(alpha: 0.03),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      buttonForeground: const Color(0xFF1A1710),
    );
  }
}

// Dinh nghia lop _DualToneSwitch de gom nhom logic lien quan.
class _DualToneSwitch extends StatelessWidget {
  // Khai bao bien bool de luu du lieu su dung trong xu ly.
  final bool value;
  // Khai bao bien ValueChanged de luu du lieu su dung trong xu ly.
  final ValueChanged<bool> onChanged;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color accentColor;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color tealAccentColor;

  // Khai bao bien _DualToneSwitch de luu du lieu su dung trong xu ly.
  const _DualToneSwitch({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.value,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.onChanged,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.accentColor,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.tealAccentColor,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien isDark de luu du lieu su dung trong xu ly.
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Tra ve ket qua cho noi goi ham.
    return GestureDetector(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      behavior: HitTestBehavior.opaque,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      onTap: () => onChanged(!value),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: AnimatedContainer(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        duration: AppConstants.shortDuration,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        width: 44,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        height: 24,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        padding: const EdgeInsets.all(2),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        decoration: BoxDecoration(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderRadius: BorderRadius.circular(999),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          gradient: LinearGradient(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            begin: Alignment.centerLeft,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            end: Alignment.centerRight,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            colors: value
                // Thuc thi cau lenh hien tai theo luong xu ly.
                ? [accentColor, tealAccentColor]
                // Thuc thi cau lenh hien tai theo luong xu ly.
                : isDark
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    ? [const Color(0xFF42464E), const Color(0xFF2E3138)]
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    : [const Color(0xFFD8DEE7), const Color(0xFFC6D0DD)],
          ),
        ),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: AnimatedAlign(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          duration: AppConstants.shortDuration,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Container(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            width: 20,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            height: 20,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            decoration: BoxDecoration(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              shape: BoxShape.circle,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: value
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  ? (isDark ? const Color(0xFFF5F7FA) : Colors.white)
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  : (isDark
                        // Thuc thi cau lenh hien tai theo luong xu ly.
                        ? const Color(0xFF9CA3AF)
                        // Thuc thi cau lenh hien tai theo luong xu ly.
                        : const Color(0xFF7B8794)),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              boxShadow: [
                // Goi ham de thuc thi tac vu can thiet.
                BoxShadow(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.12),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  blurRadius: 6,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
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

// Dinh nghia lop _SessionItem de gom nhom logic lien quan.
class _SessionItem {
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String device;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String location;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String lastSeen;
  // Khai bao bien bool de luu du lieu su dung trong xu ly.
  final bool isCurrent;

  // Khai bao bien _SessionItem de luu du lieu su dung trong xu ly.
  const _SessionItem({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.device,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.location,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.lastSeen,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.isCurrent,
  });
}

// Dinh nghia lop _ProfileSecurityMetrics de gom nhom logic lien quan.
class _ProfileSecurityMetrics {
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double scale;
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double textScale;

  // Khai bao bien _ProfileSecurityMetrics de luu du lieu su dung trong xu ly.
  const _ProfileSecurityMetrics._({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.scale,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.textScale,
  });

  // Thuc thi cau lenh hien tai theo luong xu ly.
  factory _ProfileSecurityMetrics.fromWidth(double width) {
    // Khai bao bien rawScale de luu du lieu su dung trong xu ly.
    final rawScale = width / 390;
    // Tra ve ket qua cho noi goi ham.
    return _ProfileSecurityMetrics._(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      scale: rawScale.clamp(0.88, 1.14).toDouble(),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      textScale: rawScale.clamp(0.92, 1.09).toDouble(),
    );
  }

  // Khai bao bien px de luu du lieu su dung trong xu ly.
  double px(double value) => value * scale;

  // Khai bao bien fs de luu du lieu su dung trong xu ly.
  double fs(double value) => value * textScale;
}
