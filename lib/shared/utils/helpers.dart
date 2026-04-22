/// Utility helper functions for the app

/// Format currency in Vietnamese Dong
// Khai bao bien formatCurrency de luu du lieu su dung trong xu ly.
String formatCurrency(double amount) {
  // Kiem tra dieu kien de re nhanh xu ly.
  if (amount >= 1000000000) {
    // Tra ve ket qua cho noi goi ham.
    return '${(amount / 1000000000).toStringAsFixed(1)} tỷ';
  // Thuc thi cau lenh hien tai theo luong xu ly.
  } else if (amount >= 1000000) {
    // Tra ve ket qua cho noi goi ham.
    return '${(amount / 1000000).toStringAsFixed(0)} triệu';
  }
  // Tra ve ket qua cho noi goi ham.
  return '${amount.toStringAsFixed(0)} VNĐ';
}

/// Format phone number
// Khai bao bien formatPhoneNumber de luu du lieu su dung trong xu ly.
String formatPhoneNumber(String phone) {
  // Kiem tra dieu kien de re nhanh xu ly.
  if (phone.length == 10) {
    // Tra ve ket qua cho noi goi ham.
    return '${phone.substring(0, 4)} ${phone.substring(4, 7)} ${phone.substring(7)}';
  }
  // Tra ve ket qua cho noi goi ham.
  return phone;
}

/// Validate email format
// Khai bao bien isValidEmail de luu du lieu su dung trong xu ly.
bool isValidEmail(String email) {
  // Tra ve ket qua cho noi goi ham.
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
}

/// Validate phone number format
// Khai bao bien isValidPhone de luu du lieu su dung trong xu ly.
bool isValidPhone(String phone) {
  // Tra ve ket qua cho noi goi ham.
  return RegExp(r'^[0-9]{10,11}$').hasMatch(phone);
}

/// Get initials from name
// Khai bao bien getInitials de luu du lieu su dung trong xu ly.
String getInitials(String name) {
  // Khai bao bien parts de luu du lieu su dung trong xu ly.
  final parts = name.trim().split(' ');
  // Kiem tra dieu kien de re nhanh xu ly.
  if (parts.isEmpty) return '';
  // Kiem tra dieu kien de re nhanh xu ly.
  if (parts.length == 1) return parts[0][0].toUpperCase();
  // Tra ve ket qua cho noi goi ham.
  return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
}

/// Truncate text with ellipsis
// Khai bao bien truncateText de luu du lieu su dung trong xu ly.
String truncateText(String text, int maxLength) {
  // Kiem tra dieu kien de re nhanh xu ly.
  if (text.length <= maxLength) return text;
  // Tra ve ket qua cho noi goi ham.
  return '${text.substring(0, maxLength)}...';
}
