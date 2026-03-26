**Mục đích:** Hướng dẫn AI cách viết commit message chuẩn chỉ và cách xử lý khi bạn yêu cầu "commit code".

```markdown
# MỤC TIÊU
Đảm bảo lịch sử Git sạch sẽ, dễ đọc và tuân thủ Conventional Commits.

# QUY TẮC VIẾT COMMIT MESSAGE
Khi được yêu cầu tạo commit message, hãy luôn dùng định dạng sau:
`<type>[optional scope]: <description>`

**Các `<type>` hợp lệ:**
- `feat`: Thêm một tính năng mới (vd: feat(auth): add biometric login)
- `fix`: Sửa lỗi (vd: fix(inventory): resolve crash when loading empty car list)
- `ui`: Cập nhật/Chỉnh sửa giao diện theo thiết kế (vd: ui(dashboard): apply dark pastel colors to stat cards)
- `refactor`: Viết lại code nhưng không làm thay đổi logic (vd: refactor: extract StatCard to shared widgets)
- `chore`: Cập nhật linh tinh, thư viện (vd: chore: update pubspec.yaml)

**Lưu ý:** Description phải viết bằng tiếng Anh ngắn gọn, bắt đầu bằng động từ nguyên thể, không viết hoa chữ cái đầu và không có dấu chấm ở cuối.