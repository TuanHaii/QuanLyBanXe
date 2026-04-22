import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/constants/app_constants.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/themes/app_colors.dart';
import '../models/dashboard_summary_model.dart';
import '../models/inventory_quick_action_models.dart';
import '../models/quick_action_models.dart';
import '../models/sales_quick_action_models.dart';
import '../services/inventory_quick_action_service.dart';
import '../services/report_service.dart';
import '../services/sales_quick_action_service.dart';
import '../services/support_service.dart';

// ─────────────────────────────────────────────────────────────
// Report Quick Action Sheet
// ─────────────────────────────────────────────────────────────

class ReportQuickActionSheet extends StatefulWidget {
  const ReportQuickActionSheet({super.key});

  @override
  State<ReportQuickActionSheet> createState() => _ReportQuickActionSheetState();
}

class _ReportQuickActionSheetState extends State<ReportQuickActionSheet> {
  final ReportService _reportService = getIt<ReportService>();
  late Future<ReportQuickActionData> _reportFuture;

  @override
  void initState() {
    super.initState();
    _reportFuture = _reportService.fetchReportOverview();
  }

  Future<void> _reload() async {
    setState(() {
      _reportFuture = _reportService.fetchReportOverview();
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = _QuickActionSheetPalette.fromTheme(Theme.of(context));

    return _QuickActionSheetScaffold(
      accentColor: const Color(0xFF5F86D9),
      icon: Icons.pie_chart_outline_rounded,
      title: 'Báo cáo nhanh',
      subtitle: 'Tổng quan doanh thu, mục tiêu và giao dịch mới nhất.',
      trailing: IconButton(
        onPressed: _reload,
        icon: Icon(Icons.refresh_rounded, color: palette.textSecondary),
        tooltip: 'Làm mới',
      ),
      child: FutureBuilder<ReportQuickActionData>(
        future: _reportFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return _QuickActionErrorState(
              palette: palette,
              message: 'Không thể tải báo cáo. Vui lòng thử lại.',
              onRetry: _reload,
            );
          }

          final data = snapshot.data;
          if (data == null) {
            return _QuickActionErrorState(
              palette: palette,
              message: 'Không có dữ liệu báo cáo.',
              onRetry: _reload,
            );
          }

          return RefreshIndicator(
            onRefresh: _reload,
            color: palette.accent,
            child: ListView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.fromLTRB(18, 2, 18, 24),
              children: [
                _buildOverviewGrid(context, palette, data.summary),
                const SizedBox(height: 16),
                _buildGoalCard(context, palette, data.goals),
                const SizedBox(height: 16),
                _SectionTitle(title: 'Giao dịch gần đây', palette: palette),
                const SizedBox(height: 10),
                if (data.summary.recentTransactions.isEmpty)
                  _EmptySection(
                    palette: palette,
                    message: 'Chưa có giao dịch nào để hiển thị.',
                  )
                else
                  ...data.summary.recentTransactions.map(
                    (transaction) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _RecentTransactionTile(
                        palette: palette,
                        customerName: transaction.customerName,
                        carName: transaction.carName,
                        amount: transaction.amount,
                        timeAgo: transaction.timeAgo,
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                _SectionTitle(title: 'Gợi ý cải thiện', palette: palette),
                const SizedBox(height: 10),
                if (data.goals.suggestions.isEmpty)
                  _EmptySection(
                    palette: palette,
                    message: 'Chưa có đề xuất mới từ hệ thống.',
                  )
                else
                  ...data.goals.suggestions.map(
                    (suggestion) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _SuggestionTile(
                        palette: palette,
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

  Widget _buildOverviewGrid(
    BuildContext context,
    _QuickActionSheetPalette palette,
    DashboardSummaryModel summary,
  ) {
    final tiles = [
      _MetricTile(
        palette: palette,
        icon: Icons.directions_car_filled_outlined,
        label: 'Tổng xe',
        value: summary.totalCars.toString(),
      ),
      _MetricTile(
        palette: palette,
        icon: Icons.sell_outlined,
        label: 'Xe đã bán',
        value: summary.carsSold.toString(),
      ),
      _MetricTile(
        palette: palette,
        icon: Icons.inventory_2_outlined,
        label: 'Trong kho',
        value: summary.inStock.toString(),
      ),
      _MetricTile(
        palette: palette,
        icon: Icons.account_balance_wallet_outlined,
        label: 'Doanh thu',
        value: summary.totalRevenueLabel,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tiles.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.28,
      ),
      itemBuilder: (context, index) => tiles[index],
    );
  }

  Widget _buildGoalCard(
    BuildContext context,
    _QuickActionSheetPalette palette,
    ReportGoalsModel goals,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: palette.border),
        boxShadow: [
          BoxShadow(
            color: palette.shadow,
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: palette.accentSoft,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.rocket_launch_outlined,
                  size: 18,
                  color: palette.accent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mục tiêu tháng',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: palette.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      goals.progressText,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: palette.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                goals.achievedRate,
                style: AppTextStyles.titleMedium.copyWith(
                  color: palette.accent,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              minHeight: 10,
              value: goals.progressValue,
              backgroundColor: palette.progressBackground,
              color: palette.accent,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mục tiêu doanh thu',
                style: AppTextStyles.labelLarge.copyWith(
                  color: palette.textSecondary,
                ),
              ),
              Text(
                goals.revenueTarget,
                style: AppTextStyles.titleSmall.copyWith(
                  color: palette.textPrimary,
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

// ─────────────────────────────────────────────────────────────
// Support Quick Action Sheet
// ─────────────────────────────────────────────────────────────

class SupportQuickActionSheet extends StatefulWidget {
  final String initialName;
  final String initialEmail;

  const SupportQuickActionSheet({
    super.key,
    required this.initialName,
    required this.initialEmail,
  });

  @override
  State<SupportQuickActionSheet> createState() =>
      _SupportQuickActionSheetState();
}

class _SupportQuickActionSheetState extends State<SupportQuickActionSheet> {
  final SupportService _supportService = getIt<SupportService>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _messageController;
  late Future<List<SupportItemModel>> _supportItemsFuture;
  late Future<List<SupportContactSubmissionModel>> _myRequestsFuture;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _emailController = TextEditingController(text: widget.initialEmail);
    _messageController = TextEditingController();
    _supportItemsFuture = _supportService.fetchSupportItems();
    _myRequestsFuture = _supportService.fetchMyRequests();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _reloadSupportItems() async {
    setState(() {
      _supportItemsFuture = _supportService.fetchSupportItems();
      _myRequestsFuture = _supportService.fetchMyRequests();
    });
  }

  Future<void> _submitContact() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      await _supportService.sendContact(
        name: _nameController.text,
        email: _emailController.text,
        message: _messageController.text,
      );

      if (!mounted) {
        return;
      }

      Navigator.of(context).pop(true);
    } catch (_) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Không thể gửi yêu cầu hỗ trợ. Vui lòng thử lại.',
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.error.withValues(alpha: 0.92),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = _QuickActionSheetPalette.fromTheme(Theme.of(context));

    return _QuickActionSheetScaffold(
      accentColor: const Color(0xFFE57E6D),
      icon: Icons.support_agent_rounded,
      title: 'Liên hệ hỗ trợ',
      subtitle: 'Gửi yêu cầu hoặc xem các kênh hỗ trợ có sẵn.',
      trailing: IconButton(
        onPressed: _reloadSupportItems,
        icon: Icon(Icons.refresh_rounded, color: palette.textSecondary),
        tooltip: 'Làm mới',
      ),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(18, 2, 18, 24),
        children: [
          _buildSupportItemsSection(palette),
          const SizedBox(height: 16),
          _buildMyRequestsSection(palette),
          const SizedBox(height: 16),
          _buildContactForm(palette),
        ],
      ),
    );
  }

  Widget _buildSupportItemsSection(_QuickActionSheetPalette palette) {
    return FutureBuilder<List<SupportItemModel>>(
      future: _supportItemsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return _QuickActionErrorState(
            palette: palette,
            message: 'Không thể tải danh sách hỗ trợ.',
            onRetry: _reloadSupportItems,
          );
        }

        final items = snapshot.data ?? const <SupportItemModel>[];
        if (items.isEmpty) {
          return _EmptySection(
            palette: palette,
            message: 'Chưa có mục hỗ trợ nào.',
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionTitle(title: 'Kênh hỗ trợ', palette: palette),
            const SizedBox(height: 10),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _SupportItemTile(palette: palette, item: item),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMyRequestsSection(_QuickActionSheetPalette palette) {
    return FutureBuilder<List<SupportContactSubmissionModel>>(
      future: _myRequestsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        }

        if (snapshot.hasError) {
          return const SizedBox.shrink();
        }

        final requests =
            snapshot.data ?? const <SupportContactSubmissionModel>[];
        if (requests.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionTitle(title: 'Yêu cầu của tôi', palette: palette),
            const SizedBox(height: 10),
            ...requests.map(
              (request) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _MyRequestTile(palette: palette, request: request),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildContactForm(_QuickActionSheetPalette palette) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: palette.border),
          boxShadow: [
            BoxShadow(
              color: palette.shadow,
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionTitle(title: 'Gửi yêu cầu mới', palette: palette),
            const SizedBox(height: 12),
            TextFormField(
              controller: _nameController,
              textInputAction: TextInputAction.next,
              decoration: _fieldDecoration(
                palette: palette,
                labelText: 'Họ và tên',
                hintText: 'Nhập tên liên hệ',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Vui lòng nhập họ và tên';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _emailController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: _fieldDecoration(
                palette: palette,
                labelText: 'Email',
                hintText: 'name@company.com',
              ),
              validator: (value) {
                final input = value?.trim() ?? '';
                if (input.isEmpty) {
                  return 'Vui lòng nhập email';
                }
                if (!input.contains('@') || !input.contains('.')) {
                  return 'Email không hợp lệ';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _messageController,
              maxLines: 5,
              textInputAction: TextInputAction.newline,
              decoration: _fieldDecoration(
                palette: palette,
                labelText: 'Nội dung hỗ trợ',
                hintText: 'Mô tả ngắn gọn vấn đề hoặc nhu cầu của bạn',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Vui lòng nhập nội dung cần hỗ trợ';
                }
                if (value.trim().length < 10) {
                  return 'Nội dung cần ít nhất 10 ký tự';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _isSubmitting ? null : _submitContact,
                icon: _isSubmitting
                    ? SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          color: palette.onAccent,
                        ),
                      )
                    : const Icon(Icons.send_rounded),
                label: Text(_isSubmitting ? 'Đang gửi...' : 'Gửi yêu cầu'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration({
    required _QuickActionSheetPalette palette,
    required String labelText,
    required String hintText,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      filled: true,
      fillColor: palette.inputFill,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: palette.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: palette.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: palette.accent, width: 1.4),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Sales Quick Action Sheet
// ─────────────────────────────────────────────────────────────

class SalesQuickActionSheet extends StatefulWidget {
  const SalesQuickActionSheet({super.key});

  @override
  State<SalesQuickActionSheet> createState() => _SalesQuickActionSheetState();
}

class _SalesQuickActionSheetState extends State<SalesQuickActionSheet> {
  final SalesQuickActionService _salesService =
      getIt<SalesQuickActionService>();
  late Future<SalesQuickActionData> _salesFuture;

  @override
  void initState() {
    super.initState();
    _salesFuture = _salesService.fetchSalesOverview();
  }

  Future<void> _reload() async {
    setState(() {
      _salesFuture = _salesService.fetchSalesOverview();
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = _QuickActionSheetPalette.fromTheme(Theme.of(context));

    return _QuickActionSheetScaffold(
      accentColor: const Color(0xFFE0A442),
      icon: Icons.receipt_long_rounded,
      title: 'Giao dịch',
      subtitle: 'Tổng quan tình hình bán hàng và giao dịch gần đây.',
      trailing: IconButton(
        onPressed: _reload,
        icon: Icon(Icons.refresh_rounded, color: palette.textSecondary),
        tooltip: 'Làm mới',
      ),
      child: FutureBuilder<SalesQuickActionData>(
        future: _salesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return _QuickActionErrorState(
              palette: palette,
              message: 'Không thể tải dữ liệu giao dịch. Vui lòng thử lại.',
              onRetry: _reload,
            );
          }

          final data = snapshot.data;
          if (data == null) {
            return _QuickActionErrorState(
              palette: palette,
              message: 'Không có dữ liệu giao dịch.',
              onRetry: _reload,
            );
          }

          return RefreshIndicator(
            onRefresh: _reload,
            color: palette.accent,
            child: ListView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.fromLTRB(18, 2, 18, 24),
              children: [
                _buildSalesMetrics(palette, data),
                const SizedBox(height: 16),
                _SectionTitle(title: 'Giao dịch gần đây', palette: palette),
                const SizedBox(height: 10),
                if (data.recentSales.isEmpty)
                  _EmptySection(
                    palette: palette,
                    message: 'Chưa có giao dịch nào.',
                  )
                else
                  ...data.recentSales.map(
                    (sale) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _SaleItemTile(palette: palette, sale: sale),
                    ),
                  ),
                const SizedBox(height: 16),
                _buildViewAllButton(palette, context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSalesMetrics(
    _QuickActionSheetPalette palette,
    SalesQuickActionData data,
  ) {
    final tiles = [
      _MetricTile(
        palette: palette,
        icon: Icons.receipt_long_rounded,
        label: 'Tổng giao dịch',
        value: data.totalSales.toString(),
      ),
      _MetricTile(
        palette: palette,
        icon: Icons.check_circle_outline_rounded,
        label: 'Hoàn thành',
        value: data.completedSales.toString(),
        valueColor: AppColors.success,
      ),
      _MetricTile(
        palette: palette,
        icon: Icons.schedule_rounded,
        label: 'Đang chờ',
        value: data.pendingSales.toString(),
        valueColor: const Color(0xFFE0A442),
      ),
      _MetricTile(
        palette: palette,
        icon: Icons.account_balance_wallet_outlined,
        label: 'Doanh thu',
        value: data.formattedRevenue,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tiles.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.28,
      ),
      itemBuilder: (context, index) => tiles[index],
    );
  }

  Widget _buildViewAllButton(
    _QuickActionSheetPalette palette,
    BuildContext context,
  ) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          Navigator.of(context).pop();
          context.go(RouteNames.sales);
        },
        icon: const Icon(Icons.open_in_new_rounded, size: 18),
        label: const Text('Xem tất cả giao dịch'),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          side: BorderSide(color: palette.border),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Inventory Quick Action Sheet
// ─────────────────────────────────────────────────────────────

class InventoryQuickActionSheet extends StatefulWidget {
  const InventoryQuickActionSheet({super.key});

  @override
  State<InventoryQuickActionSheet> createState() =>
      _InventoryQuickActionSheetState();
}

class _InventoryQuickActionSheetState extends State<InventoryQuickActionSheet> {
  final InventoryQuickActionService _inventoryService =
      getIt<InventoryQuickActionService>();
  late Future<InventoryQuickActionData> _inventoryFuture;

  @override
  void initState() {
    super.initState();
    _inventoryFuture = _inventoryService.fetchInventoryOverview();
  }

  Future<void> _reload() async {
    setState(() {
      _inventoryFuture = _inventoryService.fetchInventoryOverview();
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = _QuickActionSheetPalette.fromTheme(Theme.of(context));

    return _QuickActionSheetScaffold(
      accentColor: const Color(0xFF4E83F5),
      icon: Icons.inventory_2_outlined,
      title: 'Kho hàng',
      subtitle: 'Tổng quan kho xe và tình trạng từng xe.',
      trailing: IconButton(
        onPressed: _reload,
        icon: Icon(Icons.refresh_rounded, color: palette.textSecondary),
        tooltip: 'Làm mới',
      ),
      child: FutureBuilder<InventoryQuickActionData>(
        future: _inventoryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return _QuickActionErrorState(
              palette: palette,
              message: 'Không thể tải dữ liệu kho. Vui lòng thử lại.',
              onRetry: _reload,
            );
          }

          final data = snapshot.data;
          if (data == null) {
            return _QuickActionErrorState(
              palette: palette,
              message: 'Không có dữ liệu kho hàng.',
              onRetry: _reload,
            );
          }

          return RefreshIndicator(
            onRefresh: _reload,
            color: palette.accent,
            child: ListView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.fromLTRB(18, 2, 18, 24),
              children: [
                _buildInventoryMetrics(palette, data),
                const SizedBox(height: 16),
                _SectionTitle(title: 'Danh sách xe', palette: palette),
                const SizedBox(height: 10),
                if (data.recentCars.isEmpty)
                  _EmptySection(
                    palette: palette,
                    message: 'Chưa có xe nào trong kho.',
                  )
                else
                  ...data.recentCars.map(
                    (car) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _InventoryCarTile(palette: palette, car: car),
                    ),
                  ),
                const SizedBox(height: 16),
                _buildInventoryActions(palette, context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInventoryMetrics(
    _QuickActionSheetPalette palette,
    InventoryQuickActionData data,
  ) {
    final tiles = [
      _MetricTile(
        palette: palette,
        icon: Icons.directions_car_filled_outlined,
        label: 'Tổng xe',
        value: data.totalCars.toString(),
      ),
      _MetricTile(
        palette: palette,
        icon: Icons.check_circle_outline_rounded,
        label: 'Sẵn bán',
        value: data.availableCars.toString(),
        valueColor: AppColors.success,
      ),
      _MetricTile(
        palette: palette,
        icon: Icons.sell_outlined,
        label: 'Đã bán',
        value: data.soldCars.toString(),
        valueColor: const Color(0xFFE0A442),
      ),
      _MetricTile(
        palette: palette,
        icon: Icons.bookmark_outline_rounded,
        label: 'Đã đặt',
        value: data.reservedCars.toString(),
        valueColor: const Color(0xFF4E83F5),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tiles.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.28,
      ),
      itemBuilder: (context, index) => tiles[index],
    );
  }

  Widget _buildInventoryActions(
    _QuickActionSheetPalette palette,
    BuildContext context,
  ) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
              context.go(RouteNames.carList);
            },
            icon: const Icon(Icons.add_rounded, size: 20),
            label: const Text('Thêm xe mới'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
              context.go(RouteNames.carList);
            },
            icon: const Icon(Icons.open_in_new_rounded, size: 18),
            label: const Text('Xem toàn bộ kho'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              side: BorderSide(color: palette.border),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Shared Scaffold & Palette
// ─────────────────────────────────────────────────────────────

class _QuickActionSheetScaffold extends StatelessWidget {
  final Color accentColor;
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget child;
  final Widget? trailing;

  const _QuickActionSheetScaffold({
    required this.accentColor,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final palette = _QuickActionSheetPalette.fromTheme(Theme.of(context));
    final topGradientColor = palette.isDark
        ? palette.surface
        : accentColor.withValues(alpha: 0.08);

    return SafeArea(
      top: false,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Container(
          height: MediaQuery.sizeOf(context).height * 0.9,
          decoration: BoxDecoration(
            color: palette.background,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border.all(color: palette.border),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [topGradientColor, palette.background],
            ),
            boxShadow: [
              BoxShadow(
                color: palette.shadow,
                blurRadius: 30,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: palette.border,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 14, 14, 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Icon(icon, color: accentColor, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: AppTextStyles.titleLarge.copyWith(
                              color: palette.textPrimary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            subtitle,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: palette.textSecondary,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ?trailing,
                  ],
                ),
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionSheetPalette {
  final bool isDark;
  final Color background;
  final Color surface;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color accent;
  final Color accentSoft;
  final Color progressBackground;
  final Color inputFill;
  final Color shadow;
  final Color onAccent;

  const _QuickActionSheetPalette({
    required this.isDark,
    required this.background,
    required this.surface,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.accent,
    required this.accentSoft,
    required this.progressBackground,
    required this.inputFill,
    required this.shadow,
    required this.onAccent,
  });

  factory _QuickActionSheetPalette.fromTheme(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final accent = theme.colorScheme.primary;

    return _QuickActionSheetPalette(
      isDark: isDark,
      background: isDark ? const Color(0xFF0E131A) : theme.colorScheme.surface,
      surface: isDark ? const Color(0xFF141B24) : Colors.white,
      border: isDark
          ? Colors.white.withValues(alpha: 0.11)
          : Colors.black.withValues(alpha: 0.08),
      textPrimary: onSurface,
      textSecondary: onSurface.withValues(alpha: isDark ? 0.70 : 0.64),
      accent: accent,
      accentSoft: accent.withValues(alpha: 0.12),
      progressBackground: isDark
          ? Colors.white.withValues(alpha: 0.12)
          : Colors.black.withValues(alpha: 0.08),
      inputFill: isDark
          ? Colors.white.withValues(alpha: 0.08)
          : Colors.black.withValues(alpha: 0.03),
      shadow: Colors.black.withValues(alpha: isDark ? 0.34 : 0.08),
      onAccent: theme.colorScheme.onPrimary,
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Shared Tiles & Widgets
// ─────────────────────────────────────────────────────────────

class _MetricTile extends StatelessWidget {
  final _QuickActionSheetPalette palette;
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _MetricTile({
    required this.palette,
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: palette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: palette.accentSoft,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, color: palette.accent, size: 17),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.labelSmall.copyWith(
                  color: palette.textSecondary,
                  letterSpacing: 0.9,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.titleLarge.copyWith(
                  color: valueColor ?? palette.textPrimary,
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

class _RecentTransactionTile extends StatelessWidget {
  final _QuickActionSheetPalette palette;
  final String customerName;
  final String carName;
  final String amount;
  final String timeAgo;

  const _RecentTransactionTile({
    required this.palette,
    required this.customerName,
    required this.carName,
    required this.amount,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    final initials = customerName.isNotEmpty
        ? customerName.characters.first.toUpperCase()
        : '?';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: palette.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: palette.accent,
            child: Text(
              initials,
              style: AppTextStyles.labelLarge.copyWith(
                color: palette.onAccent,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customerName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: palette.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  carName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: palette.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: AppTextStyles.titleSmall.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                timeAgo,
                style: AppTextStyles.labelSmall.copyWith(
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

class _SuggestionTile extends StatelessWidget {
  final _QuickActionSheetPalette palette;
  final String suggestion;

  const _SuggestionTile({required this.palette, required this.suggestion});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: palette.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: palette.accent,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              suggestion,
              style: AppTextStyles.bodyMedium.copyWith(
                color: palette.textPrimary,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SupportItemTile extends StatelessWidget {
  final _QuickActionSheetPalette palette;
  final SupportItemModel item;

  const _SupportItemTile({required this.palette, required this.item});

  @override
  Widget build(BuildContext context) {
    final accentColor = _supportAccent(item.type);
    final icon = _supportIcon(item.type);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: palette.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: accentColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: palette.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: palette.textSecondary,
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

  IconData _supportIcon(String type) {
    switch (type.toLowerCase()) {
      case 'support_center':
        return Icons.help_outline_rounded;
      case 'contact':
        return Icons.support_agent_rounded;
      case 'about':
        return Icons.info_outline_rounded;
      default:
        return Icons.headset_mic_outlined;
    }
  }

  Color _supportAccent(String type) {
    switch (type.toLowerCase()) {
      case 'support_center':
        return const Color(0xFF4E83F5);
      case 'contact':
        return const Color(0xFFE57E6D);
      case 'about':
        return const Color(0xFF2FA58A);
      default:
        return palette.accent;
    }
  }
}

class _MyRequestTile extends StatelessWidget {
  final _QuickActionSheetPalette palette;
  final SupportContactSubmissionModel request;

  const _MyRequestTile({required this.palette, required this.request});

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(request.status);
    final statusLabel = _statusLabel(request.status);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: palette.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.mail_outline_rounded,
              color: statusColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        request.message,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.titleSmall.copyWith(
                          color: palette.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        statusLabel,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  request.createdAt != null
                      ? _formatDate(request.createdAt!)
                      : '',
                  style: AppTextStyles.labelSmall.copyWith(
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

  Color _statusColor(String status) {
    switch (status) {
      case 'pending':
        return const Color(0xFFE0A442);
      case 'resolved':
        return AppColors.success;
      case 'rejected':
        return AppColors.error;
      default:
        return palette.accent;
    }
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'pending':
        return 'Đang chờ';
      case 'resolved':
        return 'Đã xử lý';
      case 'rejected':
        return 'Từ chối';
      default:
        return status;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} phút trước';
    }
    if (diff.inHours < 24) {
      return '${diff.inHours} giờ trước';
    }
    if (diff.inDays < 7) {
      return '${diff.inDays} ngày trước';
    }
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _SaleItemTile extends StatelessWidget {
  final _QuickActionSheetPalette palette;
  final SaleOverviewItem sale;

  const _SaleItemTile({required this.palette, required this.sale});

  @override
  Widget build(BuildContext context) {
    final statusColor = sale.status == 'completed'
        ? AppColors.success
        : const Color(0xFFE0A442);
    final initials = sale.customerName.isNotEmpty
        ? sale.customerName.characters.first.toUpperCase()
        : '?';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: palette.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: statusColor.withValues(alpha: 0.15),
            child: Text(
              initials,
              style: AppTextStyles.labelLarge.copyWith(
                color: statusColor,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sale.customerName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: palette.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  sale.carName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: palette.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                sale.formattedPrice,
                style: AppTextStyles.titleSmall.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  sale.statusLabel,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w700,
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

class _InventoryCarTile extends StatelessWidget {
  final _QuickActionSheetPalette palette;
  final InventoryCarItem car;

  const _InventoryCarTile({required this.palette, required this.car});

  @override
  Widget build(BuildContext context) {
    final statusColor = _carStatusColor(car.status);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: palette.border),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.directions_car_filled_outlined,
              color: statusColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: palette.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${car.brand} • ${car.color} • ${car.year}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: palette.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                car.formattedPrice,
                style: AppTextStyles.titleSmall.copyWith(
                  color: palette.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  car.statusLabel,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w700,
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

  Color _carStatusColor(String status) {
    switch (status) {
      case 'available':
        return AppColors.success;
      case 'sold':
        return const Color(0xFFE0A442);
      case 'reserved':
        return const Color(0xFF4E83F5);
      default:
        return palette.accent;
    }
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final _QuickActionSheetPalette palette;

  const _SectionTitle({required this.title, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.titleMedium.copyWith(
        color: palette.textPrimary,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _EmptySection extends StatelessWidget {
  final _QuickActionSheetPalette palette;
  final String message;

  const _EmptySection({required this.palette, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: palette.border),
      ),
      child: Text(
        message,
        style: AppTextStyles.bodyMedium.copyWith(
          color: palette.textSecondary,
          height: 1.35,
        ),
      ),
    );
  }
}

class _QuickActionErrorState extends StatelessWidget {
  final _QuickActionSheetPalette palette;
  final String message;
  final Future<void> Function() onRetry;

  const _QuickActionErrorState({
    required this.palette,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 38,
              color: AppColors.error.withValues(alpha: 0.9),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: palette.textSecondary,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Thử lại'),
            ),
          ],
        ),
      ),
    );
  }
}
