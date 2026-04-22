// ============================================================
// FILE: user_model.dart
// MÔ TẢ: Class chứa thông tin của một người dùng (User).
//        Dữ liệu này được parse từ JSON trả về bởi API Backend.
//        Dùng ở khắp nơi: Login, Profile, màn hình Dashboard, v.v.
// ============================================================

/// Class này đại diện cho 1 người dùng trong hệ thống.
/// Dữ liệu được lấy từ API POST /api/auth/login hoặc GET /api/auth/profile.
class UserModel {
  // --- Các trường dữ liệu của User ---

  /// ID duy nhất của người dùng (UUID từ PostgreSQL)
  final String id;

  /// Họ tên đầy đủ của người dùng
  final String name;

  /// Địa chỉ email (dùng để đăng nhập)
  final String email;

  /// Số điện thoại (có thể null nếu chưa cập nhật)
  final String? phone;

  /// Đường dẫn ảnh đại diện (có thể null)
  final String? avatar;

  /// Vai trò người dùng: 'admin', 'staff', 'manager'...
  final String? role;

  /// Ngày tạo tài khoản (parse từ chuỗi ISO 8601 của backend)
  final DateTime? createdAt;

  /// Ngày cập nhật cuối cùng
  final DateTime? updatedAt;

  // Constructor - bắt buộc phải có id, name, email
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatar,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  /// Hàm factory này nhận vào 1 Map JSON (từ response của API)
  /// và tạo ra 1 đối tượng UserModel.
  /// Ví dụ JSON backend trả về:
  /// {
  ///   "id": "abc-123",
  ///   "name": "Nguyen Van A",
  ///   "email": "a@gmail.com",
  ///   "phone": "0987654321",
  ///   "role": "admin"
  /// }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      // Đọc trường 'id', ép kiểu về String
      id: (json['id'] ?? '').toString(),

      // Đọc trường 'name'
      name: (json['name'] ?? '').toString(),

      // Đọc trường 'email'
      email: (json['email'] ?? '').toString(),

      // Các trường này có thể null nên không ép kiểu cứng
      phone: json['phone'] as String?,
      avatar: json['avatar'] as String?,
      role: json['role'] as String?,

      // Parse ngày tháng: Backend NodeJS trả về camelCase (createdAt)
      // Khi đọc từ storage (đã toJson) thì là snake_case (created_at)
      // => Thử cả 2 cách để đảm bảo luôn đọc được
      createdAt: _parseDate(json['createdAt'] ?? json['created_at']),
      updatedAt: _parseDate(json['updatedAt'] ?? json['updated_at']),
    );
  }

  /// Helper parse ngày tháng an toàn - không throw exception nếu null hoặc sai định dạng
  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    return DateTime.tryParse(value.toString());
  }

  /// Hàm này chuyển UserModel thành Map để lưu vào SharedPreferences (local storage).
  /// Khi đọc lại từ storage, ta dùng fromJson() để khôi phục object.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'role': role,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  /// Hàm này tạo bản sao UserModel với một số trường được thay đổi.
  /// Dùng khi cần cập nhật thông tin một phần (ví dụ: chỉ đổi avatar).
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? avatar,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // In ra thông tin User khi debug (dùng print)
  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, role: $role)';
  }
}
