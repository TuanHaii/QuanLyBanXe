# COMMAND: generate-screen
# MÔ TẢ: Lệnh dùng để tạo một màn hình UI mới trong Flutter.

# WORKFLOW BẮT BUỘC KHI CHẠY LỆNH NÀY:
1. Hỏi người dùng màn hình này thuộc Feature nào để đặt đúng thư mục (`lib/features/.../screens/`).
2. Sử dụng `Scaffold` với `backgroundColor` chuẩn của hệ thống (Dark Theme).
3. Đảm bảo App Bar (nếu có) sử dụng hiệu ứng trong suốt hoặc màu tối đúng chuẩn.
4. Tách các phần tử UI phức tạp thành các class nội bộ (ví dụ: `_HeaderSection`, `_ItemList`) ngay trong file, hoặc đưa ra `shared/widgets/` nếu thấy cần thiết.
5. Không bao giờ nhét logic xử lý dữ liệu phức tạp vào hàm `build()`.
6. Luôn thêm hiệu ứng `InkWell` (ripple effect) cho các vùng có thể click.