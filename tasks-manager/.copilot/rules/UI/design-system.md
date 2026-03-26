# MỤC TIÊU
Duy trì tính đồng nhất tuyệt đối về UI/UX theo phong cách "PRECISION Automotive Intelligence" (Premium Dark Theme).

# HỆ THỐNG THIẾT KẾ (DESIGN SYSTEM)
1. **Bảng màu (Color Palette):**
   - Background chính: `#0B0E14` (Deep Dark) hoặc dải Gradient tối màu.
   - Thẻ (Cards/Surfaces): `#1C1E24` (Dark Grey) với viền mờ `Colors.white.withOpacity(0.05)`.
   - Màu nhấn (Accent Colors): Xanh Neon `#4EE08F` (Tăng trưởng/Thành công), Đỏ Neon `#FF3B30` (Giảm/Hủy/Sold).
   - Màu chữ (Text): Trắng `#FFFFFF` cho tiêu đề, Xám nhạt `#A0AEC0` cho văn bản phụ.
2. **Typography:** Sử dụng Font chữ hiện đại, không chân (sans-serif) như `Inter` hoặc `Roboto`. Chữ cái tiêu đề các nút bấm (Buttons) thường viết hoa (UPPERCASE) và giãn cách chữ (letter-spacing).
3. **Hiệu ứng & Hoạt ảnh (Animations):**
   - Mọi nút bấm (Action Buttons, Quick Actions) PHẢI bọc trong `Material` và `InkWell` để có hiệu ứng gợn sóng (ripple effect).
   - Ô nhập liệu (TextFormField) sử dụng thiết kế tối giản, viền mờ, không có nền trắng chói.
   - Sử dụng Glassmorphism (độ trong suốt + mờ) cho các lớp phủ (Overlays) hoặc AppBars.
4. **Images:** Sử dụng ảnh chất lượng cao, bo góc (BorderRadius) mượt mà cho các thẻ hiển thị xe.