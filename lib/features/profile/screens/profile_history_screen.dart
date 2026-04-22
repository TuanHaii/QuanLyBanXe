// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';
// Nap thu vien hoac module can thiet.
import 'package:intl/intl.dart';

// Nap thu vien hoac module can thiet.
import '../../../shared/constants/app_constants.dart';
// Nap thu vien hoac module can thiet.
import '../../../shared/services/service_locator.dart';
// Nap thu vien hoac module can thiet.
import '../../../shared/themes/app_colors.dart';
// Nap thu vien hoac module can thiet.
import '../models/history_item_model.dart';
// Nap thu vien hoac module can thiet.
import '../services/history_service.dart';

// Dinh nghia kieu liet ke _HistoryFilter.
enum _HistoryFilter { all, success, pending }

// Dinh nghia lop ProfileHistoryScreen de gom nhom logic lien quan.
class ProfileHistoryScreen extends StatefulWidget {
  // Khai bao bien ProfileHistoryScreen de luu du lieu su dung trong xu ly.
  const ProfileHistoryScreen({super.key});

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Thuc thi cau lenh hien tai theo luong xu ly.
  State<ProfileHistoryScreen> createState() => _ProfileHistoryScreenState();
}

// Dinh nghia lop _ProfileHistoryScreenState de gom nhom logic lien quan.
class _ProfileHistoryScreenState extends State<ProfileHistoryScreen> {
  // Dinh nghia ham _palette de xu ly nghiep vu tuong ung.
  _ProfileHistoryPalette _palette(BuildContext context) {
    // Tra ve ket qua cho noi goi ham.
    return _ProfileHistoryPalette.fromTheme(Theme.of(context));
  }

  // Khai bao bien HistoryService de luu du lieu su dung trong xu ly.
  final HistoryService _historyService = getIt<HistoryService>();

  // Thuc thi cau lenh hien tai theo luong xu ly.
  _HistoryFilter _selectedFilter = _HistoryFilter.all;
  // Khai bao bien _historyItems de luu du lieu su dung trong xu ly.
  List<HistoryItemModel> _historyItems = [];
  // Khai bao bien _isLoading de luu du lieu su dung trong xu ly.
  bool _isLoading = true;
  // Thuc thi cau lenh hien tai theo luong xu ly.
  String? _errorMessage;

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Dinh nghia ham initState de xu ly nghiep vu tuong ung.
  void initState() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.initState();
    // Khai bao constructor _loadHistory de khoi tao doi tuong.
    _loadHistory();
  }

  // Khai bao bien _loadHistory de luu du lieu su dung trong xu ly.
  Future<void> _loadHistory() async {
    // Cap nhat state de giao dien duoc render lai.
    setState(() {
      // Gan gia tri cho bien _isLoading.
      _isLoading = true;
      // Gan gia tri cho bien _errorMessage.
      _errorMessage = null;
    });

    // Bao boc khoi lenh co the phat sinh loi de xu ly an toan.
    try {
      // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
      final items = await _historyService.fetchHistory();
      // Kiem tra dieu kien de re nhanh xu ly.
      if (!mounted) return;
      // Cap nhat state de giao dien duoc render lai.
      setState(() {
        // Gan gia tri cho bien _historyItems.
        _historyItems = items;
      });
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } catch (_) {
      // Kiem tra dieu kien de re nhanh xu ly.
      if (!mounted) return;
      // Cap nhat state de giao dien duoc render lai.
      setState(() {
        // Gan gia tri cho bien _errorMessage.
        _errorMessage = 'Không thể tải lịch sử. Vui lòng thử lại.';
      });
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } finally {
      // Kiem tra dieu kien de re nhanh xu ly.
      if (mounted) {
        // Cap nhat state de giao dien duoc render lai.
        setState(() => _isLoading = false);
      }
    }
  }

  // Khai bao bien get de luu du lieu su dung trong xu ly.
  List<HistoryItemModel> get _filteredHistory {
    // Bat dau re nhanh theo nhieu truong hop gia tri.
    switch (_selectedFilter) {
      // Xu ly mot truong hop cu the trong switch.
      case _HistoryFilter.all:
        // Tra ve ket qua cho noi goi ham.
        return _historyItems;
      // Xu ly mot truong hop cu the trong switch.
      case _HistoryFilter.success:
        // Tra ve ket qua cho noi goi ham.
        return _historyItems.where((item) => item.isSuccess).toList();
      // Xu ly mot truong hop cu the trong switch.
      case _HistoryFilter.pending:
        // Tra ve ket qua cho noi goi ham.
        return _historyItems.where((item) => !item.isSuccess).toList();
    }
  }

  // Khai bao bien _formatAmount de luu du lieu su dung trong xu ly.
  String _formatAmount(double amount) {
    // Kiem tra dieu kien de re nhanh xu ly.
    if (amount >= 1e9) {
      // Tra ve ket qua cho noi goi ham.
      return '${(amount / 1e9).toStringAsFixed(1)} tỷ';
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } else if (amount >= 1e6) {
      // Tra ve ket qua cho noi goi ham.
      return '${(amount / 1e6).toStringAsFixed(0)} triệu';
    }
    // Tra ve ket qua cho noi goi ham.
    return NumberFormat.compact().format(amount);
  }

  // Khai bao bien _formatDate de luu du lieu su dung trong xu ly.
  String _formatDate(DateTime date) {
    // Khai bao bien now de luu du lieu su dung trong xu ly.
    final now = DateTime.now();
    // Khai bao bien diff de luu du lieu su dung trong xu ly.
    final diff = now.difference(date);
    // Kiem tra dieu kien de re nhanh xu ly.
    if (diff.inDays == 0) {
      // Tra ve ket qua cho noi goi ham.
      return 'Hôm nay, ${DateFormat('HH:mm').format(date)}';
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } else if (diff.inDays == 1) {
      // Tra ve ket qua cho noi goi ham.
      return 'Hôm qua, ${DateFormat('HH:mm').format(date)}';
    }
    // Tra ve ket qua cho noi goi ham.
    return DateFormat('dd/MM, HH:mm').format(date);
  }

  // Khai bao bien _statusLabel de luu du lieu su dung trong xu ly.
  String _statusLabel(String status) {
    // Bat dau re nhanh theo nhieu truong hop gia tri.
    switch (status.toLowerCase()) {
      // Xu ly mot truong hop cu the trong switch.
      case 'completed':
        // Tra ve ket qua cho noi goi ham.
        return 'Thành công';
      // Xu ly mot truong hop cu the trong switch.
      case 'pending':
        // Tra ve ket qua cho noi goi ham.
        return 'Đang chờ';
      // Xu ly mac dinh khi khong khop case nao.
      default:
        // Tra ve ket qua cho noi goi ham.
        return status;
    }
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien metrics de luu du lieu su dung trong xu ly.
    final metrics = _ProfileHistoryMetrics.fromWidth(
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
          'Lịch Sử Giao Dịch',
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
          child: _isLoading
              // Thuc thi cau lenh hien tai theo luong xu ly.
              ? const Center(child: CircularProgressIndicator())
              // Thuc thi cau lenh hien tai theo luong xu ly.
              : _errorMessage != null
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  ? Center(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      child: Padding(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        child: Column(
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          mainAxisAlignment: MainAxisAlignment.center,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          children: [
                            // Goi ham de thuc thi tac vu can thiet.
                            Text(_errorMessage!, textAlign: TextAlign.center),
                            // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                            const SizedBox(height: 12),
                            // Goi ham de thuc thi tac vu can thiet.
                            ElevatedButton(
                              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                              onPressed: _loadHistory,
                              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                              child: const Text('Thử lại'),
                            ),
                          ],
                        ),
                      ),
                    )
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  : RefreshIndicator(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      onRefresh: _loadHistory,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      child: SingleChildScrollView(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        physics: const AlwaysScrollableScrollPhysics(
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          parent: BouncingScrollPhysics(),
                        ),
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
                            _buildSummary(metrics),
                            // Goi ham de thuc thi tac vu can thiet.
                            SizedBox(height: metrics.px(14)),
                            // Goi ham de thuc thi tac vu can thiet.
                            _buildSectionTitle('BỘ LỌC', metrics),
                            // Goi ham de thuc thi tac vu can thiet.
                            SizedBox(height: metrics.px(8)),
                            // Goi ham de thuc thi tac vu can thiet.
                            _buildFilterTabs(metrics),
                            // Goi ham de thuc thi tac vu can thiet.
                            SizedBox(height: metrics.px(14)),
                            // Goi ham de thuc thi tac vu can thiet.
                            _buildSectionTitle('DANH SÁCH GIAO DỊCH', metrics),
                            // Goi ham de thuc thi tac vu can thiet.
                            SizedBox(height: metrics.px(8)),
                            // Goi ham de thuc thi tac vu can thiet.
                            _buildHistoryList(metrics),
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
      ),
    );
  }

  // Khai bao bien _buildSummary de luu du lieu su dung trong xu ly.
  Widget _buildSummary(_ProfileHistoryMetrics metrics) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Khai bao bien successfulCount de luu du lieu su dung trong xu ly.
    final successfulCount =
        // Thuc thi cau lenh hien tai theo luong xu ly.
        _historyItems.where((item) => item.isSuccess).length;
    // Khai bao bien pendingCount de luu du lieu su dung trong xu ly.
    final pendingCount = _historyItems.length - successfulCount;

    // Tra ve ket qua cho noi goi ham.
    return Row(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      children: [
        // Goi ham de thuc thi tac vu can thiet.
        Expanded(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: _buildSummaryCard(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            metrics: metrics,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            icon: Icons.receipt_long_outlined,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            value: '${_historyItems.length}',
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            label: 'Tổng giao dịch',
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            accentColor: palette.accent,
          ),
        ),
        // Goi ham de thuc thi tac vu can thiet.
        SizedBox(width: metrics.px(8)),
        // Goi ham de thuc thi tac vu can thiet.
        Expanded(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: _buildSummaryCard(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            metrics: metrics,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            icon: Icons.check_circle_outline,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            value: '$successfulCount',
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            label: 'Thành công',
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            accentColor: palette.tealAccent,
          ),
        ),
        // Goi ham de thuc thi tac vu can thiet.
        SizedBox(width: metrics.px(8)),
        // Goi ham de thuc thi tac vu can thiet.
        Expanded(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: _buildSummaryCard(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            metrics: metrics,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            icon: Icons.timelapse_rounded,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            value: '$pendingCount',
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            label: 'Đang chờ',
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            accentColor: palette.warning,
          ),
        ),
      ],
    );
  }

  // Khai bao bien _buildSummaryCard de luu du lieu su dung trong xu ly.
  Widget _buildSummaryCard({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required _ProfileHistoryMetrics metrics,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required IconData icon,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required String value,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required String label,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required Color accentColor,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: EdgeInsets.fromLTRB(
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(10),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(10),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(10),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(9),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.surface,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(metrics.px(14)),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: Border.all(color: palette.cardBorder),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Column(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        crossAxisAlignment: CrossAxisAlignment.start,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: [
          // Goi ham de thuc thi tac vu can thiet.
          Icon(icon, color: accentColor, size: metrics.px(15)),
          // Goi ham de thuc thi tac vu can thiet.
          SizedBox(height: metrics.px(6)),
          // Goi ham de thuc thi tac vu can thiet.
          Text(
            // Thuc thi cau lenh hien tai theo luong xu ly.
            value,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            style: AppTextStyles.titleLarge.copyWith(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: palette.textPrimary,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              fontWeight: FontWeight.w800,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              fontSize: metrics.fs(24),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              height: 1,
            ),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          SizedBox(height: metrics.px(3)),
          // Goi ham de thuc thi tac vu can thiet.
          Text(
            // Thuc thi cau lenh hien tai theo luong xu ly.
            label,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            style: AppTextStyles.labelMedium.copyWith(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: palette.textMuted,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              fontSize: metrics.fs(10.5),
            ),
          ),
        ],
      ),
    );
  }

  // Khai bao bien _buildSectionTitle de luu du lieu su dung trong xu ly.
  Widget _buildSectionTitle(String text, _ProfileHistoryMetrics metrics) {
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

  // Khai bao bien _buildFilterTabs de luu du lieu su dung trong xu ly.
  Widget _buildFilterTabs(_ProfileHistoryMetrics metrics) {
    // Tra ve ket qua cho noi goi ham.
    return SingleChildScrollView(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      scrollDirection: Axis.horizontal,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Row(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: [
          // Goi ham de thuc thi tac vu can thiet.
          _buildFilterChip(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            metrics: metrics,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            filter: _HistoryFilter.all,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            label: 'Tất Cả',
          ),
          // Goi ham de thuc thi tac vu can thiet.
          SizedBox(width: metrics.px(8)),
          // Goi ham de thuc thi tac vu can thiet.
          _buildFilterChip(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            metrics: metrics,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            filter: _HistoryFilter.success,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            label: 'Thành Công',
          ),
          // Goi ham de thuc thi tac vu can thiet.
          SizedBox(width: metrics.px(8)),
          // Goi ham de thuc thi tac vu can thiet.
          _buildFilterChip(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            metrics: metrics,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            filter: _HistoryFilter.pending,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            label: 'Đang Chờ',
          ),
        ],
      ),
    );
  }

  // Khai bao bien _buildFilterChip de luu du lieu su dung trong xu ly.
  Widget _buildFilterChip({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required _ProfileHistoryMetrics metrics,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required _HistoryFilter filter,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required String label,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);
    // Khai bao bien isSelected de luu du lieu su dung trong xu ly.
    final isSelected = _selectedFilter == filter;

    // Tra ve ket qua cho noi goi ham.
    return InkWell(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      borderRadius: BorderRadius.circular(999),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      onTap: () {
        // Kiem tra dieu kien de re nhanh xu ly.
        if (_selectedFilter == filter) {
          // Tra ve ket qua cho noi goi ham.
          return;
        }
        // Cap nhat state de giao dien duoc render lai.
        setState(() => _selectedFilter = filter);
      },
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: AnimatedContainer(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        duration: AppConstants.shortDuration,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        padding: EdgeInsets.symmetric(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          horizontal: metrics.px(12),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          vertical: metrics.px(8),
        ),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        decoration: BoxDecoration(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          color: isSelected ? palette.accent : palette.surface,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          borderRadius: BorderRadius.circular(999),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          border: Border.all(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: isSelected ? palette.accent : palette.cardBorder,
          ),
        ),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: Text(
          // Thuc thi cau lenh hien tai theo luong xu ly.
          label,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          style: AppTextStyles.labelMedium.copyWith(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: isSelected ? palette.buttonForeground : palette.textPrimary,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            fontWeight: FontWeight.w700,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            fontSize: metrics.fs(12),
          ),
        ),
      ),
    );
  }

  // Khai bao bien _buildHistoryList de luu du lieu su dung trong xu ly.
  Widget _buildHistoryList(_ProfileHistoryMetrics metrics) {
    // Khai bao bien items de luu du lieu su dung trong xu ly.
    final items = _filteredHistory;

    // Kiem tra dieu kien de re nhanh xu ly.
    if (items.isEmpty) {
      // Tra ve ket qua cho noi goi ham.
      return Center(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: Text(
          // Thuc thi cau lenh hien tai theo luong xu ly.
          'Không có giao dịch nào.',
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          style: AppTextStyles.bodySmall.copyWith(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: _palette(context).textMuted,
          ),
        ),
      );
    }

    // Tra ve ket qua cho noi goi ham.
    return Column(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      children: items
          // Thuc thi cau lenh hien tai theo luong xu ly.
          .map(
            // Thuc thi cau lenh hien tai theo luong xu ly.
            (item) => Padding(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              padding: EdgeInsets.only(bottom: metrics.px(8)),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              child: _buildHistoryTile(metrics, item),
            ),
          )
          // Thuc thi cau lenh hien tai theo luong xu ly.
          .toList(growable: false),
    );
  }

  // Khai bao bien _buildHistoryTile de luu du lieu su dung trong xu ly.
  Widget _buildHistoryTile(
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _ProfileHistoryMetrics metrics,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    HistoryItemModel item,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  ) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);
    // Khai bao bien statusColor de luu du lieu su dung trong xu ly.
    final statusColor = item.isSuccess ? palette.tealAccent : palette.warning;

    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: EdgeInsets.fromLTRB(
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(12),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(11),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(12),
        // Thuc thi cau lenh hien tai theo luong xu ly.
        metrics.px(11),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.surface,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        borderRadius: BorderRadius.circular(metrics.px(15)),
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
            width: metrics.px(34),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            height: metrics.px(34),
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
              Icons.directions_car_filled_outlined,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: palette.accent,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              size: metrics.px(17),
            ),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          SizedBox(width: metrics.px(10)),
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
                  item.subtitle,
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
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(2)),
                // Goi ham de thuc thi tac vu can thiet.
                Text(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  item.title,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: AppTextStyles.bodySmall.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: palette.textSecondary,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontSize: metrics.fs(12),
                  ),
                ),
                // Goi ham de thuc thi tac vu can thiet.
                SizedBox(height: metrics.px(4)),
                // Goi ham de thuc thi tac vu can thiet.
                Text(
                  // Goi ham de thuc thi tac vu can thiet.
                  _formatDate(item.date),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: AppTextStyles.labelSmall.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: palette.textMuted,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontSize: metrics.fs(10.5),
                  ),
                ),
              ],
            ),
          ),
          // Goi ham de thuc thi tac vu can thiet.
          SizedBox(width: metrics.px(8)),
          // Goi ham de thuc thi tac vu can thiet.
          Column(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            crossAxisAlignment: CrossAxisAlignment.end,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Goi ham de thuc thi tac vu can thiet.
              Text(
                // Goi ham de thuc thi tac vu can thiet.
                _formatAmount(item.amount),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: AppTextStyles.titleSmall.copyWith(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: palette.accent,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontWeight: FontWeight.w800,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontSize: metrics.fs(14),
                ),
              ),
              // Goi ham de thuc thi tac vu can thiet.
              SizedBox(height: metrics.px(4)),
              // Goi ham de thuc thi tac vu can thiet.
              Container(
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
                  color: statusColor.withValues(alpha: 0.2),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  borderRadius: BorderRadius.circular(999),
                ),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: Text(
                  // Goi ham de thuc thi tac vu can thiet.
                  _statusLabel(item.status),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  style: AppTextStyles.labelSmall.copyWith(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: statusColor,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontWeight: FontWeight.w700,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    fontSize: metrics.fs(10),
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

// Dinh nghia lop _ProfileHistoryPalette de gom nhom logic lien quan.
class _ProfileHistoryPalette {
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color background;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color gradientTop;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color gradientBottom;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color surface;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color accent;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color tealAccent;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color warning;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color textPrimary;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color textSecondary;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color textMuted;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color cardBorder;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color iconContainer;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color buttonForeground;

  // Khai bao bien _ProfileHistoryPalette de luu du lieu su dung trong xu ly.
  const _ProfileHistoryPalette({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.background,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.gradientTop,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.gradientBottom,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.surface,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.accent,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.tealAccent,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.warning,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.textPrimary,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.textSecondary,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.textMuted,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.cardBorder,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.iconContainer,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.buttonForeground,
  });

  // Thuc thi cau lenh hien tai theo luong xu ly.
  factory _ProfileHistoryPalette.fromTheme(ThemeData theme) {
    // Khai bao bien isDark de luu du lieu su dung trong xu ly.
    final isDark = theme.brightness == Brightness.dark;
    // Khai bao bien onSurface de luu du lieu su dung trong xu ly.
    final onSurface = theme.colorScheme.onSurface;

    // Tra ve ket qua cho noi goi ham.
    return _ProfileHistoryPalette(
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
      accent: const Color(0xFFD8AD48),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      tealAccent: const Color(0xFF09B7A3),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      warning: const Color(0xFFE07A3F),
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

// Dinh nghia lop _ProfileHistoryMetrics de gom nhom logic lien quan.
class _ProfileHistoryMetrics {
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double scale;
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double textScale;

  // Khai bao bien _ProfileHistoryMetrics de luu du lieu su dung trong xu ly.
  const _ProfileHistoryMetrics._({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.scale,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.textScale,
  });

  // Thuc thi cau lenh hien tai theo luong xu ly.
  factory _ProfileHistoryMetrics.fromWidth(double width) {
    // Khai bao bien rawScale de luu du lieu su dung trong xu ly.
    final rawScale = width / 390;
    // Tra ve ket qua cho noi goi ham.
    return _ProfileHistoryMetrics._(
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
