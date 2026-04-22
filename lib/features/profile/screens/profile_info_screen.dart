// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';

// Nap thu vien hoac module can thiet.
import '../../../shared/constants/app_constants.dart';
// Nap thu vien hoac module can thiet.
import '../../../shared/services/service_locator.dart';
// Nap thu vien hoac module can thiet.
import '../../../shared/themes/app_colors.dart';
// Nap thu vien hoac module can thiet.
import '../../authentication/services/auth_service.dart';

// Dinh nghia lop ProfileInfoScreen de gom nhom logic lien quan.
class ProfileInfoScreen extends StatefulWidget {
  // Khai bao bien ProfileInfoScreen de luu du lieu su dung trong xu ly.
  const ProfileInfoScreen({super.key});

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Thuc thi cau lenh hien tai theo luong xu ly.
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

// Dinh nghia lop _ProfileInfoScreenState de gom nhom logic lien quan.
class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  // Dinh nghia ham _palette de xu ly nghiep vu tuong ung.
  _ProfileInfoPalette _palette(BuildContext context) {
    // Tra ve ket qua cho noi goi ham.
    return _ProfileInfoPalette.fromTheme(Theme.of(context));
  }

  // Khai bao bien AuthService de luu du lieu su dung trong xu ly.
  final AuthService _authService = getIt<AuthService>();

  // Khai bao bien final de luu du lieu su dung trong xu ly.
  late final TextEditingController _nameController;
  // Khai bao bien final de luu du lieu su dung trong xu ly.
  late final TextEditingController _emailController;
  // Khai bao bien final de luu du lieu su dung trong xu ly.
  late final TextEditingController _phoneController;
  // Khai bao bien final de luu du lieu su dung trong xu ly.
  late final TextEditingController _positionController;
  // Khai bao bien final de luu du lieu su dung trong xu ly.
  late final TextEditingController _departmentController;

  // Khai bao bien _isSaving de luu du lieu su dung trong xu ly.
  bool _isSaving = false;

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Dinh nghia ham initState de xu ly nghiep vu tuong ung.
  void initState() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.initState();
    // Khai bao bien user de luu du lieu su dung trong xu ly.
    final user = _authService.currentUser;
    // Gan gia tri cho bien _nameController.
    _nameController = TextEditingController(text: user?.name ?? '');
    // Gan gia tri cho bien _emailController.
    _emailController = TextEditingController(text: user?.email ?? '');
    // Gan gia tri cho bien _phoneController.
    _phoneController = TextEditingController(text: user?.phone ?? '');
    // Gan gia tri cho bien _positionController.
    _positionController = TextEditingController(text: _roleLabel(user?.role));
    // Gan gia tri cho bien _departmentController.
    _departmentController = TextEditingController(text: 'Phòng Kinh Doanh');
  }

  // Khai bao bien _roleLabel de luu du lieu su dung trong xu ly.
  String _roleLabel(String? role) {
    // Bat dau re nhanh theo nhieu truong hop gia tri.
    switch (role?.toLowerCase()) {
      // Xu ly mot truong hop cu the trong switch.
      case 'admin':
        // Tra ve ket qua cho noi goi ham.
        return 'Quản trị viên';
      // Xu ly mot truong hop cu the trong switch.
      case 'manager':
        // Tra ve ket qua cho noi goi ham.
        return 'Giám Đốc Kinh Doanh';
      // Xu ly mac dinh khi khong khop case nao.
      default:
        // Tra ve ket qua cho noi goi ham.
        return 'Nhân viên';
    }
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Dinh nghia ham dispose de xu ly nghiep vu tuong ung.
  void dispose() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _nameController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _emailController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _phoneController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _positionController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _departmentController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.dispose();
  }

  // Khai bao bien _saveProfile de luu du lieu su dung trong xu ly.
  Future<void> _saveProfile() async {
    // Kiem tra dieu kien de re nhanh xu ly.
    if (_isSaving) return;
    // Cap nhat state de giao dien duoc render lai.
    setState(() => _isSaving = true);

    // Bao boc khoi lenh co the phat sinh loi de xu ly an toan.
    try {
      // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
      await _authService.updateProfile({
        // Thuc thi cau lenh hien tai theo luong xu ly.
        'name': _nameController.text.trim(),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        'phone': _phoneController.text.trim(),
      });

      // Kiem tra dieu kien de re nhanh xu ly.
      if (!mounted) return;
      // Thuc thi cau lenh hien tai theo luong xu ly.
      ScaffoldMessenger.of(context)
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ..hideCurrentSnackBar()
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ..showSnackBar(
          // Khai bao bien SnackBar de luu du lieu su dung trong xu ly.
          const SnackBar(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            content: Text('Đã lưu thay đổi thông tin cá nhân.'),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            behavior: SnackBarBehavior.floating,
          ),
        );
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } catch (e) {
      // Kiem tra dieu kien de re nhanh xu ly.
      if (!mounted) return;
      // Thuc thi cau lenh hien tai theo luong xu ly.
      ScaffoldMessenger.of(context)
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ..hideCurrentSnackBar()
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ..showSnackBar(
          // Khai bao bien SnackBar de luu du lieu su dung trong xu ly.
          const SnackBar(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            content: Text('Không thể lưu. Vui lòng thử lại.'),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            behavior: SnackBarBehavior.floating,
          ),
        );
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } finally {
      // Kiem tra dieu kien de re nhanh xu ly.
      if (mounted) {
        // Cap nhat state de giao dien duoc render lai.
        setState(() => _isSaving = false);
      }
    }
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien metrics de luu du lieu su dung trong xu ly.
    final metrics = _ProfileInfoMetrics.fromWidth(
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
          'Thông Tin Cá Nhân',
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
                _buildIdentityCard(metrics),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(16)),
                // Goi ham de thuc thi tac vu can thiet.
                _buildSectionTitle('THÔNG TIN CƠ BẢN', metrics),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(8)),
                // Goi ham de thuc thi tac vu can thiet.
                _buildFormCard(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  metrics: metrics,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  children: [
                    // Goi ham de thuc thi tac vu can thiet.
                    _buildInputField(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      metrics: metrics,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      label: 'Họ Và Tên',
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      icon: Icons.person_outline_rounded,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      controller: _nameController,
                    ),
                    // Goi ham de thuc thi tac vu can thiet.
                    _buildInputField(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      metrics: metrics,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      label: 'Email',
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      icon: Icons.email_outlined,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      controller: _emailController,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      keyboardType: TextInputType.emailAddress,
                    ),
                    // Goi ham de thuc thi tac vu can thiet.
                    _buildInputField(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      metrics: metrics,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      label: 'Số Điện Thoại',
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      icon: Icons.phone_outlined,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      controller: _phoneController,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(14)),
                // Goi ham de thuc thi tac vu can thiet.
                _buildSectionTitle('THÔNG TIN CÔNG VIỆC', metrics),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(8)),
                // Goi ham de thuc thi tac vu can thiet.
                _buildFormCard(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  metrics: metrics,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  children: [
                    // Goi ham de thuc thi tac vu can thiet.
                    _buildInputField(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      metrics: metrics,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      label: 'Chức Danh',
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      icon: Icons.badge_outlined,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      controller: _positionController,
                    ),
                    // Goi ham de thuc thi tac vu can thiet.
                    _buildInputField(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      metrics: metrics,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      label: 'Phòng Ban',
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      icon: Icons.apartment_outlined,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      controller: _departmentController,
                    ),
                  ],
                ),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(16)),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  width: double.infinity,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  child: FilledButton.icon(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    onPressed: _saveProfile,
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
                      Icons.check_circle_outline,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      size: metrics.px(18),
                    ),
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    label: Text(
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      'Lưu Thay Đổi',
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

  // Khai bao bien _buildIdentityCard de luu du lieu su dung trong xu ly.
  Widget _buildIdentityCard(_ProfileInfoMetrics metrics) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      width: double.infinity,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: EdgeInsets.fromLTRB(
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(14),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(14),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(14),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(13),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.surface,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(metrics.px(18)),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: Border.all(color: palette.cardBorder),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Row(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: [
          // Goi ham de thuc thi tac vu can thiet.
          Container(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            width: metrics.px(58),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            height: metrics.px(58),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            decoration: const BoxDecoration(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              shape: BoxShape.circle,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              gradient: LinearGradient(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                colors: [Color(0xFFE4C15D), Color(0xFFD6A93E)],
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                begin: Alignment.topLeft,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                end: Alignment.bottomRight,
              ),
            ),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            alignment: Alignment.center,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Text(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              (_authService.currentUser?.name ?? 'U').substring(0, 1).toUpperCase(),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              style: AppTextStyles.headlineSmall.copyWith(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                color: palette.buttonForeground,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                fontWeight: FontWeight.w800,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                fontSize: metrics.fs(28),
              ),
            ),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          SizedBox(width: metrics.px(12)),
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
                  'Hồ Sơ Đã Xác Thực',
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: AppTextStyles.labelMedium.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: palette.tealAccent,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontWeight: FontWeight.w700,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontSize: metrics.fs(12),
                  ),
                ),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(3)),
                // Goi ham de thuc thi tac vu can thiet.
                Text(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  'Dữ liệu tài khoản của bạn đã đồng bộ với hệ thống nhân sự.',
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: AppTextStyles.bodySmall.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: palette.textSecondary,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontSize: metrics.fs(12),
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
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

  // Khai bao bien _buildSectionTitle de luu du lieu su dung trong xu ly.
  Widget _buildSectionTitle(String text, _ProfileInfoMetrics metrics) {
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

  // Khai bao bien _buildFormCard de luu du lieu su dung trong xu ly.
  Widget _buildFormCard({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required _ProfileInfoMetrics metrics,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required List<Widget> children,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) {
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
      child: Column(children: children),
    );
  }

  // Khai bao bien _buildInputField de luu du lieu su dung trong xu ly.
  Widget _buildInputField({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required _ProfileInfoMetrics metrics,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required String label,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required IconData icon,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required TextEditingController controller,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    TextInputType keyboardType = TextInputType.text,
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
        keyboardType: keyboardType,
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
}

// Dinh nghia lop _ProfileInfoPalette de gom nhom logic lien quan.
class _ProfileInfoPalette {
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
  final Color buttonForeground;

  // Khai bao bien _ProfileInfoPalette de luu du lieu su dung trong xu ly.
  const _ProfileInfoPalette({
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
    required this.buttonForeground,
  });

  // Thuc thi cau lenh hien tai theo luong xu ly.
  factory _ProfileInfoPalette.fromTheme(ThemeData theme) {
    // Khai bao bien isDark de luu du lieu su dung trong xu ly.
    final isDark = theme.brightness == Brightness.dark;
    // Khai bao bien onSurface de luu du lieu su dung trong xu ly.
    final onSurface = theme.colorScheme.onSurface;

    // Tra ve ket qua cho noi goi ham.
    return _ProfileInfoPalette(
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
      buttonForeground: const Color(0xFF1A1710),
    );
  }
}

// Dinh nghia lop _ProfileInfoMetrics de gom nhom logic lien quan.
class _ProfileInfoMetrics {
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double scale;
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double textScale;

  // Khai bao bien _ProfileInfoMetrics de luu du lieu su dung trong xu ly.
  const _ProfileInfoMetrics._({required this.scale, required this.textScale});

  // Thuc thi cau lenh hien tai theo luong xu ly.
  factory _ProfileInfoMetrics.fromWidth(double width) {
    // Khai bao bien rawScale de luu du lieu su dung trong xu ly.
    final rawScale = width / 390;
    // Tra ve ket qua cho noi goi ham.
    return _ProfileInfoMetrics._(
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
