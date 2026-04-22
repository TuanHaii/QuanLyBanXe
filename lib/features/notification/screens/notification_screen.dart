import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/constants/app_constants.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/themes/app_colors.dart';
import '../models/notification_item_model.dart';
import '../services/notification_service.dart';
import '../widgets/notification_card.dart';
import '../widgets/notification_filter_chip.dart';

enum _NotificationTab { all, transaction, inventory, report, other }

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  static const Duration _cardsAnimationDuration = Duration(milliseconds: 780);

  _NotificationPalette _palette(BuildContext context) {
    return _NotificationPalette.fromTheme(Theme.of(context));
  }

  final NotificationService _notificationService = getIt<NotificationService>();
  late final AnimationController _cardsAnimationController;

  List<NotificationItem> _notifications = [];
  _NotificationTab _selectedTab = _NotificationTab.all;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _cardsAnimationController = AnimationController(
      vsync: this,
      duration: _cardsAnimationDuration,
    );
    _loadNotifications();
  }

  @override
  void dispose() {
    _cardsAnimationController.dispose();
    super.dispose();
  }

  Future<void> _loadNotifications({bool showLoader = true}) async {
    if (showLoader) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
    }

    try {
      final notifications = await _notificationService.fetchNotifications();
      if (!mounted) {
        return;
      }

      setState(() {
        _notifications = notifications;
        _errorMessage = null;
      });
      _playCardsIntro();
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _errorMessage = 'Không thể tải thông báo. Vui lòng thử lại.';
      });
    } finally {
      if (mounted && showLoader) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _playCardsIntro() {
    if (!mounted) {
      return;
    }

    _cardsAnimationController
      ..stop()
      ..value = 0
      ..forward();
  }

  void _onBottomTabSelected(int index) {
    switch (index) {
      case 0:
        context.go(RouteNames.dashboard);
        return;
      case 1:
        context.go(RouteNames.mall);
        return;
      case 2:
        return;
      case 3:
        context.go(RouteNames.profile);
        return;
    }
  }

  void _markAllAsRead() {
    if (_unreadCount == 0) {
      return;
    }

    setState(() {
      _notifications = _notifications
          .map((item) => item.copyWith(isRead: true))
          .toList(growable: false);
    });
  }

  void _markAsRead(String id) {
    final hasUnreadMatch = _notifications.any(
      (entry) => entry.id == id && !entry.isRead,
    );

    if (!hasUnreadMatch) {
      return;
    }

    setState(() {
      _notifications = _notifications
          .map((entry) => entry.id == id ? entry.copyWith(isRead: true) : entry)
          .toList(growable: false);
    });
  }

  void _handleNotificationTap(NotificationItem notification) {
    _markAsRead(notification.id);

    switch (notification.category) {
      case NotificationCategory.transaction:
        context.go(RouteNames.sales);
        return;
      case NotificationCategory.inventory:
        context.go(RouteNames.carList);
        return;
      case NotificationCategory.report:
        context.go(RouteNames.dashboard);
        return;
      case NotificationCategory.promotion:
      case NotificationCategory.market:
        context.go(RouteNames.mall);
        return;
      case NotificationCategory.customer:
      case NotificationCategory.system:
        context.go(RouteNames.profile);
        return;
    }
  }

  int get _unreadCount {
    return _notifications.where((item) => !item.isRead).length;
  }

  List<NotificationItem> get _filteredNotifications {
    return _notifications.where((item) => _matchesCurrentTab(item)).toList();
  }

  bool _matchesCurrentTab(NotificationItem item) {
    switch (_selectedTab) {
      case _NotificationTab.all:
        return true;
      case _NotificationTab.transaction:
        return item.category == NotificationCategory.transaction;
      case _NotificationTab.inventory:
        return item.category == NotificationCategory.inventory;
      case _NotificationTab.report:
        return item.category == NotificationCategory.report;
      case _NotificationTab.other:
        return item.category != NotificationCategory.transaction &&
            item.category != NotificationCategory.inventory &&
            item.category != NotificationCategory.report;
    }
  }

  String _tabLabel(_NotificationTab tab) {
    switch (tab) {
      case _NotificationTab.all:
        return 'Tất Cả';
      case _NotificationTab.transaction:
        return 'Giao Dịch';
      case _NotificationTab.inventory:
        return 'Kho Hàng';
      case _NotificationTab.report:
        return 'Báo Cáo';
      case _NotificationTab.other:
        return 'Khác';
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = _palette(context);

    return Scaffold(
      backgroundColor: palette.background,
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [palette.gradientTop, palette.gradientBottom],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: RefreshIndicator(
            color: palette.accent,
            backgroundColor: palette.surface,
            onRefresh: () => _loadNotifications(showLoader: false),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 14),
                        _buildFilterTabs(),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
                if (_isLoading)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: CircularProgressIndicator(color: palette.accent),
                    ),
                  )
                else if (_errorMessage != null)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _errorMessage!,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: palette.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          FilledButton(
                            onPressed: _loadNotifications,
                            style: FilledButton.styleFrom(
                              backgroundColor: palette.accent,
                              foregroundColor: palette.accentForeground,
                            ),
                            child: const Text('Thử lại'),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (_filteredNotifications.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _buildEmptyState(),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    sliver: SliverList.builder(
                      itemCount: _filteredNotifications.length,
                      itemBuilder: (context, index) {
                        final notification = _filteredNotifications[index];
                        return _buildAnimatedNotificationCard(
                          notification: notification,
                          index: index,
                          total: _filteredNotifications.length,
                        );
                      },
                    ),
                  ),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    final palette = _palette(context);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thông Báo',
                style: AppTextStyles.headlineMedium.copyWith(
                  color: palette.textPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: 34,
                  height: 1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$_unreadCount chưa đọc',
                style: AppTextStyles.bodySmall.copyWith(
                  color: palette.textSecondary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: _markAllAsRead,
          style: TextButton.styleFrom(
            foregroundColor: palette.accent,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
              side: BorderSide(color: palette.accent.withValues(alpha: 0.72)),
            ),
          ),
          child: Text(
            'Đọc tất cả',
            style: AppTextStyles.labelMedium.copyWith(
              color: palette.accent,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _NotificationTab.values
            .map((tab) {
              final isSelected = tab == _selectedTab;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: NotificationFilterChip(
                  label: _tabLabel(tab),
                  isSelected: isSelected,
                  onTap: () {
                    if (_selectedTab == tab) {
                      return;
                    }
                    setState(() => _selectedTab = tab);
                    _playCardsIntro();
                  },
                ),
              );
            })
            .toList(growable: false),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    final palette = _palette(context);

    const navItems = [
      _NotificationNavItem(icon: Icons.home_outlined, label: 'Trang Chủ'),
      _NotificationNavItem(icon: Icons.shopping_bag_outlined, label: 'Mall'),
      _NotificationNavItem(
        icon: Icons.notifications_none_rounded,
        label: 'Thông Báo',
      ),
      _NotificationNavItem(icon: Icons.person_outline_rounded, label: 'Tôi'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: palette.navBackground,
        border: Border(top: BorderSide(color: palette.navBorder, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 7, 8, 6),
          child: Row(
            children: List.generate(navItems.length, (index) {
              final item = navItems[index];
              const selectedIndex = 2;
              final isSelected = index == selectedIndex;

              return Expanded(
                child: InkWell(
                  onTap: () => _onBottomTabSelected(index),
                  borderRadius: BorderRadius.circular(12),
                  child: AnimatedContainer(
                    duration: AppConstants.shortDuration,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? palette.navSelectedBackground
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(
                        color: isSelected
                            ? palette.navSelectedBorder
                            : Colors.transparent,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item.icon,
                          size: 19,
                          color: isSelected
                              ? palette.accent
                              : palette.navUnselected,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item.label,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: isSelected
                                ? palette.accent
                                : palette.navUnselected,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            fontSize: 10.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedNotificationCard({
    required NotificationItem notification,
    required int index,
    required int total,
  }) {
    final maxItemsForStagger = total.clamp(1, 12);
    final step = 0.58 / maxItemsForStagger;
    final start = (index * step).clamp(0, 0.84).toDouble();
    final end = (start + 0.34).clamp(start + 0.01, 1.0).toDouble();

    final animation = CurvedAnimation(
      parent: _cardsAnimationController,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.08),
          end: Offset.zero,
        ).animate(animation),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: NotificationCard(
            notification: notification,
            onTap: () => _handleNotificationTap(notification),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    final palette = _palette(context);
    final isAllTab = _selectedTab == _NotificationTab.all;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Center(
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 420),
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
          decoration: BoxDecoration(
            color: palette.surface,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: palette.cardBorder),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: palette.shadowAlpha),
                blurRadius: 22,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 74,
                height: 74,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      palette.accent.withValues(alpha: 0.27),
                      palette.accent.withValues(alpha: 0.05),
                    ],
                  ),
                  border: Border.all(
                    color: palette.accent.withValues(alpha: 0.36),
                  ),
                ),
                child: Icon(
                  Icons.notifications_none_rounded,
                  size: 34,
                  color: palette.accent,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                isAllTab
                    ? 'Hộp thư thông báo đang trống'
                    : 'Không có thông báo cho mục ${_tabLabel(_selectedTab)}',
                textAlign: TextAlign.center,
                style: AppTextStyles.titleLarge.copyWith(
                  color: palette.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isAllTab
                    ? 'Khi có giao dịch, tồn kho hoặc báo cáo mới, PRECISION sẽ hiển thị tại đây.'
                    : 'Thử chuyển sang mục khác hoặc làm mới để kiểm tra thông báo mới nhất.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: palette.textSecondary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  if (!isAllTab)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() => _selectedTab = _NotificationTab.all);
                          _playCardsIntro();
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: palette.textPrimary,
                          side: BorderSide(color: palette.buttonOutline),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text('Xem tất cả'),
                      ),
                    ),
                  if (!isAllTab) const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton(
                      onPressed: _loadNotifications,
                      style: FilledButton.styleFrom(
                        backgroundColor: palette.accent,
                        foregroundColor: palette.accentForeground,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Làm mới',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationNavItem {
  final IconData icon;
  final String label;

  const _NotificationNavItem({required this.icon, required this.label});
}

class _NotificationPalette {
  final Color background;
  final Color gradientTop;
  final Color gradientBottom;
  final Color surface;
  final Color accent;
  final Color accentForeground;
  final Color textPrimary;
  final Color textSecondary;
  final Color cardBorder;
  final Color navBackground;
  final Color navBorder;
  final Color navSelectedBackground;
  final Color navSelectedBorder;
  final Color navUnselected;
  final Color buttonOutline;
  final double shadowAlpha;

  const _NotificationPalette({
    required this.background,
    required this.gradientTop,
    required this.gradientBottom,
    required this.surface,
    required this.accent,
    required this.accentForeground,
    required this.textPrimary,
    required this.textSecondary,
    required this.cardBorder,
    required this.navBackground,
    required this.navBorder,
    required this.navSelectedBackground,
    required this.navSelectedBorder,
    required this.navUnselected,
    required this.buttonOutline,
    required this.shadowAlpha,
  });

  factory _NotificationPalette.fromTheme(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    const accent = Color(0xFFD6A93E);

    return _NotificationPalette(
      background: isDark ? const Color(0xFF07080A) : const Color(0xFFF4F7FB),
      gradientTop: isDark ? const Color(0xFF14161A) : const Color(0xFFFBFCFF),
      gradientBottom: isDark
          ? const Color(0xFF060709)
          : const Color(0xFFEEF2F8),
      surface: isDark ? const Color(0xFF15181D) : Colors.white,
      accent: accent,
      accentForeground: isDark ? Colors.black : const Color(0xFF2D230F),
      textPrimary: onSurface,
      textSecondary: onSurface.withValues(alpha: isDark ? 0.66 : 0.72),
      cardBorder: isDark
          ? Colors.white.withValues(alpha: 0.08)
          : Colors.black.withValues(alpha: 0.08),
      navBackground: isDark ? const Color(0xFF111317) : const Color(0xFFF9FBFF),
      navBorder: isDark
          ? Colors.white.withValues(alpha: 0.06)
          : Colors.black.withValues(alpha: 0.08),
      navSelectedBackground: isDark
          ? const Color(0xFF191B1F)
          : const Color(0xFFF3E8CD),
      navSelectedBorder: isDark
          ? Colors.white.withValues(alpha: 0.72)
          : const Color(0xFFC89B34).withValues(alpha: 0.52),
      navUnselected: onSurface.withValues(alpha: isDark ? 0.62 : 0.58),
      buttonOutline: isDark
          ? Colors.white.withValues(alpha: 0.18)
          : Colors.black.withValues(alpha: 0.14),
      shadowAlpha: isDark ? 0.35 : 0.12,
    );
  }
}
