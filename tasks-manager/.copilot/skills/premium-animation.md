# SKILL: Premium UI Animations
# MỤC TIÊU: Áp dụng các hiệu ứng chuyển động mượt mà, tinh tế (micro-interactions).

# KỸ THUẬT CẦN ÁP DỤNG:
1. **Chuyển trang (Page Transitions):** Sử dụng `CupertinoPageRoute` hoặc custom transition (Fade, Slide từ dưới lên) thay vì hiệu ứng giật cục mặc định.
2. **Hero Animation:** Khi bấm vào một chiếc xe từ danh sách `Inventory` để xem chi tiết, BẮT BUỘC dùng `Hero` widget cho hình ảnh chiếc xe để tạo cảm giác xe "bay" sang màn hình mới.
3. **Implicit Animations:** Sử dụng `AnimatedContainer`, `AnimatedOpacity`, `AnimatedPadding` cho các thay đổi trạng thái nhỏ (ví dụ: khi nút bấm được active/inactive).
4. **Loading States:** Tuyệt đối không dùng `CircularProgressIndicator` mặc định ở giữa màn hình. Hãy dùng hiệu ứng "Shimmer" (xương rồng) màu xám tối cho các thẻ thông tin trong lúc chờ load dữ liệu từ API.