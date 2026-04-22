// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';
// Nap thu vien hoac module can thiet.
import 'package:flutter_test/flutter_test.dart';

// Nap thu vien hoac module can thiet.
import 'package:shimmer/main.dart';

// Dinh nghia ham main de xu ly nghiep vu tuong ung.
void main() {
  // Goi ham de thuc thi tac vu can thiet.
  testWidgets('App launches successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await tester.pumpWidget(const MyApp());

    // Verify that the app builds without errors
    // Goi ham de thuc thi tac vu can thiet.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
