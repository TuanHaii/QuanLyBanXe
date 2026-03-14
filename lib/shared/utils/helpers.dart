/// Utility helper functions for the app

/// Format currency in Vietnamese Dong
String formatCurrency(double amount) {
  if (amount >= 1000000000) {
    return '${(amount / 1000000000).toStringAsFixed(1)} tỷ';
  } else if (amount >= 1000000) {
    return '${(amount / 1000000).toStringAsFixed(0)} triệu';
  }
  return '${amount.toStringAsFixed(0)} VNĐ';
}

/// Format phone number
String formatPhoneNumber(String phone) {
  if (phone.length == 10) {
    return '${phone.substring(0, 4)} ${phone.substring(4, 7)} ${phone.substring(7)}';
  }
  return phone;
}

/// Validate email format
bool isValidEmail(String email) {
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
}

/// Validate phone number format
bool isValidPhone(String phone) {
  return RegExp(r'^[0-9]{10,11}$').hasMatch(phone);
}

/// Get initials from name
String getInitials(String name) {
  final parts = name.trim().split(' ');
  if (parts.isEmpty) return '';
  if (parts.length == 1) return parts[0][0].toUpperCase();
  return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
}

/// Truncate text with ellipsis
String truncateText(String text, int maxLength) {
  if (text.length <= maxLength) return text;
  return '${text.substring(0, maxLength)}...';
}
