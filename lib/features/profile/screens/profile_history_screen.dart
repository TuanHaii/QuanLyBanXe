import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../shared/constants/app_constants.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/themes/app_colors.dart';
import '../models/history_item_model.dart';
import '../services/history_service.dart';

enum _HistoryFilter { all, success, pending }

class ProfileHistoryScreen extends StatefulWidget {
  const ProfileHistoryScreen({super.key});

  @override
  State<ProfileHistoryScreen> createState() => _ProfileHistoryScreenState();
}

class _ProfileHistoryScreenState extends State<ProfileHistoryScreen> {
  _ProfileHistoryPalette _palette(BuildContext context) {
    return _ProfileHistoryPalette.fromTheme(Theme.of(context));
  }

  final HistoryService _historyService = getIt<HistoryService>();

  _HistoryFilter _selectedFilter = _HistoryFilter.all;
  List<HistoryItemModel> _historyItems = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final items = await _historyService.fetchHistory();
      if (!mounted) return;
      setState(() {
        _historyItems = items;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Không thể tải lịch sử. Vui lòng thử lại.';
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  List<HistoryItemModel> get _filteredHistory {
    switch (_selectedFilter) {
      case _HistoryFilter.all:
        return _historyItems;
      case _HistoryFilter.success:
        return _historyItems.where((item) => item.isSuccess).toList();
      case _HistoryFilter.pending:
        return _historyItems.where((item) => !item.isSuccess).toList();
    }
  }

  String _formatAmount(double amount) {
    if (amount >= 1e9) {
      return '${(amount / 1e9).toStringAsFixed(1)} tỷ';
    } else if (amount >= 1e6) {
      return '${(amount / 1e6).toStringAsFixed(0)} triệu';
    }
    return NumberFormat.compact().format(amount);
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays == 0) {
      return 'Hôm nay, ${DateFormat('HH:mm').format(date)}';
    } else if (diff.inDays == 1) {
      return 'Hôm qua, ${DateFormat('HH:mm').format(date)}';
    }
    return DateFormat('dd/MM, HH:mm').format(date);
  }

  String _statusLabel(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return 'Thành công';
      case 'pending':
        return 'Đang chờ';
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final metrics = _ProfileHistoryMetrics.fromWidth(
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
          'Lịch Sử Giao Dịch',
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
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _errorMessage != null
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_errorMessage!, textAlign: TextAlign.center),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: _loadHistory,
                              child: const Text('Thử lại'),
                            ),
                          ],
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _loadHistory,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        padding: EdgeInsets.fromLTRB(
                          metrics.px(14),
                          metrics.px(10),
                          metrics.px(14),
                          metrics.px(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSummary(metrics),
                            SizedBox(height: metrics.px(14)),
                            _buildSectionTitle('BỘ LỌC', metrics),
                            SizedBox(height: metrics.px(8)),
                            _buildFilterTabs(metrics),
                            SizedBox(height: metrics.px(14)),
                            _buildSectionTitle('DANH SÁCH GIAO DỊCH', metrics),
                            SizedBox(height: metrics.px(8)),
                            _buildHistoryList(metrics),
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
      ),
    );
  }

  Widget _buildSummary(_ProfileHistoryMetrics metrics) {
    final palette = _palette(context);

    final successfulCount =
        _historyItems.where((item) => item.isSuccess).length;
    final pendingCount = _historyItems.length - successfulCount;

    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            metrics: metrics,
            icon: Icons.receipt_long_outlined,
            value: '${_historyItems.length}',
            label: 'Tổng giao dịch',
            accentColor: palette.accent,
          ),
        ),
        SizedBox(width: metrics.px(8)),
        Expanded(
          child: _buildSummaryCard(
            metrics: metrics,
            icon: Icons.check_circle_outline,
            value: '$successfulCount',
            label: 'Thành công',
            accentColor: palette.tealAccent,
          ),
        ),
        SizedBox(width: metrics.px(8)),
        Expanded(
          child: _buildSummaryCard(
            metrics: metrics,
            icon: Icons.timelapse_rounded,
            value: '$pendingCount',
            label: 'Đang chờ',
            accentColor: palette.warning,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required _ProfileHistoryMetrics metrics,
    required IconData icon,
    required String value,
    required String label,
    required Color accentColor,
  }) {
    final palette = _palette(context);

    return Container(
      padding: EdgeInsets.fromLTRB(
        metrics.px(10),
        metrics.px(10),
        metrics.px(10),
        metrics.px(9),
      ),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(metrics.px(14)),
        border: Border.all(color: palette.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accentColor, size: metrics.px(15)),
          SizedBox(height: metrics.px(6)),
          Text(
            value,
            style: AppTextStyles.titleLarge.copyWith(
              color: palette.textPrimary,
              fontWeight: FontWeight.w800,
              fontSize: metrics.fs(24),
              height: 1,
            ),
          ),
          SizedBox(height: metrics.px(3)),
          Text(
            label,
            style: AppTextStyles.labelMedium.copyWith(
              color: palette.textMuted,
              fontSize: metrics.fs(10.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String text, _ProfileHistoryMetrics metrics) {
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

  Widget _buildFilterTabs(_ProfileHistoryMetrics metrics) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip(
            metrics: metrics,
            filter: _HistoryFilter.all,
            label: 'Tất Cả',
          ),
          SizedBox(width: metrics.px(8)),
          _buildFilterChip(
            metrics: metrics,
            filter: _HistoryFilter.success,
            label: 'Thành Công',
          ),
          SizedBox(width: metrics.px(8)),
          _buildFilterChip(
            metrics: metrics,
            filter: _HistoryFilter.pending,
            label: 'Đang Chờ',
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required _ProfileHistoryMetrics metrics,
    required _HistoryFilter filter,
    required String label,
  }) {
    final palette = _palette(context);
    final isSelected = _selectedFilter == filter;

    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: () {
        if (_selectedFilter == filter) {
          return;
        }
        setState(() => _selectedFilter = filter);
      },
      child: AnimatedContainer(
        duration: AppConstants.shortDuration,
        padding: EdgeInsets.symmetric(
          horizontal: metrics.px(12),
          vertical: metrics.px(8),
        ),
        decoration: BoxDecoration(
          color: isSelected ? palette.accent : palette.surface,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: isSelected ? palette.accent : palette.cardBorder,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: isSelected ? palette.buttonForeground : palette.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: metrics.fs(12),
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryList(_ProfileHistoryMetrics metrics) {
    final items = _filteredHistory;

    if (items.isEmpty) {
      return Center(
        child: Text(
          'Không có giao dịch nào.',
          style: AppTextStyles.bodySmall.copyWith(
            color: _palette(context).textMuted,
          ),
        ),
      );
    }

    return Column(
      children: items
          .map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: metrics.px(8)),
              child: _buildHistoryTile(metrics, item),
            ),
          )
          .toList(growable: false),
    );
  }

  Widget _buildHistoryTile(
    _ProfileHistoryMetrics metrics,
    HistoryItemModel item,
  ) {
    final palette = _palette(context);
    final statusColor = item.isSuccess ? palette.tealAccent : palette.warning;

    return Container(
      padding: EdgeInsets.fromLTRB(
        metrics.px(12),
        metrics.px(11),
        metrics.px(12),
        metrics.px(11),
      ),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(metrics.px(15)),
        border: Border.all(color: palette.cardBorder),
      ),
      child: Row(
        children: [
          Container(
            width: metrics.px(34),
            height: metrics.px(34),
            decoration: BoxDecoration(
              color: palette.iconContainer,
              borderRadius: BorderRadius.circular(metrics.px(10)),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.directions_car_filled_outlined,
              color: palette.accent,
              size: metrics.px(17),
            ),
          ),
          SizedBox(width: metrics.px(10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.subtitle,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: palette.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: metrics.fs(14),
                  ),
                ),
                SizedBox(height: metrics.px(2)),
                Text(
                  item.title,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: palette.textSecondary,
                    fontSize: metrics.fs(12),
                  ),
                ),
                SizedBox(height: metrics.px(4)),
                Text(
                  _formatDate(item.date),
                  style: AppTextStyles.labelSmall.copyWith(
                    color: palette.textMuted,
                    fontSize: metrics.fs(10.5),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: metrics.px(8)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatAmount(item.amount),
                style: AppTextStyles.titleSmall.copyWith(
                  color: palette.accent,
                  fontWeight: FontWeight.w800,
                  fontSize: metrics.fs(14),
                ),
              ),
              SizedBox(height: metrics.px(4)),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: metrics.px(8),
                  vertical: metrics.px(4),
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  _statusLabel(item.status),
                  style: AppTextStyles.labelSmall.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w700,
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

class _ProfileHistoryPalette {
  final Color background;
  final Color gradientTop;
  final Color gradientBottom;
  final Color surface;
  final Color accent;
  final Color tealAccent;
  final Color warning;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color cardBorder;
  final Color iconContainer;
  final Color buttonForeground;

  const _ProfileHistoryPalette({
    required this.background,
    required this.gradientTop,
    required this.gradientBottom,
    required this.surface,
    required this.accent,
    required this.tealAccent,
    required this.warning,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.cardBorder,
    required this.iconContainer,
    required this.buttonForeground,
  });

  factory _ProfileHistoryPalette.fromTheme(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;

    return _ProfileHistoryPalette(
      background: isDark ? const Color(0xFF07080A) : const Color(0xFFF4F7FB),
      gradientTop: isDark ? const Color(0xFF14161A) : const Color(0xFFFBFCFF),
      gradientBottom: isDark
          ? const Color(0xFF060709)
          : const Color(0xFFEEF2F8),
      surface: isDark ? const Color(0xFF16181D) : Colors.white,
      accent: const Color(0xFFD8AD48),
      tealAccent: const Color(0xFF09B7A3),
      warning: const Color(0xFFE07A3F),
      textPrimary: onSurface,
      textSecondary: onSurface.withValues(alpha: isDark ? 0.65 : 0.7),
      textMuted: onSurface.withValues(alpha: isDark ? 0.52 : 0.58),
      cardBorder: isDark
          ? Colors.white.withValues(alpha: 0.07)
          : Colors.black.withValues(alpha: 0.08),
      iconContainer: isDark
          ? Colors.white.withValues(alpha: 0.03)
          : Colors.black.withValues(alpha: 0.03),
      buttonForeground: const Color(0xFF1A1710),
    );
  }
}

class _ProfileHistoryMetrics {
  final double scale;
  final double textScale;

  const _ProfileHistoryMetrics._({
    required this.scale,
    required this.textScale,
  });

  factory _ProfileHistoryMetrics.fromWidth(double width) {
    final rawScale = width / 390;
    return _ProfileHistoryMetrics._(
      scale: rawScale.clamp(0.88, 1.14).toDouble(),
      textScale: rawScale.clamp(0.92, 1.09).toDouble(),
    );
  }

  double px(double value) => value * scale;

  double fs(double value) => value * textScale;
}
