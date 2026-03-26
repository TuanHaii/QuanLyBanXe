# MỤC TIÊU
Duy trì cấu trúc thư mục dự án theo chuẩn Feature-First kết hợp Clean Architecture để dễ dàng mở rộng.

# CẤU TRÚC BẮT BUỘC (Mọi file tạo mới phải nằm đúng vị trí)
```text
lib/
├── core/               # Chứa các setup cốt lõi (routing, theme, error handling)
├── shared/             # Chứa code dùng chung toàn app
│   ├── widgets/        # Các UI component tái sử dụng (Buttons, Cards, Inputs)
│   ├── constants/      # AppColors, AppTextStyles, API endpoints
│   └── utils/          # Các hàm helper (format tiền tệ, ngày tháng)
├── features/           # Chứa các tính năng chính của app
│   ├── authentication/ # Tính năng Đăng nhập/Đăng ký
│   │   ├── models/     
│   │   ├── services/   # Gọi API backend liên quan đến Auth
│   │   ├── screens/    # Giao diện chính (LoginScreen, RegisterScreen)
│   │   └── widgets/    # UI component chỉ dùng riêng cho Auth
│   ├── dashboard/      # Tính năng Trang chủ/Tổng quan
│   ├── inventory/      # Tính năng Quản lý xe (Danh sách, Thêm, Sửa, Xóa)
│   └── sales/          # Tính năng Bán hàng/Hóa đơn