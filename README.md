# quan_ly_ban_xe_temp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Hướng dẫn chạy App kết nối với Backend Local

Do app sử dụng API nội bộ, bạn cần đảm bảo điện thoại và máy tính chạy Backend phải dùng chung một mạng WiFi.

### 1. Nếu chạy trên Máy ảo (Android Emulator)
Chỉ cần chạy lệnh bình thường, app sẽ tự lấy IP mặc định là `10.0.2.2`:
`flutter run`

### 2. Nếu chạy trên Điện thoại thật (Máy thật cắm cáp/WiFi)
**Bước 1:** Mở CMD trên máy tính đang chạy Backend (NodeJS), gõ `ipconfig` để lấy địa chỉ IPv4 (Ví dụ: `192.168.1.15`).
**Bước 2:** Chạy lệnh build kèm theo IP đó bằng cờ `--dart-define` như sau:

`flutter run --dart-define=API_BASE_URL=http://10.177.182.45:3000/api`

*(Lưu ý: Thay `192.168.1.15` bằng đúng IP máy tính của bạn)*