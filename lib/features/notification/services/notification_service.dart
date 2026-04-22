import '../models/notification_item_model.dart';

class NotificationService {
  Future<List<NotificationItem>> fetchNotifications() async {
    await Future.delayed(const Duration(milliseconds: 220));

    return const [
      NotificationItem(
        id: 'n1',
        title: 'Giao dịch thành công',
        message: 'Toyota Camry 2024 đã được bán cho Nguyễn Văn A - 1.2 tỷ đồng',
        timeLabel: '5 phút trước',
        category: NotificationCategory.transaction,
        isRead: false,
      ),
      NotificationItem(
        id: 'n2',
        title: 'Cảnh báo tồn kho',
        message: 'Mercedes C200 chỉ còn 3 xe. Cần nhập thêm hàng ngay.',
        timeLabel: '30 phút trước',
        category: NotificationCategory.inventory,
        isRead: false,
      ),
      NotificationItem(
        id: 'n3',
        title: 'Báo cáo tuần',
        message:
            'Báo cáo doanh thu tuần này đã sẵn sàng. Tổng doanh thu \$4.2M, tăng 14%.',
        timeLabel: '2 giờ trước',
        category: NotificationCategory.report,
        isRead: false,
      ),
      NotificationItem(
        id: 'n4',
        title: 'Giao dịch thành công',
        message: 'Honda CR-V 2024 đã được bán cho Trần Thị B - 990 triệu đồng',
        timeLabel: '5 giờ trước',
        category: NotificationCategory.transaction,
        isRead: true,
      ),
      NotificationItem(
        id: 'n5',
        title: 'Chương trình khuyến mãi',
        message: 'Giảm 5% cho lô xe Mazda trong tháng này. Cập nhật giá ngay.',
        timeLabel: '1 ngày trước',
        category: NotificationCategory.promotion,
        isRead: true,
      ),
      NotificationItem(
        id: 'n6',
        title: 'Khách hàng mới',
        message: 'Lê Văn C đã đăng ký tư vấn cho BMW X3 2024.',
        timeLabel: '1 ngày trước',
        category: NotificationCategory.customer,
        isRead: true,
      ),
      NotificationItem(
        id: 'n7',
        title: 'Phân tích thị trường',
        message: 'Xu hướng xe điện tăng 35% trong quý này. Xem báo cáo đầy đủ.',
        timeLabel: '2 ngày trước',
        category: NotificationCategory.market,
        isRead: true,
      ),
      NotificationItem(
        id: 'n8',
        title: 'Cập nhật hệ thống',
        message:
            'Hệ thống sẽ bảo trì vào 23:00 tối nay. Thời gian bảo trì 1 giờ.',
        timeLabel: '3 ngày trước',
        category: NotificationCategory.system,
        isRead: true,
      ),
    ];
  }
}
