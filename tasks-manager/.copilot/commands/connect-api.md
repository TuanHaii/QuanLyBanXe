# COMMAND: connect-api
# MÔ TẢ: Lệnh dùng để tạo Service và Model giao tiếp với Backend REST API.

# WORKFLOW BẮT BUỘC KHI CHẠY LỆNH NÀY:
1. Yêu cầu người dùng cung cấp JSON response mẫu từ API (nếu chưa có).
2. Tạo file Data Model (vd: `car_model.dart`) chứa class tương ứng. BẮT BUỘC có hàm `fromJson` và `toJson`.
3. Tạo file Service (vd: `car_service.dart`) sử dụng thư viện `http` hoặc `dio`.
4. Viết hàm gọi API (GET, POST, v.v.) BẮT BUỘC bọc trong khối `try-catch`.
5. Trả về dữ liệu đã được parse (hoặc ném ra Custom Exception nếu có lỗi mạng/lỗi server).
6. Không bao giờ hardcode Base URL trực tiếp trong service, hãy lấy từ `AppConstants` hoặc biến môi trường.