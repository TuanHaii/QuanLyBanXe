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
import '../models/notification_item_model.dart';
// Nap thu vien hoac module can thiet.
import '../services/notification_service.dart';
// Nap thu vien hoac module can thiet.
import '../widgets/notification_card.dart';
// Nap thu vien hoac module can thiet.
import '../widgets/notification_filter_chip.dart';

// Dinh nghia kieu liet ke _NotificationTab.
enum _NotificationTab { all, transaction, inventory, report, other }

// Dinh nghia lop NotificationScreen de gom nhom logic lien quan.
class NotificationScreen extends StatefulWidget {
  // Khai bao bien NotificationScreen de luu du lieu su dung trong xu ly.
  const NotificationScreen({super.key});

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Thuc thi cau lenh hien tai theo luong xu ly.
  State<NotificationScreen> createState() => _NotificationScreenState();
}

// Dinh nghia lop _NotificationScreenState de gom nhom logic lien quan.
class _NotificationScreenState extends State<NotificationScreen>
    // Thuc thi cau lenh hien tai theo luong xu ly.
    with SingleTickerProviderStateMixin {
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const Duration _cardsAnimationDuration = Duration(milliseconds: 780);

  // Dinh nghia ham _palette de xu ly nghiep vu tuong ung.
  _NotificationPalette _palette(BuildContext context) {
    // Tra ve ket qua cho noi goi ham.
    return _NotificationPalette.fromTheme(Theme.of(context));
  }

  // Khai bao bien NotificationService de luu du lieu su dung trong xu ly.
  final NotificationService _notificationService = getIt<NotificationService>();
  // Khai bao bien final de luu du lieu su dung trong xu ly.
  late final AnimationController _cardsAnimationController;

  // Khai bao bien _notifications de luu du lieu su dung trong xu ly.
  List<NotificationItem> _notifications = [];
  // Thuc thi cau lenh hien tai theo luong xu ly.
  _NotificationTab _selectedTab = _NotificationTab.all;
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
    // Gan gia tri cho bien _cardsAnimationController.
    _cardsAnimationController = AnimationController(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      vsync: this,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      duration: _cardsAnimationDuration,
    );
    // Khai bao constructor _loadNotifications de khoi tao doi tuong.
    _loadNotifications();
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Dinh nghia ham dispose de xu ly nghiep vu tuong ung.
  void dispose() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    _cardsAnimationController.dispose();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.dispose();
  }

  // Khai bao bien _loadNotifications de luu du lieu su dung trong xu ly.
  Future<void> _loadNotifications({bool showLoader = true}) async {
    // Kiem tra dieu kien de re nhanh xu ly.
    if (showLoader) {
      // Cap nhat state de giao dien duoc render lai.
      setState(() {
        // Gan gia tri cho bien _isLoading.
        _isLoading = true;
        // Gan gia tri cho bien _errorMessage.
        _errorMessage = null;
      });
    }

    // Bao boc khoi lenh co the phat sinh loi de xu ly an toan.
    try {
      // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
      final notifications = await _notificationService.fetchNotifications();
      // Kiem tra dieu kien de re nhanh xu ly.
      if (!mounted) {
        // Tra ve ket qua cho noi goi ham.
        return;
      }

      // Cap nhat state de giao dien duoc render lai.
      setState(() {
        // Gan gia tri cho bien _notifications.
        _notifications = notifications;
        // Gan gia tri cho bien _errorMessage.
        _errorMessage = null;
      });
      // Khai bao constructor _playCardsIntro de khoi tao doi tuong.
      _playCardsIntro();
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } catch (_) {
      // Kiem tra dieu kien de re nhanh xu ly.
      if (!mounted) {
        // Tra ve ket qua cho noi goi ham.
        return;
      }

      // Cap nhat state de giao dien duoc render lai.
      setState(() {
        // Gan gia tri cho bien _errorMessage.
        _errorMessage = 'Không thể tải thông báo. Vui lòng thử lại.';
      });
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } finally {
      // Kiem tra dieu kien de re nhanh xu ly.
      if (mounted && showLoader) {
        // Cap nhat state de giao dien duoc render lai.
        setState(() {
          // Gan gia tri cho bien _isLoading.
          _isLoading = false;
        });
      }
    }
  }

  // Dinh nghia ham _playCardsIntro de xu ly nghiep vu tuong ung.
  void _playCardsIntro() {
    // Kiem tra dieu kien de re nhanh xu ly.
    if (!mounted) {
      // Tra ve ket qua cho noi goi ham.
      return;
    }

    // Thuc thi cau lenh hien tai theo luong xu ly.
    _cardsAnimationController
      // Thuc thi cau lenh hien tai theo luong xu ly.
      ..stop()
      // Thuc thi cau lenh hien tai theo luong xu ly.
      ..value = 0
      // Thuc thi cau lenh hien tai theo luong xu ly.
      ..forward();
  }

  // Dinh nghia ham _onBottomTabSelected de xu ly nghiep vu tuong ung.
  void _onBottomTabSelected(int index) {
    // Bat dau re nhanh theo nhieu truong hop gia tri.
    switch (index) {
      // Xu ly mot truong hop cu the trong switch.
      case 0:
        // Thuc thi cau lenh hien tai theo luong xu ly.
        context.go(RouteNames.dashboard);
        // Tra ve ket qua cho noi goi ham.
        return;
      // Xu ly mot truong hop cu the trong switch.
      case 1:
        // Thuc thi cau lenh hien tai theo luong xu ly.
        context.go(RouteNames.mall);
        // Tra ve ket qua cho noi goi ham.
        return;
      // Xu ly mot truong hop cu the trong switch.
      case 2:
        // Tra ve ket qua cho noi goi ham.
        return;
      // Xu ly mot truong hop cu the trong switch.
      case 3:
        // Thuc thi cau lenh hien tai theo luong xu ly.
        context.go(RouteNames.profile);
        // Tra ve ket qua cho noi goi ham.
        return;
    }
  }

  // Dinh nghia ham _markAllAsRead de xu ly nghiep vu tuong ung.
  void _markAllAsRead() {
    // Kiem tra dieu kien de re nhanh xu ly.
    if (_unreadCount == 0) {
      // Tra ve ket qua cho noi goi ham.
      return;
    }

    // Cap nhat state de giao dien duoc render lai.
    setState(() {
      // Gan gia tri cho bien _notifications.
      _notifications = _notifications
          // Thuc thi cau lenh hien tai theo luong xu ly.
          .map((item) => item.copyWith(isRead: true))
          // Thuc thi cau lenh hien tai theo luong xu ly.
          .toList(growable: false);
    });
  }

  // Dinh nghia ham _markAsRead de xu ly nghiep vu tuong ung.
  void _markAsRead(String id) {
    // Khai bao bien hasUnreadMatch de luu du lieu su dung trong xu ly.
    final hasUnreadMatch = _notifications.any(
      // Thuc thi cau lenh hien tai theo luong xu ly.
      (entry) => entry.id == id && !entry.isRead,
    );

    // Kiem tra dieu kien de re nhanh xu ly.
    if (!hasUnreadMatch) {
      // Tra ve ket qua cho noi goi ham.
      return;
    }

    // Cap nhat state de giao dien duoc render lai.
    setState(() {
      // Gan gia tri cho bien _notifications.
      _notifications = _notifications
          // Thuc thi cau lenh hien tai theo luong xu ly.
          .map((entry) => entry.id == id ? entry.copyWith(isRead: true) : entry)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          .toList(growable: false);
    });
  }

  // Dinh nghia ham _handleNotificationTap de xu ly nghiep vu tuong ung.
  void _handleNotificationTap(NotificationItem notification) {
    // Khai bao constructor _markAsRead de khoi tao doi tuong.
    _markAsRead(notification.id);

    // Bat dau re nhanh theo nhieu truong hop gia tri.
    switch (notification.category) {
      // Xu ly mot truong hop cu the trong switch.
      case NotificationCategory.transaction:
        // Thuc thi cau lenh hien tai theo luong xu ly.
        context.go(RouteNames.sales);
        // Tra ve ket qua cho noi goi ham.
        return;
      // Xu ly mot truong hop cu the trong switch.
      case NotificationCategory.inventory:
        // Thuc thi cau lenh hien tai theo luong xu ly.
        context.go(RouteNames.carList);
        // Tra ve ket qua cho noi goi ham.
        return;
      // Xu ly mot truong hop cu the trong switch.
      case NotificationCategory.report:
        // Thuc thi cau lenh hien tai theo luong xu ly.
        context.go(RouteNames.dashboard);
        // Tra ve ket qua cho noi goi ham.
        return;
      // Xu ly mot truong hop cu the trong switch.
      case NotificationCategory.promotion:
      // Xu ly mot truong hop cu the trong switch.
      case NotificationCategory.market:
        // Thuc thi cau lenh hien tai theo luong xu ly.
        context.go(RouteNames.mall);
        // Tra ve ket qua cho noi goi ham.
        return;
      // Xu ly mot truong hop cu the trong switch.
      case NotificationCategory.customer:
      // Xu ly mot truong hop cu the trong switch.
      case NotificationCategory.system:
        // Thuc thi cau lenh hien tai theo luong xu ly.
        context.go(RouteNames.profile);
        // Tra ve ket qua cho noi goi ham.
        return;
    }
  }

  // Khai bao bien get de luu du lieu su dung trong xu ly.
  int get _unreadCount {
    // Tra ve ket qua cho noi goi ham.
    return _notifications.where((item) => !item.isRead).length;
  }

  // Khai bao bien get de luu du lieu su dung trong xu ly.
  List<NotificationItem> get _filteredNotifications {
    // Tra ve ket qua cho noi goi ham.
    return _notifications.where((item) => _matchesCurrentTab(item)).toList();
  }

  // Khai bao bien _matchesCurrentTab de luu du lieu su dung trong xu ly.
  bool _matchesCurrentTab(NotificationItem item) {
    // Bat dau re nhanh theo nhieu truong hop gia tri.
    switch (_selectedTab) {
      // Xu ly mot truong hop cu the trong switch.
      case _NotificationTab.all:
        // Tra ve ket qua cho noi goi ham.
        return true;
      // Xu ly mot truong hop cu the trong switch.
      case _NotificationTab.transaction:
        // Tra ve ket qua cho noi goi ham.
        return item.category == NotificationCategory.transaction;
      // Xu ly mot truong hop cu the trong switch.
      case _NotificationTab.inventory:
        // Tra ve ket qua cho noi goi ham.
        return item.category == NotificationCategory.inventory;
      // Xu ly mot truong hop cu the trong switch.
      case _NotificationTab.report:
        // Tra ve ket qua cho noi goi ham.
        return item.category == NotificationCategory.report;
      // Xu ly mot truong hop cu the trong switch.
      case _NotificationTab.other:
        // Tra ve ket qua cho noi goi ham.
        return item.category != NotificationCategory.transaction &&
            // Thuc thi cau lenh hien tai theo luong xu ly.
            item.category != NotificationCategory.inventory &&
            // Thuc thi cau lenh hien tai theo luong xu ly.
            item.category != NotificationCategory.report;
    }
  }

  // Khai bao bien _tabLabel de luu du lieu su dung trong xu ly.
  String _tabLabel(_NotificationTab tab) {
    // Bat dau re nhanh theo nhieu truong hop gia tri.
    switch (tab) {
      // Xu ly mot truong hop cu the trong switch.
      case _NotificationTab.all:
        // Tra ve ket qua cho noi goi ham.
        return 'Tất Cả';
      // Xu ly mot truong hop cu the trong switch.
      case _NotificationTab.transaction:
        // Tra ve ket qua cho noi goi ham.
        return 'Giao Dịch';
      // Xu ly mot truong hop cu the trong switch.
      case _NotificationTab.inventory:
        // Tra ve ket qua cho noi goi ham.
        return 'Kho Hàng';
      // Xu ly mot truong hop cu the trong switch.
      case _NotificationTab.report:
        // Tra ve ket qua cho noi goi ham.
        return 'Báo Cáo';
      // Xu ly mot truong hop cu the trong switch.
      case _NotificationTab.other:
        // Tra ve ket qua cho noi goi ham.
        return 'Khác';
    }
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Khai bao bien build de luu du lieu su dung trong xu ly.
  Widget build(BuildContext context) {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return Scaffold(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      backgroundColor: palette.background,
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
          bottom: false,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: RefreshIndicator(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: palette.accent,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            backgroundColor: palette.surface,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onRefresh: () => _loadNotifications(showLoader: false),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            child: CustomScrollView(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              physics: const BouncingScrollPhysics(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                parent: AlwaysScrollableScrollPhysics(),
              ),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              slivers: [
                // Goi ham de thuc thi tac vu can thiet.
                SliverToBoxAdapter(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  child: Padding(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    child: Column(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      children: [
                        // Goi ham de thuc thi tac vu can thiet.
                        _buildHeader(),
                        // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                        const SizedBox(height: 14),
                        // Goi ham de thuc thi tac vu can thiet.
                        _buildFilterTabs(),
                        // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
                // Kiem tra dieu kien de re nhanh xu ly.
                if (_isLoading)
                  // Goi ham de thuc thi tac vu can thiet.
                  SliverFillRemaining(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    hasScrollBody: false,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    child: Center(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      child: CircularProgressIndicator(color: palette.accent),
                    ),
                  )
                // Kiem tra them dieu kien khac khi nhanh truoc khong thoa.
                else if (_errorMessage != null)
                  // Goi ham de thuc thi tac vu can thiet.
                  SliverFillRemaining(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    hasScrollBody: false,
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
                          Text(
                            // Thuc thi cau lenh hien tai theo luong xu ly.
                            _errorMessage!,
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            textAlign: TextAlign.center,
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            style: AppTextStyles.bodyLarge.copyWith(
                              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                              color: palette.textSecondary,
                            ),
                          ),
                          // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                          const SizedBox(height: 12),
                          // Goi ham de thuc thi tac vu can thiet.
                          FilledButton(
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            onPressed: _loadNotifications,
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            style: FilledButton.styleFrom(
                              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                              backgroundColor: palette.accent,
                              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                              foregroundColor: palette.accentForeground,
                            ),
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            child: const Text('Thử lại'),
                          ),
                        ],
                      ),
                    ),
                  )
                // Kiem tra them dieu kien khac khi nhanh truoc khong thoa.
                else if (_filteredNotifications.isEmpty)
                  // Goi ham de thuc thi tac vu can thiet.
                  SliverFillRemaining(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    hasScrollBody: false,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    child: _buildEmptyState(),
                  )
                // Xu ly nhanh con lai khi dieu kien khong thoa.
                else
                  // Goi ham de thuc thi tac vu can thiet.
                  SliverPadding(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    sliver: SliverList.builder(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      itemCount: _filteredNotifications.length,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      itemBuilder: (context, index) {
                        // Khai bao bien notification de luu du lieu su dung trong xu ly.
                        final notification = _filteredNotifications[index];
                        // Tra ve ket qua cho noi goi ham.
                        return _buildAnimatedNotificationCard(
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          notification: notification,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          index: index,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          total: _filteredNotifications.length,
                        );
                      },
                    ),
                  ),
                // Khai bao bien SliverToBoxAdapter de luu du lieu su dung trong xu ly.
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
              ],
            ),
          ),
        ),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // Khai bao bien _buildHeader de luu du lieu su dung trong xu ly.
  Widget _buildHeader() {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Tra ve ket qua cho noi goi ham.
    return Row(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      children: [
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
                'Thông Báo',
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: AppTextStyles.headlineMedium.copyWith(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: palette.textPrimary,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontWeight: FontWeight.w800,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontSize: 34,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  height: 1,
                ),
              ),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 4),
              // Goi ham de thuc thi tac vu can thiet.
              Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                '$_unreadCount chưa đọc',
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: AppTextStyles.bodySmall.copyWith(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: palette.textSecondary,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        // Goi ham de thuc thi tac vu can thiet.
        TextButton(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          onPressed: _markAllAsRead,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          style: TextButton.styleFrom(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            foregroundColor: palette.accent,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            minimumSize: Size.zero,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            shape: RoundedRectangleBorder(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              borderRadius: BorderRadius.circular(999),
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              side: BorderSide(color: palette.accent.withValues(alpha: 0.72)),
            ),
          ),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Text(
            // Thuc thi cau lenh hien tai theo luong xu ly.
            'Đọc tất cả',
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            style: AppTextStyles.labelMedium.copyWith(
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              color: palette.accent,
              // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  // Khai bao bien _buildFilterTabs de luu du lieu su dung trong xu ly.
  Widget _buildFilterTabs() {
    // Tra ve ket qua cho noi goi ham.
    return SingleChildScrollView(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      scrollDirection: Axis.horizontal,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Row(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        children: _NotificationTab.values
            // Thuc thi cau lenh hien tai theo luong xu ly.
            .map((tab) {
              // Khai bao bien isSelected de luu du lieu su dung trong xu ly.
              final isSelected = tab == _selectedTab;
              // Tra ve ket qua cho noi goi ham.
              return Padding(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                padding: const EdgeInsets.only(right: 8),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: NotificationFilterChip(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  label: _tabLabel(tab),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  isSelected: isSelected,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  onTap: () {
                    // Kiem tra dieu kien de re nhanh xu ly.
                    if (_selectedTab == tab) {
                      // Tra ve ket qua cho noi goi ham.
                      return;
                    }
                    // Cap nhat state de giao dien duoc render lai.
                    setState(() => _selectedTab = tab);
                    // Khai bao constructor _playCardsIntro de khoi tao doi tuong.
                    _playCardsIntro();
                  },
                ),
              );
            })
            // Thuc thi cau lenh hien tai theo luong xu ly.
            .toList(growable: false),
      ),
    );
  }

  // Khai bao bien _buildBottomNavigationBar de luu du lieu su dung trong xu ly.
  Widget _buildBottomNavigationBar() {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);

    // Khai bao bien navItems de luu du lieu su dung trong xu ly.
    const navItems = [
      // Goi ham de thuc thi tac vu can thiet.
      _NotificationNavItem(icon: Icons.home_outlined, label: 'Trang Chủ'),
      // Goi ham de thuc thi tac vu can thiet.
      _NotificationNavItem(icon: Icons.shopping_bag_outlined, label: 'Mall'),
      // Goi ham de thuc thi tac vu can thiet.
      _NotificationNavItem(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        icon: Icons.notifications_none_rounded,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        label: 'Thông Báo',
      ),
      // Goi ham de thuc thi tac vu can thiet.
      _NotificationNavItem(icon: Icons.person_outline_rounded, label: 'Tôi'),
    ];

    // Tra ve ket qua cho noi goi ham.
    return Container(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      decoration: BoxDecoration(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        color: palette.navBackground,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        border: Border(top: BorderSide(color: palette.navBorder, width: 1)),
      ),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: SafeArea(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        top: false,
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: Padding(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          padding: const EdgeInsets.fromLTRB(8, 7, 8, 6),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Row(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: List.generate(navItems.length, (index) {
              // Khai bao bien item de luu du lieu su dung trong xu ly.
              final item = navItems[index];
              // Khai bao bien selectedIndex de luu du lieu su dung trong xu ly.
              const selectedIndex = 2;
              // Khai bao bien isSelected de luu du lieu su dung trong xu ly.
              final isSelected = index == selectedIndex;

              // Tra ve ket qua cho noi goi ham.
              return Expanded(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: InkWell(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  onTap: () => _onBottomTabSelected(index),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  borderRadius: BorderRadius.circular(12),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  child: AnimatedContainer(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    duration: AppConstants.shortDuration,
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    decoration: BoxDecoration(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      color: isSelected
                          // Thuc thi cau lenh hien tai theo luong xu ly.
                          ? palette.navSelectedBackground
                          // Thuc thi cau lenh hien tai theo luong xu ly.
                          : Colors.transparent,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      borderRadius: BorderRadius.circular(11),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      border: Border.all(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        color: isSelected
                            // Thuc thi cau lenh hien tai theo luong xu ly.
                            ? palette.navSelectedBorder
                            // Thuc thi cau lenh hien tai theo luong xu ly.
                            : Colors.transparent,
                      ),
                    ),
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    child: Column(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      mainAxisSize: MainAxisSize.min,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      children: [
                        // Goi ham de thuc thi tac vu can thiet.
                        Icon(
                          // Thuc thi cau lenh hien tai theo luong xu ly.
                          item.icon,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          size: 19,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          color: isSelected
                              // Thuc thi cau lenh hien tai theo luong xu ly.
                              ? palette.accent
                              // Thuc thi cau lenh hien tai theo luong xu ly.
                              : palette.navUnselected,
                        ),
                        // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
                        const SizedBox(height: 3),
                        // Goi ham de thuc thi tac vu can thiet.
                        Text(
                          // Thuc thi cau lenh hien tai theo luong xu ly.
                          item.label,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          style: AppTextStyles.labelSmall.copyWith(
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            color: isSelected
                                // Thuc thi cau lenh hien tai theo luong xu ly.
                                ? palette.accent
                                // Thuc thi cau lenh hien tai theo luong xu ly.
                                : palette.navUnselected,
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            fontWeight: isSelected
                                // Thuc thi cau lenh hien tai theo luong xu ly.
                                ? FontWeight.w700
                                // Thuc thi cau lenh hien tai theo luong xu ly.
                                : FontWeight.w500,
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
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

  // Khai bao bien _buildAnimatedNotificationCard de luu du lieu su dung trong xu ly.
  Widget _buildAnimatedNotificationCard({
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required NotificationItem notification,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required int index,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required int total,
  // Thuc thi cau lenh hien tai theo luong xu ly.
  }) {
    // Khai bao bien maxItemsForStagger de luu du lieu su dung trong xu ly.
    final maxItemsForStagger = total.clamp(1, 12);
    // Khai bao bien step de luu du lieu su dung trong xu ly.
    final step = 0.58 / maxItemsForStagger;
    // Khai bao bien start de luu du lieu su dung trong xu ly.
    final start = (index * step).clamp(0, 0.84).toDouble();
    // Khai bao bien end de luu du lieu su dung trong xu ly.
    final end = (start + 0.34).clamp(start + 0.01, 1.0).toDouble();

    // Khai bao bien animation de luu du lieu su dung trong xu ly.
    final animation = CurvedAnimation(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      parent: _cardsAnimationController,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );

    // Tra ve ket qua cho noi goi ham.
    return FadeTransition(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      opacity: animation,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: SlideTransition(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        position: Tween<Offset>(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          begin: const Offset(0, 0.08),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          end: Offset.zero,
        // Thuc thi cau lenh hien tai theo luong xu ly.
        ).animate(animation),
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: Padding(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          padding: const EdgeInsets.only(bottom: 10),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: NotificationCard(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            notification: notification,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            onTap: () => _handleNotificationTap(notification),
          ),
        ),
      ),
    );
  }

  // Khai bao bien _buildEmptyState de luu du lieu su dung trong xu ly.
  Widget _buildEmptyState() {
    // Khai bao bien palette de luu du lieu su dung trong xu ly.
    final palette = _palette(context);
    // Khai bao bien isAllTab de luu du lieu su dung trong xu ly.
    final isAllTab = _selectedTab == _NotificationTab.all;

    // Tra ve ket qua cho noi goi ham.
    return Padding(
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      padding: const EdgeInsets.symmetric(horizontal: 18),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      child: Center(
        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
        child: Container(
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          width: double.infinity,
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          constraints: const BoxConstraints(maxWidth: 420),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          decoration: BoxDecoration(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            color: palette.surface,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            borderRadius: BorderRadius.circular(22),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            border: Border.all(color: palette.cardBorder),
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            boxShadow: [
              // Goi ham de thuc thi tac vu can thiet.
              BoxShadow(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                color: Colors.black.withValues(alpha: palette.shadowAlpha),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                blurRadius: 22,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                offset: const Offset(0, 14),
              ),
            ],
          ),
          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
          child: Column(
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            mainAxisSize: MainAxisSize.min,
            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
            children: [
              // Goi ham de thuc thi tac vu can thiet.
              Container(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                width: 74,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                height: 74,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                decoration: BoxDecoration(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  shape: BoxShape.circle,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  gradient: RadialGradient(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    colors: [
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      palette.accent.withValues(alpha: 0.27),
                      // Thuc thi cau lenh hien tai theo luong xu ly.
                      palette.accent.withValues(alpha: 0.05),
                    ],
                  ),
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  border: Border.all(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    color: palette.accent.withValues(alpha: 0.36),
                  ),
                ),
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                child: Icon(
                  // Thuc thi cau lenh hien tai theo luong xu ly.
                  Icons.notifications_none_rounded,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  size: 34,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: palette.accent,
                ),
              ),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 14),
              // Goi ham de thuc thi tac vu can thiet.
              Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                isAllTab
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    ? 'Hộp thư thông báo đang trống'
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    : 'Không có thông báo cho mục ${_tabLabel(_selectedTab)}',
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                textAlign: TextAlign.center,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: AppTextStyles.titleLarge.copyWith(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: palette.textPrimary,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontWeight: FontWeight.w700,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontSize: 20,
                ),
              ),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 8),
              // Goi ham de thuc thi tac vu can thiet.
              Text(
                // Thuc thi cau lenh hien tai theo luong xu ly.
                isAllTab
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    ? 'Khi có giao dịch, tồn kho hoặc báo cáo mới, PRECISION sẽ hiển thị tại đây.'
                    // Thuc thi cau lenh hien tai theo luong xu ly.
                    : 'Thử chuyển sang mục khác hoặc làm mới để kiểm tra thông báo mới nhất.',
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                textAlign: TextAlign.center,
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                style: AppTextStyles.bodyMedium.copyWith(
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  color: palette.textSecondary,
                  // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                  fontSize: 13,
                ),
              ),
              // Khai bao bien SizedBox de luu du lieu su dung trong xu ly.
              const SizedBox(height: 14),
              // Goi ham de thuc thi tac vu can thiet.
              Row(
                // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                children: [
                  // Kiem tra dieu kien de re nhanh xu ly.
                  if (!isAllTab)
                    // Goi ham de thuc thi tac vu can thiet.
                    Expanded(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      child: OutlinedButton(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        onPressed: () {
                          // Cap nhat state de giao dien duoc render lai.
                          setState(() => _selectedTab = _NotificationTab.all);
                          // Khai bao constructor _playCardsIntro de khoi tao doi tuong.
                          _playCardsIntro();
                        },
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        style: OutlinedButton.styleFrom(
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          foregroundColor: palette.textPrimary,
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          side: BorderSide(color: palette.buttonOutline),
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          shape: RoundedRectangleBorder(
                            // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        child: const Text('Xem tất cả'),
                      ),
                    ),
                  // Kiem tra dieu kien de re nhanh xu ly.
                  if (!isAllTab) const SizedBox(width: 10),
                  // Goi ham de thuc thi tac vu can thiet.
                  Expanded(
                    // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                    child: FilledButton(
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      onPressed: _loadNotifications,
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      style: FilledButton.styleFrom(
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        backgroundColor: palette.accent,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        foregroundColor: palette.accentForeground,
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                        shape: RoundedRectangleBorder(
                          // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
                      child: const Text(
                        // Thuc thi cau lenh hien tai theo luong xu ly.
                        'Làm mới',
                        // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
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

// Dinh nghia lop _NotificationNavItem de gom nhom logic lien quan.
class _NotificationNavItem {
  // Khai bao bien IconData de luu du lieu su dung trong xu ly.
  final IconData icon;
  // Khai bao bien String de luu du lieu su dung trong xu ly.
  final String label;

  // Khai bao bien _NotificationNavItem de luu du lieu su dung trong xu ly.
  const _NotificationNavItem({required this.icon, required this.label});
}

// Dinh nghia lop _NotificationPalette de gom nhom logic lien quan.
class _NotificationPalette {
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
  final Color accentForeground;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color textPrimary;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color textSecondary;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color cardBorder;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color navBackground;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color navBorder;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color navSelectedBackground;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color navSelectedBorder;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color navUnselected;
  // Khai bao bien Color de luu du lieu su dung trong xu ly.
  final Color buttonOutline;
  // Khai bao bien double de luu du lieu su dung trong xu ly.
  final double shadowAlpha;

  // Khai bao bien _NotificationPalette de luu du lieu su dung trong xu ly.
  const _NotificationPalette({
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
    required this.accentForeground,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.textPrimary,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.textSecondary,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.cardBorder,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.navBackground,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.navBorder,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.navSelectedBackground,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.navSelectedBorder,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.navUnselected,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.buttonOutline,
    // Thuc thi cau lenh hien tai theo luong xu ly.
    required this.shadowAlpha,
  });

  // Thuc thi cau lenh hien tai theo luong xu ly.
  factory _NotificationPalette.fromTheme(ThemeData theme) {
    // Khai bao bien isDark de luu du lieu su dung trong xu ly.
    final isDark = theme.brightness == Brightness.dark;
    // Khai bao bien onSurface de luu du lieu su dung trong xu ly.
    final onSurface = theme.colorScheme.onSurface;
    // Khai bao bien accent de luu du lieu su dung trong xu ly.
    const accent = Color(0xFFD6A93E);

    // Tra ve ket qua cho noi goi ham.
    return _NotificationPalette(
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
      surface: isDark ? const Color(0xFF15181D) : Colors.white,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      accent: accent,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      accentForeground: isDark ? Colors.black : const Color(0xFF2D230F),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      textPrimary: onSurface,
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      textSecondary: onSurface.withValues(alpha: isDark ? 0.66 : 0.72),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      cardBorder: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? Colors.white.withValues(alpha: 0.08)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : Colors.black.withValues(alpha: 0.08),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      navBackground: isDark ? const Color(0xFF111317) : const Color(0xFFF9FBFF),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      navBorder: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? Colors.white.withValues(alpha: 0.06)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : Colors.black.withValues(alpha: 0.08),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      navSelectedBackground: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? const Color(0xFF191B1F)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : const Color(0xFFF3E8CD),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      navSelectedBorder: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? Colors.white.withValues(alpha: 0.72)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : const Color(0xFFC89B34).withValues(alpha: 0.52),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      navUnselected: onSurface.withValues(alpha: isDark ? 0.62 : 0.58),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      buttonOutline: isDark
          // Thuc thi cau lenh hien tai theo luong xu ly.
          ? Colors.white.withValues(alpha: 0.18)
          // Thuc thi cau lenh hien tai theo luong xu ly.
          : Colors.black.withValues(alpha: 0.14),
      // Thiet lap thuoc tinh cho doi tuong hoac giao dien.
      shadowAlpha: isDark ? 0.35 : 0.12,
    );
  }
}
