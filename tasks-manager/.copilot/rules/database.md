# MỤC TIÊU
Đảm bảo an toàn bảo mật và chuẩn giao tiếp giữa Mobile App và Hệ thống Backend (PostgreSQL - Neon).

# NGUYÊN TẮC KẾT NỐI (STRICT RULES)
1. **CẤM KẾT NỐI DATABASE TRỰC TIẾP:** Tuyệt đối không bao giờ sử dụng các thư viện như `postgres` hoặc kết nối trực tiếp đến Neon Database từ code Flutter.
2. **Giao tiếp qua REST API:** Mọi thao tác lấy dữ liệu (GET), thêm (POST), sửa (PUT/PATCH), xóa (DELETE) đều phải thông qua HTTP requests gọi đến Backend API.
3. **Mô hình Dữ liệu (Data Models):**
   - Tạo các class Model trong Flutter (ví dụ: `Car`, `User`, `Invoice`) bám sát cấu trúc của Backend.
   - Bắt buộc sử dụng các phương thức `fromJson` và `toJson` (khuyến khích dùng thư viện `json_serializable` hoặc `freezed`) để ánh xạ dữ liệu.
   - Lưu ý: Backend EF Core trả về JSON với format `PascalCase` hoặc `camelCase` tùy cấu hình, cần map chính xác.
4. **Xử lý lỗi (Error Handling):** Bắt buộc phải có khối `try-catch` khi gọi API. Xử lý các mã lỗi HTTP (400, 401, 404, 500) trơn tru và hiển thị SnackBar/Dialog thân thiện cho người dùng.