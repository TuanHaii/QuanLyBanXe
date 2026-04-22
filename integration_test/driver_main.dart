// ============================================================
// FILE: integration_test/driver_main.dart
// MÔ TẢ: Entry point riêng dùng để chạy Flutter Driver tests.
//        File này bật flutter_driver extension rồi mới gọi runApp.
//        KHÔNG dùng file này để chạy app thường ngày.
// Cách chạy test:
//   flutter drive --driver integration_test/driver_test.dart --target integration_test/driver_main.dart
// ============================================================

import 'package:flutter_driver/driver_extension.dart';

import 'package:quan_ly_ban_xe/main.dart' as app;

void main() {
  // Bật Flutter Driver extension để các test có thể điều khiển app
  enableFlutterDriverExtension();

  // Gọi main() của app bình thường
  app.main();
}
