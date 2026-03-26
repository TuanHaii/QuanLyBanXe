# MỤC TIÊU
Đảm bảo mã nguồn Flutter tuân thủ nghiêm ngặt các nguyên tắc OOP, Clean Architecture và dễ dàng bảo trì.

# NGUYÊN TẮC CỐT LÕI (STRICT RULES)
1. **Chia nhỏ Widget (Componentization):** KHÔNG BAO GIỜ viết toàn bộ giao diện trong một hàm `build()` duy nhất. Phải tách các thành phần UI (Buttons, Cards, TextFields) thành các Stateless/Stateful Widget riêng biệt đặt trong thư mục `lib/shared/widgets/`.
2. **Nguyên tắc SOLID:** Áp dụng triệt để. Mỗi class/widget chỉ đảm nhiệm một trách nhiệm duy nhất (Single Responsibility).
3. **Tách biệt Logic và UI:** KHÔNG viết logic gọi API, xử lý dữ liệu phức tạp bên trong Widget. Phải sử dụng State Management (Riverpod/Bloc/Provider) hoặc Controller pattern để tách biệt.
4. **Naming Convention:** - Tên Class, Enum, Typedef: `PascalCase`.
   - Tên biến, hàm, tham số: `camelCase`.
   - Tên file/thư mục: `snake_case`.
5. **An toàn kiểu dữ liệu (Type Safety):** Luôn khai báo rõ ràng kiểu dữ liệu cho biến và giá trị trả về của hàm. Sử dụng `final` và `const` ở mọi nơi có thể để tối ưu hiệu năng.