// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';
// Nap thu vien hoac module can thiet.
import 'package:go_router/go_router.dart';

// Nap thu vien hoac module can thiet.
import '../../../shared/constants/app_constants.dart';
// Nap thu vien hoac module can thiet.
import '../../../shared/services/service_locator.dart';
// Nap thu vien hoac module can thiet.
import '../../../shared/themes/app_colors.dart';
// Nap thu vien hoac module can thiet.
import '../models/dashboard_summary_model.dart';
// Nap thu vien hoac module can thiet.
import '../models/inventory_quick_action_models.dart';
// Nap thu vien hoac module can thiet.
import '../models/quick_action_models.dart';
// Nap thu vien hoac module can thiet.
import '../models/sales_quick_action_models.dart';
// Nap thu vien hoac module can thiet.
import '../services/inventory_quick_action_service.dart';
// Nap thu vien hoac module can thiet.
import '../services/report_service.dart';
// Nap thu vien hoac module can thiet.
import '../services/sales_quick_action_service.dart';
// Nap thu vien hoac module can thiet.
import '../services/support_service.dart';

// Report Quick Action Sheet

// Dinh nghia lop ReportQuickActionSheet de gom nhom logic lien quan.
class ReportQuickActionSheet extends StatefulWidget {
  // Khai bao bien ReportQuickActionSheet de luu du lieu su dung trong xu ly.
  const ReportQuickActionSheet({super.key});

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Thuc thi cau lenh hien tai theo luong xu ly.
  State<ReportQuickActionSheet> createState() => _ReportQuickActionSheetState();
}

// Dinh nghia lop _ReportQuickActionSheetState de gom nhom logic lien quan.
class _ReportQuickActionSheetState extends State<ReportQuickActionSheet> {
  // Khai bao bien ReportService de luu du lieu su dung trong xu ly.
  final ReportService _reportService = getIt<ReportService>();
  // Khai bao bien Future de luu du lieu su dung trong xu ly.
  late Future<ReportQuickActionData> _reportFuture;

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Dinh nghia ham initState de xu ly nghiep vu tuong ung.
  void initState() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.initState();
    // Gan gia tri cho bien _reportFuture.
    _reportFuture = _reportService.fetchReportOverview();
  }

  // Khai bao bien _reload de luu du lieu su dung trong xu ly.
  Future<void> _reload() async {
    // Cap nhat state de giao dien duoc render lai.
    setState(() {
      // Gan gia tri cho bien _reportFuture.
      _reportFuture = _reportService.fetchReportOverview();
    });
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _QuickActionSheetPalette.fromTheme(Theme.of(context));

    // Tra ve ket qua cho noi goi ham.
    return _QuickActionSheetScaffold(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      accentColor: const Color(0xFF5F86D9),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      icon: Icons.pie_chart_outline_rounded,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      title: 'Báo cáo nhanh',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      subtitle: 'Tổng quan doanh thu, mục tiêu và giao dịch mới nhất.',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      trailing: IconButton(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onPressed: _reload,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icon(Icons.refresh_rounded, color: palette.textSecondary),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        tooltip: 'Làm mới',
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: FutureBuilder<ReportQuickActionData>(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        future: _reportFuture,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        builder: (context, snapshot) {
          // Kiem tra dieu kien de re nhanh xu ly.
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Tra ve ket qua cho noi goi ham.
            return const Center(child: CircularProgressIndicator());
          }

          // Kiem tra dieu kien de re nhanh xu ly.
          if (snapshot.hasError) {
            // Tra ve ket qua cho noi goi ham.
            return _QuickActionErrorState(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              palette: palette,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              message: 'Không thể tải báo cáo. Vui lòng thử lại.',
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              onRetry: _reload,
            );
          }

          // Khai bao bien data de luu du lieu su dung trong xu ly.
          final data = snapshot.data;
          // Kiem tra dieu kien de re nhanh xu ly.
          if (data == null) {
            // Tra ve ket qua cho noi goi ham.
            return _QuickActionErrorState(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              palette: palette,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              message: 'Không có dữ liệu báo cáo.',
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              onRetry: _reload,
            );
          }

          // Tra ve ket qua cho noi goi ham.
          return RefreshIndicator(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onRefresh: _reload,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: palette.accent,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: ListView(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              physics: const BouncingScrollPhysics(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                parent: AlwaysScrollableScrollPhysics(),
              ),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              padding: const EdgeInsets.fromLTRB(18, 2, 18, 24),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              children: [
                // Goi ham de thuc thi tac vu can thiet.
                _buildOverviewGrid(context, palette, data.summary),
                // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                const SizedBox(height: 16),
                // Goi ham de thuc thi tac vu can thiet.
                _buildGoalCard(context, palette, data.goals),
                // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                const SizedBox(height: 16),
                // Goi ham de thuc thi tac vu can thiet.
                _SectionTitle(title: 'Giao dịch gần đây', palette: palette),
                // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                const SizedBox(height: 10),
                // Kiem tra dieu kien de re nhanh xu ly.
                if (data.summary.recentTransactions.isEmpty)
                  // Goi ham de thuc thi tac vu can thiet.
                  _EmptySection(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    palette: palette,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    message: 'Chưa có giao dịch nào để hiển thị.',
                  )
                // Xu ly nhanh con lai khi dieu kien khong thoa.
                else
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  ...data.summary.recentTransactions.map(
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    (transaction) => Padding(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      padding: const EdgeInsets.only(bottom: 10),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      child: _RecentTransactionTile(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        palette: palette,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        customerName: transaction.customerName,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        carName: transaction.carName,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        amount: transaction.amount,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        timeAgo: transaction.timeAgo,
                      ),
                    ),
                  ),
                // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                const SizedBox(height: 16),
                // Goi ham de thuc thi tac vu can thiet.
                _SectionTitle(title: 'Gợi ý cải thiện', palette: palette),
                // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                const SizedBox(height: 10),
                // Kiem tra dieu kien de re nhanh xu ly.
                if (data.goals.suggestions.isEmpty)
                  // Goi ham de thuc thi tac vu can thiet.
                  _EmptySection(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    palette: palette,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    message: 'Chưa có đề xuất mới từ hệ thống.',
                  )
                // Xu ly nhanh con lai khi dieu kien khong thoa.
                else
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  ...data.goals.suggestions.map(
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    (suggestion) => Padding(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      padding: const EdgeInsets.only(bottom: 10),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      child: _SuggestionTile(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        palette: palette,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        suggestion: suggestion,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Khai bao bien _buildOverviewGrid de luu du lieu su dung trong xu ly.
  Widget _buildOverviewGrid(
    // Thuc thi cau lenh hien tai theo luong xu ly.
    BuildContext context,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _QuickActionSheetPalette palette,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    DashboardSummaryModel summary,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  ) {
    // Khai bao bien tiles de luu du lieu su dung trong xu ly.
    final tiles = [
      // Goi ham de thuc thi tac vu can thiet.
      _MetricTile(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        palette: palette,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.directions_car_filled_outlined,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        label: 'Tổng xe',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        value: summary.totalCars.toString(),
      ),
      // Goi ham de thuc thi tac vu can thiet.
      _MetricTile(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        palette: palette,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.sell_outlined,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        label: 'Xe đã bán',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        value: summary.carsSold.toString(),
      ),
      // Goi ham de thuc thi tac vu can thiet.
      _MetricTile(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        palette: palette,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.inventory_2_outlined,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        label: 'Trong kho',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        value: summary.inStock.toString(),
      ),
      // Goi ham de thuc thi tac vu can thiet.
      _MetricTile(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        palette: palette,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.account_balance_wallet_outlined,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        label: 'Doanh thu',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        value: summary.totalRevenueLabel,
      ),
    ];

    // Tra ve ket qua cho noi goi ham.
    return GridView.builder(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      shrinkWrap: true,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      physics: const NeverScrollableScrollPhysics(),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      itemCount: tiles.length,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        crossAxisCount: 2,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        mainAxisSpacing: 10,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        crossAxisSpacing: 10,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        childAspectRatio: 1.28,
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      itemBuilder: (context, index) => tiles[index],
    );
  }

  // Khai bao bien _buildGoalCard de luu du lieu su dung trong xu ly.
  Widget _buildGoalCard(
    // Thuc thi cau lenh hien tai theo luong xu ly.
    BuildContext context,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _QuickActionSheetPalette palette,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    ReportGoalsModel goals,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  ) {
    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: const EdgeInsets.all(16),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.surface,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(22),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: Border.all(color: palette.border),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        boxShadow: [
          // Goi ham de thuc thi tac vu can thiet.
          BoxShadow(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: palette.shadow,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            blurRadius: 20,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            offset: const Offset(0, 10),
          ),
        ],
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Column(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        crossAxisAlignment: CrossAxisAlignment.start,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: [
          // Goi ham de thuc thi tac vu can thiet.
          Row(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Goi ham de thuc thi tac vu can thiet.
              Container(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                padding: const EdgeInsets.all(10),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                decoration: BoxDecoration(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: palette.accentSoft,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  borderRadius: BorderRadius.circular(14),
                ),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: Icon(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  Icons.rocket_launch_outlined,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  size: 18,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: palette.accent,
                ),
              ),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(width: 12),
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
                      'Mục tiêu tháng',
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      style: AppTextStyles.titleMedium.copyWith(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        color: palette.textPrimary,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                    const SizedBox(height: 2),
                    // Goi ham de thuc thi tac vu can thiet.
                    Text(
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      goals.progressText,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      style: AppTextStyles.bodySmall.copyWith(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        color: palette.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              // Goi ham de thuc thi tac vu can thiet.
              Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                goals.achievedRate,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: AppTextStyles.titleMedium.copyWith(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: palette.accent,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
          const SizedBox(height: 14),
          // Goi ham de thuc thi tac vu can thiet.
          ClipRRect(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            borderRadius: BorderRadius.circular(999),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: LinearProgressIndicator(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              minHeight: 10,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              value: goals.progressValue,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              backgroundColor: palette.progressBackground,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: palette.accent,
            ),
          ),
          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
          const SizedBox(height: 12),
          // Goi ham de thuc thi tac vu can thiet.
          Row(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Goi ham de thuc thi tac vu can thiet.
              Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                'Mục tiêu doanh thu',
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: AppTextStyles.labelLarge.copyWith(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: palette.textSecondary,
                ),
              ),
              // Goi ham de thuc thi tac vu can thiet.
              Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                goals.revenueTarget,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: AppTextStyles.titleSmall.copyWith(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: palette.textPrimary,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Support Quick Action Sheet

// Dinh nghia lop SupportQuickActionSheet de gom nhom logic lien quan.
class SupportQuickActionSheet extends StatefulWidget {
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String initialName;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String initialEmail;

  // Khai bao bien SupportQuickActionSheet de luu du lieu su dung trong xu ly.
  const SupportQuickActionSheet({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.key,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.initialName,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.initialEmail,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Thuc thi cau lenh hien tai theo luong xu ly.
  State<SupportQuickActionSheet> createState() => _SupportQuickActionSheetState();
}

// Dinh nghia lop _SupportQuickActionSheetState de gom nhom logic lien quan.
class _SupportQuickActionSheetState extends State<SupportQuickActionSheet> {
  // Khai bao bien SupportService de luu du lieu su dung trong xu ly.
  final SupportService _supportService = getIt<SupportService>();
  // Khai bao bien GlobalKey de luu du lieu su dung trong xu ly.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Khai bao bien final de luu du lieu su dung trong xu ly.
  late final TextEditingController _nameController;
  // Khai bao bien final de luu du lieu su dung trong xu ly.
  late final TextEditingController _emailController;
  // Khai bao bien final de luu du lieu su dung trong xu ly.
  late final TextEditingController _messageController;
  // Khai bao bien Future de luu du lieu su dung trong xu ly.
  late Future<List<SupportItemModel>> _supportItemsFuture;
  // Khai bao bien Future de luu du lieu su dung trong xu ly.
  late Future<List<SupportContactSubmissionModel>> _myRequestsFuture;
  // Khai bao bien _isSubmitting de luu du lieu su dung trong xu ly.
  bool _isSubmitting = false;

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Dinh nghia ham initState de xu ly nghiep vu tuong ung.
  void initState() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.initState();
    // Gan gia tri cho bien _nameController.
    _nameController = TextEditingController(text: widget.initialName);
    // Gan gia tri cho bien _emailController.
    _emailController = TextEditingController(text: widget.initialEmail);
    // Gan gia tri cho bien _messageController.
    _messageController = TextEditingController();
    // Gan gia tri cho bien _supportItemsFuture.
    _supportItemsFuture = _supportService.fetchSupportItems();
    // Gan gia tri cho bien _myRequestsFuture.
    _myRequestsFuture = _supportService.fetchMyRequests();
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
    _messageController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.dispose();
  }

  // Khai bao bien _reloadSupportItems de luu du lieu su dung trong xu ly.
  Future<void> _reloadSupportItems() async {
    // Cap nhat state de giao dien duoc render lai.
    setState(() {
      // Gan gia tri cho bien _supportItemsFuture.
      _supportItemsFuture = _supportService.fetchSupportItems();
      // Gan gia tri cho bien _myRequestsFuture.
      _myRequestsFuture = _supportService.fetchMyRequests();
    });
  }

  // Khai bao bien _submitContact de luu du lieu su dung trong xu ly.
  Future<void> _submitContact() async {
    // Kiem tra dieu kien de re nhanh xu ly.
    if (!_formKey.currentState!.validate()) {
      // Tra ve ket qua cho noi goi ham.
      return;
    }

    // Cap nhat state de giao dien duoc render lai.
    setState(() {
      // Gan gia tri cho bien _isSubmitting.
      _isSubmitting = true;
    });

    // Bao boc khoi lenh co the phat sinh loi de xu ly an toan.
    try {
      // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
      await _supportService.sendContact(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        name: _nameController.text,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        email: _emailController.text,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        message: _messageController.text,
      );

      // Kiem tra dieu kien de re nhanh xu ly.
      if (!mounted) {
        // Tra ve ket qua cho noi goi ham.
        return;
      }

      // Thuc thi cau lenh hien tai theo luong xu ly.
      Navigator.of(context).pop(true);
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } catch (_) {
      // Kiem tra dieu kien de re nhanh xu ly.
      if (!mounted) {
        // Tra ve ket qua cho noi goi ham.
        return;
      }

      // Thuc thi cau lenh hien tai theo luong xu ly.
      ScaffoldMessenger.of(context).showSnackBar(
        // Goi ham de thuc thi tac vu can thiet.
        SnackBar(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          content: const Text('Không thể gửi yêu cầu hỗ trợ. Vui lòng thử lại.'),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          behavior: SnackBarBehavior.floating,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          backgroundColor: AppColors.error.withValues(alpha: 0.92),
        ),
      );
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } finally {
      // Kiem tra dieu kien de re nhanh xu ly.
      if (mounted) {
        // Cap nhat state de giao dien duoc render lai.
        setState(() {
          // Gan gia tri cho bien _isSubmitting.
          _isSubmitting = false;
        });
      }
    }
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _QuickActionSheetPalette.fromTheme(Theme.of(context));

    // Tra ve ket qua cho noi goi ham.
    return _QuickActionSheetScaffold(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      accentColor: const Color(0xFFE57E6D),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      icon: Icons.support_agent_rounded,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      title: 'Liên hệ hỗ trợ',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      subtitle: 'Gửi yêu cầu hoặc xem các kênh hỗ trợ có sẵn.',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      trailing: IconButton(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onPressed: _reloadSupportItems,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icon(Icons.refresh_rounded, color: palette.textSecondary),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        tooltip: 'Làm mới',
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: ListView(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        physics: const BouncingScrollPhysics(),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        padding: const EdgeInsets.fromLTRB(18, 2, 18, 24),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: [
          // Goi ham de thuc thi tac vu can thiet.
          _buildSupportItemsSection(palette),
          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
          const SizedBox(height: 16),
          // Goi ham de thuc thi tac vu can thiet.
          _buildMyRequestsSection(palette),
          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
          const SizedBox(height: 16),
          // Goi ham de thuc thi tac vu can thiet.
          _buildContactForm(palette),
        ],
      ),
    );
  }

  // Khai bao bien _buildSupportItemsSection de luu du lieu su dung trong xu ly.
  Widget _buildSupportItemsSection(_QuickActionSheetPalette palette) {
    // Tra ve ket qua cho noi goi ham.
    return FutureBuilder<List<SupportItemModel>>(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      future: _supportItemsFuture,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      builder: (context, snapshot) {
        // Kiem tra dieu kien de re nhanh xu ly.
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Tra ve ket qua cho noi goi ham.
          return const Center(child: CircularProgressIndicator());
        }

        // Kiem tra dieu kien de re nhanh xu ly.
        if (snapshot.hasError) {
          // Tra ve ket qua cho noi goi ham.
          return _QuickActionErrorState(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            palette: palette,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            message: 'Không thể tải danh sách hỗ trợ.',
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onRetry: _reloadSupportItems,
          );
        }

        // Khai bao bien items de luu du lieu su dung trong xu ly.
        final items = snapshot.data ?? const <SupportItemModel>[];
        // Kiem tra dieu kien de re nhanh xu ly.
        if (items.isEmpty) {
          // Tra ve ket qua cho noi goi ham.
          return _EmptySection(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            palette: palette,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            message: 'Chưa có mục hỗ trợ nào.',
          );
        }

        // Tra ve ket qua cho noi goi ham.
        return Column(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          crossAxisAlignment: CrossAxisAlignment.start,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          children: [
            // Goi ham de thuc thi tac vu can thiet.
            _SectionTitle(title: 'Kênh hỗ trợ', palette: palette),
            // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
            const SizedBox(height: 10),
            // Thuc thi cau lenh hien tai theo luong xu ly.
            ...items.map(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              (item) => Padding(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                padding: const EdgeInsets.only(bottom: 10),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: _SupportItemTile(palette: palette, item: item),
              ),
            ),
          ],
        );
      },
    );
  }

  // Khai bao bien _buildMyRequestsSection de luu du lieu su dung trong xu ly.
  Widget _buildMyRequestsSection(_QuickActionSheetPalette palette) {
    // Tra ve ket qua cho noi goi ham.
    return FutureBuilder<List<SupportContactSubmissionModel>>(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      future: _myRequestsFuture,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      builder: (context, snapshot) {
        // Kiem tra dieu kien de re nhanh xu ly.
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Tra ve ket qua cho noi goi ham.
          return const SizedBox.shrink();
        }

        // Kiem tra dieu kien de re nhanh xu ly.
        if (snapshot.hasError) {
          // Tra ve ket qua cho noi goi ham.
          return const SizedBox.shrink();
        }

        // Khai bao bien requests de luu du lieu su dung trong xu ly.
        final requests = snapshot.data ?? const <SupportContactSubmissionModel>[];
        // Kiem tra dieu kien de re nhanh xu ly.
        if (requests.isEmpty) {
          // Tra ve ket qua cho noi goi ham.
          return const SizedBox.shrink();
        }

        // Tra ve ket qua cho noi goi ham.
        return Column(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          crossAxisAlignment: CrossAxisAlignment.start,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          children: [
            // Goi ham de thuc thi tac vu can thiet.
            _SectionTitle(title: 'Yêu cầu của tôi', palette: palette),
            // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
            const SizedBox(height: 10),
            // Thuc thi cau lenh hien tai theo luong xu ly.
            ...requests.map(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              (request) => Padding(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                padding: const EdgeInsets.only(bottom: 10),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: _MyRequestTile(palette: palette, request: request),
              ),
            ),
          ],
        );
      },
    );
  }

  // Khai bao bien _buildContactForm de luu du lieu su dung trong xu ly.
  Widget _buildContactForm(_QuickActionSheetPalette palette) {
    // Tra ve ket qua cho noi goi ham.
    return Form(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      key: _formKey,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Container(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        padding: const EdgeInsets.all(16),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        decoration: BoxDecoration(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          color: palette.surface,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderRadius: BorderRadius.circular(22),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          border: Border.all(color: palette.border),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          boxShadow: [
            // Goi ham de thuc thi tac vu can thiet.
            BoxShadow(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: palette.shadow,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              blurRadius: 20,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              offset: const Offset(0, 10),
            ),
          ],
        ),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: Column(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          crossAxisAlignment: CrossAxisAlignment.start,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          children: [
            // Goi ham de thuc thi tac vu can thiet.
            _SectionTitle(title: 'Gửi yêu cầu mới', palette: palette),
            // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
            const SizedBox(height: 12),
            // Goi ham de thuc thi tac vu can thiet.
            TextFormField(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              controller: _nameController,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              textInputAction: TextInputAction.next,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              decoration: _fieldDecoration(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                palette: palette,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                labelText: 'Họ và tên',
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                hintText: 'Nhập tên liên hệ',
              ),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              validator: (value) {
                // Kiem tra dieu kien de re nhanh xu ly.
                if (value == null || value.trim().isEmpty) {
                  // Tra ve ket qua cho noi goi ham.
                  return 'Vui lòng nhập họ và tên';
                }
                // Tra ve ket qua cho noi goi ham.
                return null;
              },
            ),
            // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
            const SizedBox(height: 12),
            // Goi ham de thuc thi tac vu can thiet.
            TextFormField(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              controller: _emailController,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              textInputAction: TextInputAction.next,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              keyboardType: TextInputType.emailAddress,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              decoration: _fieldDecoration(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                palette: palette,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                labelText: 'Email',
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                hintText: 'name@company.com',
              ),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              validator: (value) {
                // Khai bao bien input de luu du lieu su dung trong xu ly.
                final input = value?.trim() ?? '';
                // Kiem tra dieu kien de re nhanh xu ly.
                if (input.isEmpty) {
                  // Tra ve ket qua cho noi goi ham.
                  return 'Vui lòng nhập email';
                }
                // Kiem tra dieu kien de re nhanh xu ly.
                if (!input.contains('@') || !input.contains('.')) {
                  // Tra ve ket qua cho noi goi ham.
                  return 'Email không hợp lệ';
                }
                // Tra ve ket qua cho noi goi ham.
                return null;
              },
            ),
            // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
            const SizedBox(height: 12),
            // Goi ham de thuc thi tac vu can thiet.
            TextFormField(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              controller: _messageController,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              maxLines: 5,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              textInputAction: TextInputAction.newline,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              decoration: _fieldDecoration(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                palette: palette,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                labelText: 'Nội dung hỗ trợ',
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                hintText: 'Mô tả ngắn gọn vấn đề hoặc nhu cầu của bạn',
              ),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              validator: (value) {
                // Kiem tra dieu kien de re nhanh xu ly.
                if (value == null || value.trim().isEmpty) {
                  // Tra ve ket qua cho noi goi ham.
                  return 'Vui lòng nhập nội dung cần hỗ trợ';
                }
                // Kiem tra dieu kien de re nhanh xu ly.
                if (value.trim().length < 10) {
                  // Tra ve ket qua cho noi goi ham.
                  return 'Nội dung cần ít nhất 10 ký tự';
                }
                // Tra ve ket qua cho noi goi ham.
                return null;
              },
            ),
            // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
            const SizedBox(height: 16),
            // Goi ham de thuc thi tac vu can thiet.
            SizedBox(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              width: double.infinity,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              child: FilledButton.icon(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                onPressed: _isSubmitting ? null : _submitContact,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                icon: _isSubmitting
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    ? SizedBox(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        width: 18,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        height: 18,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        child: CircularProgressIndicator(
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          strokeWidth: 2.2,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          color: palette.onAccent,
                        ),
                      )
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    : const Icon(Icons.send_rounded),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                label: Text(_isSubmitting ? 'Đang gửi...' : 'Gửi yêu cầu'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Thuc thi cau lenh hien tai theo luong xu ly.
  InputDecoration _fieldDecoration({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required _QuickActionSheetPalette palette,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required String labelText,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required String hintText,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) {
    // Tra ve ket qua cho noi goi ham.
    return InputDecoration(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      labelText: labelText,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      hintText: hintText,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      filled: true,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      fillColor: palette.inputFill,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      border: OutlineInputBorder(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(16),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderSide: BorderSide(color: palette.border),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      enabledBorder: OutlineInputBorder(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(16),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderSide: BorderSide(color: palette.border),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      focusedBorder: OutlineInputBorder(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(16),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderSide: BorderSide(color: palette.accent, width: 1.4),
      ),
    );
  }
}

// Sales Quick Action Sheet

// Dinh nghia lop SalesQuickActionSheet de gom nhom logic lien quan.
class SalesQuickActionSheet extends StatefulWidget {
  // Khai bao bien SalesQuickActionSheet de luu du lieu su dung trong xu ly.
  const SalesQuickActionSheet({super.key});

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Thuc thi cau lenh hien tai theo luong xu ly.
  State<SalesQuickActionSheet> createState() => _SalesQuickActionSheetState();
}

// Dinh nghia lop _SalesQuickActionSheetState de gom nhom logic lien quan.
class _SalesQuickActionSheetState extends State<SalesQuickActionSheet> {
  // Khai bao bien SalesQuickActionService de luu du lieu su dung trong xu ly.
  final SalesQuickActionService _salesService = getIt<SalesQuickActionService>();
  // Khai bao bien Future de luu du lieu su dung trong xu ly.
  late Future<SalesQuickActionData> _salesFuture;

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Dinh nghia ham initState de xu ly nghiep vu tuong ung.
  void initState() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.initState();
    // Gan gia tri cho bien _salesFuture.
    _salesFuture = _salesService.fetchSalesOverview();
  }

  // Khai bao bien _reload de luu du lieu su dung trong xu ly.
  Future<void> _reload() async {
    // Cap nhat state de giao dien duoc render lai.
    setState(() {
      // Gan gia tri cho bien _salesFuture.
      _salesFuture = _salesService.fetchSalesOverview();
    });
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _QuickActionSheetPalette.fromTheme(Theme.of(context));

    // Tra ve ket qua cho noi goi ham.
    return _QuickActionSheetScaffold(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      accentColor: const Color(0xFFE0A442),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      icon: Icons.receipt_long_rounded,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      title: 'Giao dịch',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      subtitle: 'Tổng quan tình hình bán hàng và giao dịch gần đây.',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      trailing: IconButton(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onPressed: _reload,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icon(Icons.refresh_rounded, color: palette.textSecondary),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        tooltip: 'Làm mới',
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: FutureBuilder<SalesQuickActionData>(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        future: _salesFuture,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        builder: (context, snapshot) {
          // Kiem tra dieu kien de re nhanh xu ly.
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Tra ve ket qua cho noi goi ham.
            return const Center(child: CircularProgressIndicator());
          }

          // Kiem tra dieu kien de re nhanh xu ly.
          if (snapshot.hasError) {
            // Tra ve ket qua cho noi goi ham.
            return _QuickActionErrorState(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              palette: palette,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              message: 'Không thể tải dữ liệu giao dịch. Vui lòng thử lại.',
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              onRetry: _reload,
            );
          }

          // Khai bao bien data de luu du lieu su dung trong xu ly.
          final data = snapshot.data;
          // Kiem tra dieu kien de re nhanh xu ly.
          if (data == null) {
            // Tra ve ket qua cho noi goi ham.
            return _QuickActionErrorState(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              palette: palette,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              message: 'Không có dữ liệu giao dịch.',
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              onRetry: _reload,
            );
          }

          // Tra ve ket qua cho noi goi ham.
          return RefreshIndicator(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onRefresh: _reload,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: palette.accent,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: ListView(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              physics: const BouncingScrollPhysics(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                parent: AlwaysScrollableScrollPhysics(),
              ),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              padding: const EdgeInsets.fromLTRB(18, 2, 18, 24),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              children: [
                // Goi ham de thuc thi tac vu can thiet.
                _buildSalesMetrics(palette, data),
                // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                const SizedBox(height: 16),
                // Goi ham de thuc thi tac vu can thiet.
                _SectionTitle(title: 'Giao dịch gần đây', palette: palette),
                // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                const SizedBox(height: 10),
                // Kiem tra dieu kien de re nhanh xu ly.
                if (data.recentSales.isEmpty)
                  // Goi ham de thuc thi tac vu can thiet.
                  _EmptySection(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    palette: palette,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    message: 'Chưa có giao dịch nào.',
                  )
                // Xu ly nhanh con lai khi dieu kien khong thoa.
                else
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  ...data.recentSales.map(
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    (sale) => Padding(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      padding: const EdgeInsets.only(bottom: 10),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      child: _SaleItemTile(palette: palette, sale: sale),
                    ),
                  ),
                // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                const SizedBox(height: 16),
                // Goi ham de thuc thi tac vu can thiet.
                _buildViewAllButton(palette, context),
              ],
            ),
          );
        },
      ),
    );
  }

  // Khai bao bien _buildSalesMetrics de luu du lieu su dung trong xu ly.
  Widget _buildSalesMetrics(
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _QuickActionSheetPalette palette,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    SalesQuickActionData data,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  ) {
    // Khai bao bien tiles de luu du lieu su dung trong xu ly.
    final tiles = [
      // Goi ham de thuc thi tac vu can thiet.
      _MetricTile(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        palette: palette,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.receipt_long_rounded,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        label: 'Tổng giao dịch',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        value: data.totalSales.toString(),
      ),
      // Goi ham de thuc thi tac vu can thiet.
      _MetricTile(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        palette: palette,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.check_circle_outline_rounded,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        label: 'Hoàn thành',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        value: data.completedSales.toString(),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        valueColor: AppColors.success,
      ),
      // Goi ham de thuc thi tac vu can thiet.
      _MetricTile(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        palette: palette,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.schedule_rounded,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        label: 'Đang chờ',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        value: data.pendingSales.toString(),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        valueColor: const Color(0xFFE0A442),
      ),
      // Goi ham de thuc thi tac vu can thiet.
      _MetricTile(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        palette: palette,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.account_balance_wallet_outlined,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        label: 'Doanh thu',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        value: data.formattedRevenue,
      ),
    ];

    // Tra ve ket qua cho noi goi ham.
    return GridView.builder(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      shrinkWrap: true,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      physics: const NeverScrollableScrollPhysics(),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      itemCount: tiles.length,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        crossAxisCount: 2,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        mainAxisSpacing: 10,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        crossAxisSpacing: 10,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        childAspectRatio: 1.28,
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      itemBuilder: (context, index) => tiles[index],
    );
  }

  // Khai bao bien _buildViewAllButton de luu du lieu su dung trong xu ly.
  Widget _buildViewAllButton(
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _QuickActionSheetPalette palette,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    BuildContext context,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  ) {
    // Tra ve ket qua cho noi goi ham.
    return SizedBox(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      width: double.infinity,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: OutlinedButton.icon(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onPressed: () {
          // Thuc thi cau lenh hien tai theo luong xu ly.
          Navigator.of(context).pop();
          // Thuc thi cau lenh hien tai theo luong xu ly.
          context.go(RouteNames.sales);
        },
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: const Icon(Icons.open_in_new_rounded, size: 18),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        label: const Text('Xem tất cả giao dịch'),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        style: OutlinedButton.styleFrom(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          padding: const EdgeInsets.symmetric(vertical: 14),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          shape: RoundedRectangleBorder(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            borderRadius: BorderRadius.circular(16),
          ),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          side: BorderSide(color: palette.border),
        ),
      ),
    );
  }
}

// Inventory Quick Action Sheet

// Dinh nghia lop InventoryQuickActionSheet de gom nhom logic lien quan.
class InventoryQuickActionSheet extends StatefulWidget {
  // Khai bao bien InventoryQuickActionSheet de luu du lieu su dung trong xu ly.
  const InventoryQuickActionSheet({super.key});

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Dinh nghia ham createState de xu ly nghiep vu tuong ung.
  State<InventoryQuickActionSheet> createState() =>
      // Khai bao constructor _InventoryQuickActionSheetState de khoi tao doi tuong.
      _InventoryQuickActionSheetState();
}

// Dinh nghia lop _InventoryQuickActionSheetState de gom nhom logic lien quan.
class _InventoryQuickActionSheetState extends State<InventoryQuickActionSheet> {
  // Khai bao bien InventoryQuickActionService de luu du lieu su dung trong xu ly.
  final InventoryQuickActionService _inventoryService =
      // Thuc thi cau lenh hien tai theo luong xu ly.
      getIt<InventoryQuickActionService>();
  // Khai bao bien Future de luu du lieu su dung trong xu ly.
  late Future<InventoryQuickActionData> _inventoryFuture;

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Dinh nghia ham initState de xu ly nghiep vu tuong ung.
  void initState() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.initState();
    // Gan gia tri cho bien _inventoryFuture.
    _inventoryFuture = _inventoryService.fetchInventoryOverview();
  }

  // Khai bao bien _reload de luu du lieu su dung trong xu ly.
  Future<void> _reload() async {
    // Cap nhat state de giao dien duoc render lai.
    setState(() {
      // Gan gia tri cho bien _inventoryFuture.
      _inventoryFuture = _inventoryService.fetchInventoryOverview();
    });
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _QuickActionSheetPalette.fromTheme(Theme.of(context));

    // Tra ve ket qua cho noi goi ham.
    return _QuickActionSheetScaffold(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      accentColor: const Color(0xFF4E83F5),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      icon: Icons.inventory_2_outlined,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      title: 'Kho hàng',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      subtitle: 'Tổng quan kho xe và tình trạng từng xe.',
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      trailing: IconButton(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        onPressed: _reload,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icon(Icons.refresh_rounded, color: palette.textSecondary),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        tooltip: 'Làm mới',
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: FutureBuilder<InventoryQuickActionData>(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        future: _inventoryFuture,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        builder: (context, snapshot) {
          // Kiem tra dieu kien de re nhanh xu ly.
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Tra ve ket qua cho noi goi ham.
            return const Center(child: CircularProgressIndicator());
          }

          // Kiem tra dieu kien de re nhanh xu ly.
          if (snapshot.hasError) {
            // Tra ve ket qua cho noi goi ham.
            return _QuickActionErrorState(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              palette: palette,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              message: 'Không thể tải dữ liệu kho. Vui lòng thử lại.',
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              onRetry: _reload,
            );
          }

          // Khai bao bien data de luu du lieu su dung trong xu ly.
          final data = snapshot.data;
          // Kiem tra dieu kien de re nhanh xu ly.
          if (data == null) {
            // Tra ve ket qua cho noi goi ham.
            return _QuickActionErrorState(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              palette: palette,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              message: 'Không có dữ liệu kho hàng.',
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              onRetry: _reload,
            );
          }

          // Tra ve ket qua cho noi goi ham.
          return RefreshIndicator(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onRefresh: _reload,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: palette.accent,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: ListView(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              physics: const BouncingScrollPhysics(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                parent: AlwaysScrollableScrollPhysics(),
              ),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              padding: const EdgeInsets.fromLTRB(18, 2, 18, 24),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              children: [
                // Goi ham de thuc thi tac vu can thiet.
                _buildInventoryMetrics(palette, data),
                // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                const SizedBox(height: 16),
                // Goi ham de thuc thi tac vu can thiet.
                _SectionTitle(title: 'Danh sách xe', palette: palette),
                // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                const SizedBox(height: 10),
                // Kiem tra dieu kien de re nhanh xu ly.
                if (data.recentCars.isEmpty)
                  // Goi ham de thuc thi tac vu can thiet.
                  _EmptySection(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    palette: palette,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    message: 'Chưa có xe nào trong kho.',
                  )
                // Xu ly nhanh con lai khi dieu kien khong thoa.
                else
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  ...data.recentCars.map(
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    (car) => Padding(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      padding: const EdgeInsets.only(bottom: 10),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      child: _InventoryCarTile(palette: palette, car: car),
                    ),
                  ),
                // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                const SizedBox(height: 16),
                // Goi ham de thuc thi tac vu can thiet.
                _buildInventoryActions(palette, context),
              ],
            ),
          );
        },
      ),
    );
  }

  // Khai bao bien _buildInventoryMetrics de luu du lieu su dung trong xu ly.
  Widget _buildInventoryMetrics(
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _QuickActionSheetPalette palette,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    InventoryQuickActionData data,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  ) {
    // Khai bao bien tiles de luu du lieu su dung trong xu ly.
    final tiles = [
      // Goi ham de thuc thi tac vu can thiet.
      _MetricTile(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        palette: palette,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.directions_car_filled_outlined,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        label: 'Tổng xe',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        value: data.totalCars.toString(),
      ),
      // Goi ham de thuc thi tac vu can thiet.
      _MetricTile(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        palette: palette,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.check_circle_outline_rounded,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        label: 'Sẵn bán',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        value: data.availableCars.toString(),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        valueColor: AppColors.success,
      ),
      // Goi ham de thuc thi tac vu can thiet.
      _MetricTile(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        palette: palette,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.sell_outlined,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        label: 'Đã bán',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        value: data.soldCars.toString(),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        valueColor: const Color(0xFFE0A442),
      ),
      // Goi ham de thuc thi tac vu can thiet.
      _MetricTile(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        palette: palette,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.bookmark_outline_rounded,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        label: 'Đã đặt',
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        value: data.reservedCars.toString(),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        valueColor: const Color(0xFF4E83F5),
      ),
    ];

    // Tra ve ket qua cho noi goi ham.
    return GridView.builder(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      shrinkWrap: true,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      physics: const NeverScrollableScrollPhysics(),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      itemCount: tiles.length,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        crossAxisCount: 2,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        mainAxisSpacing: 10,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        crossAxisSpacing: 10,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        childAspectRatio: 1.28,
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      itemBuilder: (context, index) => tiles[index],
    );
  }

  // Khai bao bien _buildInventoryActions de luu du lieu su dung trong xu ly.
  Widget _buildInventoryActions(
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _QuickActionSheetPalette palette,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    BuildContext context,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  ) {
    // Tra ve ket qua cho noi goi ham.
    return Column(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      children: [
        // Goi ham de thuc thi tac vu can thiet.
        SizedBox(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          width: double.infinity,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: FilledButton.icon(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onPressed: () {
              // Thuc thi cau lenh hien tai theo luong xu ly.
              Navigator.of(context).pop();
              // Thuc thi cau lenh hien tai theo luong xu ly.
              context.push(RouteNames.addCar);
            },
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            icon: const Icon(Icons.add_rounded, size: 20),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            label: const Text('Thêm xe mới'),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            style: FilledButton.styleFrom(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              padding: const EdgeInsets.symmetric(vertical: 14),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              shape: RoundedRectangleBorder(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
        // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
        const SizedBox(height: 10),
        // Goi ham de thuc thi tac vu can thiet.
        SizedBox(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          width: double.infinity,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: OutlinedButton.icon(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onPressed: () {
              // Thuc thi cau lenh hien tai theo luong xu ly.
              Navigator.of(context).pop();
              // Thuc thi cau lenh hien tai theo luong xu ly.
              context.go(RouteNames.carList);
            },
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            icon: const Icon(Icons.open_in_new_rounded, size: 18),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            label: const Text('Xem toàn bộ kho'),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            style: OutlinedButton.styleFrom(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              padding: const EdgeInsets.symmetric(vertical: 14),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              shape: RoundedRectangleBorder(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                borderRadius: BorderRadius.circular(16),
              ),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              side: BorderSide(color: palette.border),
            ),
          ),
        ),
      ],
    );
  }
}

// Shared Scaffold & Palette

// Dinh nghia lop _QuickActionSheetScaffold de gom nhom logic lien quan.
class _QuickActionSheetScaffold extends StatelessWidget {
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color accentColor;
  // Khai bao bien IconData de luu du lieu su dung trong xu ly.
  final IconData icon;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String title;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String subtitle;
  // Khai bao bien Widget de luu du lieu su dung trong xu ly.
  final Widget child;
  // Khai bao bien Widget de luu du lieu su dung trong xu ly.
  final Widget? trailing;

  // Khai bao bien _QuickActionSheetScaffold de luu du lieu su dung trong xu ly.
  const _QuickActionSheetScaffold({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.accentColor,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.icon,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.title,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.subtitle,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.child,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.trailing,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _QuickActionSheetPalette.fromTheme(Theme.of(context));
    // Khai bao bien topBackgroundTint de luu du lieu su dung trong xu ly.
    final topBackgroundTint = Color.lerp(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      palette.background,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      accentColor,
      // Thuc thi cau lenh hien tai theo luong xu ly.
      palette.isDark ? 0.18 : 0.09,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    )!;

    // Tra ve ket qua cho noi goi ham.
    return SafeArea(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      top: false,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: AnimatedPadding(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        duration: const Duration(milliseconds: 180),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: Container(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          height: MediaQuery.sizeOf(context).height * 0.9,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          decoration: BoxDecoration(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: palette.background,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            gradient: LinearGradient(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              begin: Alignment.topCenter,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              end: Alignment.bottomCenter,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              colors: [
                // Thuc thi cau lenh hien tai theo luong xu ly.
                topBackgroundTint,
                // Thuc thi cau lenh hien tai theo luong xu ly.
                palette.background,
              ],
            ),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            boxShadow: [
              // Goi ham de thuc thi tac vu can thiet.
              BoxShadow(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                color: palette.shadow,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                blurRadius: 30,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                offset: const Offset(0, -4),
              ),
            ],
          ),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Column(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 10),
              // Goi ham de thuc thi tac vu can thiet.
              Container(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                width: 44,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                height: 5,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                decoration: BoxDecoration(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: palette.border,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              // Goi ham de thuc thi tac vu can thiet.
              Padding(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                padding: const EdgeInsets.fromLTRB(18, 14, 14, 12),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: Row(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  children: [
                    // Goi ham de thuc thi tac vu can thiet.
                    Container(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      padding: const EdgeInsets.all(12),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      decoration: BoxDecoration(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        color: accentColor.withValues(alpha: 0.12),
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        borderRadius: BorderRadius.circular(18),
                      ),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      child: Icon(icon, color: accentColor, size: 24),
                    ),
                    // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                    const SizedBox(width: 14),
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
                            style: AppTextStyles.titleLarge.copyWith(
                              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                              color: palette.textPrimary,
                              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                          const SizedBox(height: 3),
                          // Goi ham de thuc thi tac vu can thiet.
                          Text(
                            // Thuc thi cau lenh hien tai theo luong xu ly.
                            subtitle,
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            style: AppTextStyles.bodySmall.copyWith(
                              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                              color: palette.textSecondary,
                              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    ?trailing,
                  ],
                ),
              ),
              // Goi ham de thuc thi tac vu can thiet.
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}

// Dinh nghia lop _QuickActionSheetPalette de gom nhom logic lien quan.
class _QuickActionSheetPalette {
  // Khai bao bien bool de luu du lieu su dung trong xu ly.
  final bool isDark;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color background;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color surface;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color border;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color textPrimary;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color textSecondary;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color accent;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color accentSoft;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color progressBackground;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color inputFill;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color shadow;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color onAccent;

  // Khai bao bien _QuickActionSheetPalette de luu du lieu su dung trong xu ly.
  const _QuickActionSheetPalette({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.isDark,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.background,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.surface,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.border,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.textPrimary,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.textSecondary,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.accent,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.accentSoft,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.progressBackground,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.inputFill,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.shadow,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.onAccent,
  });

  // Thuc thi cau lenh hien tai theo luong xu ly.
  factory _QuickActionSheetPalette.fromTheme(ThemeData theme) {
    // Khai bao bien isDark de luu du lieu su dung trong xu ly.
    final isDark = theme.brightness == Brightness.dark;
    // Khai bao bien onSurface de luu du lieu su dung trong xu ly.
    final onSurface = theme.colorScheme.onSurface;
    // Khai bao bien accent de luu du lieu su dung trong xu ly.
    final accent = theme.colorScheme.primary;

    // Tra ve ket qua cho noi goi ham.
    return _QuickActionSheetPalette(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      isDark: isDark,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      background: theme.colorScheme.surface,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      surface: isDark ? const Color(0xFF1A1D22) : Colors.white,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      border: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? Colors.white.withValues(alpha: 0.07)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : Colors.black.withValues(alpha: 0.08),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      textPrimary: onSurface,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      textSecondary: onSurface.withValues(alpha: isDark ? 0.70 : 0.64),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      accent: accent,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      accentSoft: accent.withValues(alpha: 0.12),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      progressBackground: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? Colors.white.withValues(alpha: 0.10)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : Colors.black.withValues(alpha: 0.08),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      inputFill: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? Colors.white.withValues(alpha: 0.04)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : Colors.black.withValues(alpha: 0.03),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      shadow: Colors.black.withValues(alpha: isDark ? 0.22 : 0.08),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      onAccent: theme.colorScheme.onPrimary,
    );
  }
}

// Shared Tiles & Widgets

// Dinh nghia lop _MetricTile de gom nhom logic lien quan.
class _MetricTile extends StatelessWidget {
  // Khai bao bien _QuickActionSheetPalette de luu du lieu su dung trong xu ly.
  final _QuickActionSheetPalette palette;
  // Khai bao bien IconData de luu du lieu su dung trong xu ly.
  final IconData icon;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String label;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String value;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color? valueColor;

  // Khai bao bien _MetricTile de luu du lieu su dung trong xu ly.
  const _MetricTile({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.palette,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.icon,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.label,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.value,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    this.valueColor,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: const EdgeInsets.all(14),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.surface,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(20),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: Border.all(color: palette.border),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Column(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        crossAxisAlignment: CrossAxisAlignment.start,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: [
          // Goi ham de thuc thi tac vu can thiet.
          Container(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            padding: const EdgeInsets.all(9),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            decoration: BoxDecoration(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: palette.accentSoft,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              borderRadius: BorderRadius.circular(13),
            ),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Icon(icon, color: palette.accent, size: 17),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          Column(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            crossAxisAlignment: CrossAxisAlignment.start,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Goi ham de thuc thi tac vu can thiet.
              Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                label.toUpperCase(),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                maxLines: 1,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                overflow: TextOverflow.ellipsis,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: AppTextStyles.labelSmall.copyWith(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: palette.textSecondary,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  letterSpacing: 0.9,
                ),
              ),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 4),
              // Goi ham de thuc thi tac vu can thiet.
              Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                value,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                maxLines: 1,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                overflow: TextOverflow.ellipsis,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: AppTextStyles.titleLarge.copyWith(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: valueColor ?? palette.textPrimary,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Dinh nghia lop _RecentTransactionTile de gom nhom logic lien quan.
class _RecentTransactionTile extends StatelessWidget {
  // Khai bao bien _QuickActionSheetPalette de luu du lieu su dung trong xu ly.
  final _QuickActionSheetPalette palette;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String customerName;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String carName;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String amount;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String timeAgo;

  // Khai bao bien _RecentTransactionTile de luu du lieu su dung trong xu ly.
  const _RecentTransactionTile({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.palette,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.customerName,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.carName,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.amount,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.timeAgo,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien initials de luu du lieu su dung trong xu ly.
    final initials = customerName.isNotEmpty
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ? customerName.characters.first.toUpperCase()
        // Thuc thi cau lenh hien tai theo luong xu ly.
        : '?';

    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: const EdgeInsets.all(14),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.surface,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(18),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: Border.all(color: palette.border),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Row(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: [
          // Goi ham de thuc thi tac vu can thiet.
          CircleAvatar(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            radius: 18,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            backgroundColor: palette.accent,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Text(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              initials,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              style: AppTextStyles.labelLarge.copyWith(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                color: palette.onAccent,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
          const SizedBox(width: 12),
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
                  customerName,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  maxLines: 1,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  overflow: TextOverflow.ellipsis,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: AppTextStyles.titleSmall.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: palette.textPrimary,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontWeight: FontWeight.w700,
                  ),
                ),
                // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                const SizedBox(height: 2),
                // Goi ham de thuc thi tac vu can thiet.
                Text(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  carName,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  maxLines: 1,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  overflow: TextOverflow.ellipsis,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: AppTextStyles.bodySmall.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: palette.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
          const SizedBox(width: 8),
          // Goi ham de thuc thi tac vu can thiet.
          Column(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            crossAxisAlignment: CrossAxisAlignment.end,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Goi ham de thuc thi tac vu can thiet.
              Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                amount,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: AppTextStyles.titleSmall.copyWith(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: AppColors.success,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontWeight: FontWeight.w800,
                ),
              ),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 2),
              // Goi ham de thuc thi tac vu can thiet.
              Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                timeAgo,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: AppTextStyles.labelSmall.copyWith(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: palette.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Dinh nghia lop _SuggestionTile de gom nhom logic lien quan.
class _SuggestionTile extends StatelessWidget {
  // Khai bao bien _QuickActionSheetPalette de luu du lieu su dung trong xu ly.
  final _QuickActionSheetPalette palette;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String suggestion;

  // Khai bao bien _SuggestionTile de luu du lieu su dung trong xu ly.
  const _SuggestionTile({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.palette,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.suggestion,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: const EdgeInsets.all(14),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.surface,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(18),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: Border.all(color: palette.border),
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
            margin: const EdgeInsets.only(top: 2),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            width: 8,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            height: 8,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            decoration: BoxDecoration(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: palette.accent,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
          const SizedBox(width: 12),
          // Goi ham de thuc thi tac vu can thiet.
          Expanded(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Text(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              suggestion,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              style: AppTextStyles.bodyMedium.copyWith(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                color: palette.textPrimary,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Dinh nghia lop _SupportItemTile de gom nhom logic lien quan.
class _SupportItemTile extends StatelessWidget {
  // Khai bao bien _QuickActionSheetPalette de luu du lieu su dung trong xu ly.
  final _QuickActionSheetPalette palette;
  // Khai bao bien SupportItemModel de luu du lieu su dung trong xu ly.
  final SupportItemModel item;

  // Khai bao bien _SupportItemTile de luu du lieu su dung trong xu ly.
  const _SupportItemTile({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.palette,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.item,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien accentColor de luu du lieu su dung trong xu ly.
    final accentColor = _supportAccent(item.type);
    // Khai bao bien icon de luu du lieu su dung trong xu ly.
    final icon = _supportIcon(item.type);

    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: const EdgeInsets.all(14),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.surface,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(20),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: Border.all(color: palette.border),
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
            padding: const EdgeInsets.all(10),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            decoration: BoxDecoration(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: accentColor.withValues(alpha: 0.12),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              borderRadius: BorderRadius.circular(14),
            ),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Icon(icon, color: accentColor, size: 20),
          ),
          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
          const SizedBox(width: 12),
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
                  item.title,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: AppTextStyles.titleSmall.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: palette.textPrimary,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontWeight: FontWeight.w800,
                  ),
                ),
                // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                const SizedBox(height: 3),
                // Goi ham de thuc thi tac vu can thiet.
                Text(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  item.description,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: AppTextStyles.bodySmall.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: palette.textSecondary,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Dinh nghia ham _supportIcon de xu ly nghiep vu tuong ung.
  IconData _supportIcon(String type) {
    // Bat dau re nhanh theo nhieu truong hop gia tri.
    switch (type.toLowerCase()) {
      // Xu ly mot truong hop cu the trong switch.
      case 'support_center':
        // Tra ve ket qua cho noi goi ham.
        return Icons.help_outline_rounded;
      // Xu ly mot truong hop cu the trong switch.
      case 'contact':
        // Tra ve ket qua cho noi goi ham.
        return Icons.support_agent_rounded;
      // Xu ly mot truong hop cu the trong switch.
      case 'about':
        // Tra ve ket qua cho noi goi ham.
        return Icons.info_outline_rounded;
      // Xu ly mac dinh khi khong khop case nao.
      default:
        // Tra ve ket qua cho noi goi ham.
        return Icons.headset_mic_outlined;
    }
  }

  // Khai bao bien _supportAccent de luu du lieu su dung trong xu ly.
  Color _supportAccent(String type) {
    // Bat dau re nhanh theo nhieu truong hop gia tri.
    switch (type.toLowerCase()) {
      // Xu ly mot truong hop cu the trong switch.
      case 'support_center':
        // Tra ve ket qua cho noi goi ham.
        return const Color(0xFF4E83F5);
      // Xu ly mot truong hop cu the trong switch.
      case 'contact':
        // Tra ve ket qua cho noi goi ham.
        return const Color(0xFFE57E6D);
      // Xu ly mot truong hop cu the trong switch.
      case 'about':
        // Tra ve ket qua cho noi goi ham.
        return const Color(0xFF2FA58A);
      // Xu ly mac dinh khi khong khop case nao.
      default:
        // Tra ve ket qua cho noi goi ham.
        return palette.accent;
    }
  }
}

// Dinh nghia lop _MyRequestTile de gom nhom logic lien quan.
class _MyRequestTile extends StatelessWidget {
  // Khai bao bien _QuickActionSheetPalette de luu du lieu su dung trong xu ly.
  final _QuickActionSheetPalette palette;
  // Khai bao bien SupportContactSubmissionModel de luu du lieu su dung trong xu ly.
  final SupportContactSubmissionModel request;

  // Khai bao bien _MyRequestTile de luu du lieu su dung trong xu ly.
  const _MyRequestTile({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.palette,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.request,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien statusColor de luu du lieu su dung trong xu ly.
    final statusColor = _statusColor(request.status);
    // Khai bao bien statusLabel de luu du lieu su dung trong xu ly.
    final statusLabel = _statusLabel(request.status);

    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: const EdgeInsets.all(14),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.surface,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(18),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: Border.all(color: palette.border),
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
            padding: const EdgeInsets.all(10),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            decoration: BoxDecoration(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: statusColor.withValues(alpha: 0.12),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              borderRadius: BorderRadius.circular(14),
            ),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Icon(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              Icons.mail_outline_rounded,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: statusColor,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              size: 20,
            ),
          ),
          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
          const SizedBox(width: 12),
          // Goi ham de thuc thi tac vu can thiet.
          Expanded(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Column(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              crossAxisAlignment: CrossAxisAlignment.start,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              children: [
                // Goi ham de thuc thi tac vu can thiet.
                Row(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  children: [
                    // Goi ham de thuc thi tac vu can thiet.
                    Expanded(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      child: Text(
                        // Thuc thi cau lenh hien tai theo luong xu ly.
                        request.message,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        maxLines: 2,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        overflow: TextOverflow.ellipsis,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        style: AppTextStyles.titleSmall.copyWith(
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          color: palette.textPrimary,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                    const SizedBox(width: 8),
                    // Goi ham de thuc thi tac vu can thiet.
                    Container(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      padding: const EdgeInsets.symmetric(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        horizontal: 8,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        vertical: 3,
                      ),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      decoration: BoxDecoration(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        color: statusColor.withValues(alpha: 0.12),
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        borderRadius: BorderRadius.circular(8),
                      ),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      child: Text(
                        // Thuc thi cau lenh hien tai theo luong xu ly.
                        statusLabel,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        style: AppTextStyles.labelSmall.copyWith(
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          color: statusColor,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                const SizedBox(height: 4),
                // Goi ham de thuc thi tac vu can thiet.
                Text(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  request.createdAt != null
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      ? _formatDate(request.createdAt!)
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      : '',
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: AppTextStyles.labelSmall.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: palette.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Khai bao bien _statusColor de luu du lieu su dung trong xu ly.
  Color _statusColor(String status) {
    // Bat dau re nhanh theo nhieu truong hop gia tri.
    switch (status) {
      // Xu ly mot truong hop cu the trong switch.
      case 'pending':
        // Tra ve ket qua cho noi goi ham.
        return const Color(0xFFE0A442);
      // Xu ly mot truong hop cu the trong switch.
      case 'resolved':
        // Tra ve ket qua cho noi goi ham.
        return AppColors.success;
      // Xu ly mot truong hop cu the trong switch.
      case 'rejected':
        // Tra ve ket qua cho noi goi ham.
        return AppColors.error;
      // Xu ly mac dinh khi khong khop case nao.
      default:
        // Tra ve ket qua cho noi goi ham.
        return palette.accent;
    }
  }

  // Khai bao bien _statusLabel de luu du lieu su dung trong xu ly.
  String _statusLabel(String status) {
    // Bat dau re nhanh theo nhieu truong hop gia tri.
    switch (status) {
      // Xu ly mot truong hop cu the trong switch.
      case 'pending':
        // Tra ve ket qua cho noi goi ham.
        return 'Đang chờ';
      // Xu ly mot truong hop cu the trong switch.
      case 'resolved':
        // Tra ve ket qua cho noi goi ham.
        return 'Đã xử lý';
      // Xu ly mot truong hop cu the trong switch.
      case 'rejected':
        // Tra ve ket qua cho noi goi ham.
        return 'Từ chối';
      // Xu ly mac dinh khi khong khop case nao.
      default:
        // Tra ve ket qua cho noi goi ham.
        return status;
    }
  }

  // Khai bao bien _formatDate de luu du lieu su dung trong xu ly.
  String _formatDate(DateTime date) {
    // Khai bao bien now de luu du lieu su dung trong xu ly.
    final now = DateTime.now();
    // Khai bao bien diff de luu du lieu su dung trong xu ly.
    final diff = now.difference(date);
    // Kiem tra dieu kien de re nhanh xu ly.
    if (diff.inMinutes < 60) {
      // Tra ve ket qua cho noi goi ham.
      return '${diff.inMinutes} phút trước';
    }
    // Kiem tra dieu kien de re nhanh xu ly.
    if (diff.inHours < 24) {
      // Tra ve ket qua cho noi goi ham.
      return '${diff.inHours} giờ trước';
    }
    // Kiem tra dieu kien de re nhanh xu ly.
    if (diff.inDays < 7) {
      // Tra ve ket qua cho noi goi ham.
      return '${diff.inDays} ngày trước';
    }
    // Tra ve ket qua cho noi goi ham.
    return '${date.day}/${date.month}/${date.year}';
  }
}

// Dinh nghia lop _SaleItemTile de gom nhom logic lien quan.
class _SaleItemTile extends StatelessWidget {
  // Khai bao bien _QuickActionSheetPalette de luu du lieu su dung trong xu ly.
  final _QuickActionSheetPalette palette;
  // Khai bao bien SaleOverviewItem de luu du lieu su dung trong xu ly.
  final SaleOverviewItem sale;

  // Khai bao bien _SaleItemTile de luu du lieu su dung trong xu ly.
  const _SaleItemTile({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.palette,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.sale,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien statusColor de luu du lieu su dung trong xu ly.
    final statusColor = sale.status == 'completed'
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ? AppColors.success
        // Thuc thi cau lenh hien tai theo luong xu ly.
        : const Color(0xFFE0A442);
    // Khai bao bien initials de luu du lieu su dung trong xu ly.
    final initials = sale.customerName.isNotEmpty
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ? sale.customerName.characters.first.toUpperCase()
        // Thuc thi cau lenh hien tai theo luong xu ly.
        : '?';

    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: const EdgeInsets.all(14),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.surface,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(18),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: Border.all(color: palette.border),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Row(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: [
          // Goi ham de thuc thi tac vu can thiet.
          CircleAvatar(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            radius: 18,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            backgroundColor: statusColor.withValues(alpha: 0.15),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Text(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              initials,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              style: AppTextStyles.labelLarge.copyWith(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                color: statusColor,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
          const SizedBox(width: 12),
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
                  sale.customerName,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  maxLines: 1,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  overflow: TextOverflow.ellipsis,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: AppTextStyles.titleSmall.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: palette.textPrimary,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontWeight: FontWeight.w700,
                  ),
                ),
                // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                const SizedBox(height: 2),
                // Goi ham de thuc thi tac vu can thiet.
                Text(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  sale.carName,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  maxLines: 1,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  overflow: TextOverflow.ellipsis,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: AppTextStyles.bodySmall.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: palette.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
          const SizedBox(width: 8),
          // Goi ham de thuc thi tac vu can thiet.
          Column(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            crossAxisAlignment: CrossAxisAlignment.end,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Goi ham de thuc thi tac vu can thiet.
              Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                sale.formattedPrice,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: AppTextStyles.titleSmall.copyWith(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: statusColor,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontWeight: FontWeight.w800,
                ),
              ),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 2),
              // Goi ham de thuc thi tac vu can thiet.
              Container(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                decoration: BoxDecoration(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: statusColor.withValues(alpha: 0.12),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  borderRadius: BorderRadius.circular(6),
                ),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: Text(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  sale.statusLabel,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: AppTextStyles.labelSmall.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: statusColor,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontWeight: FontWeight.w700,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Dinh nghia lop _InventoryCarTile de gom nhom logic lien quan.
class _InventoryCarTile extends StatelessWidget {
  // Khai bao bien _QuickActionSheetPalette de luu du lieu su dung trong xu ly.
  final _QuickActionSheetPalette palette;
  // Khai bao bien InventoryCarItem de luu du lieu su dung trong xu ly.
  final InventoryCarItem car;

  // Khai bao bien _InventoryCarTile de luu du lieu su dung trong xu ly.
  const _InventoryCarTile({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.palette,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.car,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien statusColor de luu du lieu su dung trong xu ly.
    final statusColor = _carStatusColor(car.status);

    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: const EdgeInsets.all(14),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.surface,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(18),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: Border.all(color: palette.border),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Row(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: [
          // Goi ham de thuc thi tac vu can thiet.
          Container(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            width: 44,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            height: 44,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            decoration: BoxDecoration(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: statusColor.withValues(alpha: 0.12),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              borderRadius: BorderRadius.circular(14),
            ),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: Icon(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              Icons.directions_car_filled_outlined,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: statusColor,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              size: 22,
            ),
          ),
          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
          const SizedBox(width: 12),
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
                  car.name,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  maxLines: 1,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  overflow: TextOverflow.ellipsis,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: AppTextStyles.titleSmall.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: palette.textPrimary,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontWeight: FontWeight.w700,
                  ),
                ),
                // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                const SizedBox(height: 2),
                // Goi ham de thuc thi tac vu can thiet.
                Text(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  '${car.brand} • ${car.color} • ${car.year}',
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  maxLines: 1,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  overflow: TextOverflow.ellipsis,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: AppTextStyles.bodySmall.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: palette.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
          const SizedBox(width: 8),
          // Goi ham de thuc thi tac vu can thiet.
          Column(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            crossAxisAlignment: CrossAxisAlignment.end,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Goi ham de thuc thi tac vu can thiet.
              Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                car.formattedPrice,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: AppTextStyles.titleSmall.copyWith(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: palette.textPrimary,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontWeight: FontWeight.w800,
                ),
              ),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 2),
              // Goi ham de thuc thi tac vu can thiet.
              Container(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                decoration: BoxDecoration(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: statusColor.withValues(alpha: 0.12),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  borderRadius: BorderRadius.circular(6),
                ),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: Text(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  car.statusLabel,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: AppTextStyles.labelSmall.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: statusColor,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontWeight: FontWeight.w700,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Khai bao bien _carStatusColor de luu du lieu su dung trong xu ly.
  Color _carStatusColor(String status) {
    // Bat dau re nhanh theo nhieu truong hop gia tri.
    switch (status) {
      // Xu ly mot truong hop cu the trong switch.
      case 'available':
        // Tra ve ket qua cho noi goi ham.
        return AppColors.success;
      // Xu ly mot truong hop cu the trong switch.
      case 'sold':
        // Tra ve ket qua cho noi goi ham.
        return const Color(0xFFE0A442);
      // Xu ly mot truong hop cu the trong switch.
      case 'reserved':
        // Tra ve ket qua cho noi goi ham.
        return const Color(0xFF4E83F5);
      // Xu ly mac dinh khi khong khop case nao.
      default:
        // Tra ve ket qua cho noi goi ham.
        return palette.accent;
    }
  }
}

// Dinh nghia lop _SectionTitle de gom nhom logic lien quan.
class _SectionTitle extends StatelessWidget {
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String title;
  // Khai bao bien _QuickActionSheetPalette de luu du lieu su dung trong xu ly.
  final _QuickActionSheetPalette palette;

  // Khai bao bien _SectionTitle de luu du lieu su dung trong xu ly.
  const _SectionTitle({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.title,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.palette,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Tra ve ket qua cho noi goi ham.
    return Text(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      title,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      style: AppTextStyles.titleMedium.copyWith(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.textPrimary,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

// Dinh nghia lop _EmptySection de gom nhom logic lien quan.
class _EmptySection extends StatelessWidget {
  // Khai bao bien _QuickActionSheetPalette de luu du lieu su dung trong xu ly.
  final _QuickActionSheetPalette palette;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String message;

  // Khai bao bien _EmptySection de luu du lieu su dung trong xu ly.
  const _EmptySection({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.palette,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.message,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      width: double.infinity,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: const EdgeInsets.all(16),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.surface,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(18),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: Border.all(color: palette.border),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Text(
        // Thuc thi cau lenh hien tai theo luong xu ly.
        message,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        style: AppTextStyles.bodyMedium.copyWith(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          color: palette.textSecondary,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          height: 1.35,
        ),
      ),
    );
  }
}

// Dinh nghia lop _QuickActionErrorState de gom nhom logic lien quan.
class _QuickActionErrorState extends StatelessWidget {
  // Khai bao bien _QuickActionSheetPalette de luu du lieu su dung trong xu ly.
  final _QuickActionSheetPalette palette;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String message;
  // Khai bao bien Future de luu du lieu su dung trong xu ly.
  final Future<void> Function() onRetry;

  // Khai bao bien _QuickActionErrorState de luu du lieu su dung trong xu ly.
  const _QuickActionErrorState({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.palette,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.message,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.onRetry,
  });

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Tra ve ket qua cho noi goi ham.
    return Center(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Padding(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        padding: const EdgeInsets.all(16),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: Column(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          mainAxisSize: MainAxisSize.min,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          children: [
            // Goi ham de thuc thi tac vu can thiet.
            Icon(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              Icons.error_outline_rounded,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              size: 38,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: AppColors.error.withValues(alpha: 0.9),
            ),
            // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
            const SizedBox(height: 10),
            // Goi ham de thuc thi tac vu can thiet.
            Text(
              // Thuc thi cau lenh hien tai theo luong xu ly.
              message,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              textAlign: TextAlign.center,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              style: AppTextStyles.bodyMedium.copyWith(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                color: palette.textSecondary,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                height: 1.35,
              ),
            ),
            // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
            const SizedBox(height: 12),
            // Thuc thi cau lenh hien tai theo luong xu ly.
            OutlinedButton.icon(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              onPressed: onRetry,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              icon: const Icon(Icons.refresh_rounded),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              label: const Text('Thử lại'),
            ),
          ],
        ),
      ),
    );
  }
}
