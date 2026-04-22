import 'package:flutter/material.dart';

import '../../../shared/constants/app_constants.dart';
import '../../../shared/themes/app_colors.dart';

enum _HistoryFilter { all, success, pending }

class ProfileHistoryScreen extends StatefulWidget {
  const ProfileHistoryScreen({super.key});

  @override
  State<ProfileHistoryScreen> createState() => _ProfileHistoryScreenState();
}

class _ProfileHistoryScreenState extends State<ProfileHistoryScreen> {
  static const Color _backgroundColor = Color(0xFF07080A);
  static const Color _surfaceColor = Color(0xFF16181D);
  static const Color _accentColor = Color(0xFFD8AD48);
  static const Color _tealAccentColor = Color(0xFF09B7A3);
  static const Color _warningColor = Color(0xFFE07A3F);

  _HistoryFilter _selectedFilter = _HistoryFilter.all;

  static const List<_HistoryItem> _historyItems = [
    _HistoryItem(
      customerName: 'Nguyễn Minh Khang',
      carName: 'Mercedes C300 2024',
      amount: '\$72,000',
      status: 'Thành công',
      dateLabel: 'Hôm nay, 09:42',
      isSuccess: true,
    ),
    _HistoryItem(
      customerName: 'Lê Bảo Trâm',
      carName: 'VinFast VF 8 Plus',
      amount: '\$53,200',
      status: 'Đang chờ cọc',
      dateLabel: 'Hôm qua, 16:15',
      isSuccess: false,
    ),
    _HistoryItem(
      customerName: 'Trần Quốc Nam',
      carName: 'Toyota Camry 2.5Q',
      amount: '\$46,900',
      status: 'Thành công',
      dateLabel: '20/04, 11:06',
      isSuccess: true,
    ),
    _HistoryItem(
      customerName: 'Phạm Diễm My',
      carName: 'Mazda CX-5 Premium',
      amount: '\$39,500',
      status: 'Đang chờ duyệt',
      dateLabel: '19/04, 14:28',
      isSuccess: false,
    ),
  ];

  List<_HistoryItem> get _filteredHistory {
    switch (_selectedFilter) {
      case _HistoryFilter.all:
        return _historyItems;
      case _HistoryFilter.success:
        return _historyItems.where((item) => item.isSuccess).toList();
      case _HistoryFilter.pending:
        return _historyItems.where((item) => !item.isSuccess).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final metrics = _ProfileHistoryMetrics.fromWidth(
      MediaQuery.sizeOf(context).width,
    );

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Lịch Sử Giao Dịch',
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

  Widget _buildSummary(_ProfileHistoryMetrics metrics) {
    final successfulCount = _historyItems
        .where((item) => item.isSuccess)
        .length;
    final pendingCount = _historyItems.length - successfulCount;

    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            metrics: metrics,
            icon: Icons.receipt_long_outlined,
            value: '${_historyItems.length}',
            label: 'Tổng giao dịch',
            accentColor: _accentColor,
          ),
        ),
        SizedBox(width: metrics.px(8)),
        Expanded(
          child: _buildSummaryCard(
            metrics: metrics,
            icon: Icons.check_circle_outline,
            value: '$successfulCount',
            label: 'Thành công',
            accentColor: _tealAccentColor,
          ),
        ),
        SizedBox(width: metrics.px(8)),
        Expanded(
          child: _buildSummaryCard(
            metrics: metrics,
            icon: Icons.timelapse_rounded,
            value: '$pendingCount',
            label: 'Đang chờ',
            accentColor: _warningColor,
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
    return Container(
      padding: EdgeInsets.fromLTRB(
        metrics.px(10),
        metrics.px(10),
        metrics.px(10),
        metrics.px(9),
      ),
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(metrics.px(14)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accentColor, size: metrics.px(15)),
          SizedBox(height: metrics.px(6)),
          Text(
            value,
            style: AppTextStyles.titleLarge.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: metrics.fs(24),
              height: 1,
            ),
          ),
          SizedBox(height: metrics.px(3)),
          Text(
            label,
            style: AppTextStyles.labelMedium.copyWith(
              color: Colors.white.withValues(alpha: 0.55),
              fontSize: metrics.fs(10.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String text, _ProfileHistoryMetrics metrics) {
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
          color: isSelected ? _accentColor : _surfaceColor,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: isSelected
                ? _accentColor
                : Colors.white.withValues(alpha: 0.07),
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: isSelected ? const Color(0xFF1A1710) : Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: metrics.fs(12),
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryList(_ProfileHistoryMetrics metrics) {
    final items = _filteredHistory;

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

  Widget _buildHistoryTile(_ProfileHistoryMetrics metrics, _HistoryItem item) {
    final statusColor = item.isSuccess ? _tealAccentColor : _warningColor;

    return Container(
      padding: EdgeInsets.fromLTRB(
        metrics.px(12),
        metrics.px(11),
        metrics.px(12),
        metrics.px(11),
      ),
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(metrics.px(15)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      child: Row(
        children: [
          Container(
            width: metrics.px(34),
            height: metrics.px(34),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(metrics.px(10)),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.directions_car_filled_outlined,
              color: _accentColor,
              size: metrics.px(17),
            ),
          ),
          SizedBox(width: metrics.px(10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.customerName,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: metrics.fs(14),
                  ),
                ),
                SizedBox(height: metrics.px(2)),
                Text(
                  item.carName,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.62),
                    fontSize: metrics.fs(12),
                  ),
                ),
                SizedBox(height: metrics.px(4)),
                Text(
                  item.dateLabel,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.5),
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
                item.amount,
                style: AppTextStyles.titleSmall.copyWith(
                  color: _accentColor,
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
                  item.status,
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

class _HistoryItem {
  final String customerName;
  final String carName;
  final String amount;
  final String status;
  final String dateLabel;
  final bool isSuccess;

  const _HistoryItem({
    required this.customerName,
    required this.carName,
    required this.amount,
    required this.status,
    required this.dateLabel,
    required this.isSuccess,
  });
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
