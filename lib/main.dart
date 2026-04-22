// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';

// Nap thu vien hoac module can thiet.
import 'app.dart';
// Nap thu vien hoac module can thiet.
import 'shared/services/service_locator.dart';

// Khai bao bien main de luu du lieu su dung trong xu ly.
Future<void> main() async {
  // Thuc thi cau lenh hien tai theo luong xu ly.
  WidgetsFlutterBinding.ensureInitialized();
  // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
  await setupServiceLocator();
  // Goi ham de thuc thi tac vu can thiet.
  runApp(const MyApp());
}
