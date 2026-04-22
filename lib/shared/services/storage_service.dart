// Nap thu vien hoac module can thiet.
import 'dart:convert';
// Nap thu vien hoac module can thiet.
import 'package:shared_preferences/shared_preferences.dart';

// Nap thu vien hoac module can thiet.
import '../constants/app_constants.dart';

// Dinh nghia lop StorageService de gom nhom logic lien quan.
class StorageService {
  // Khai bao bien SharedPreferences de luu du lieu su dung trong xu ly.
  final SharedPreferences _prefs;

  // Khai bao constructor StorageService de khoi tao doi tuong.
  StorageService(this._prefs);

  // Token management
  // Khai bao bien saveToken de luu du lieu su dung trong xu ly.
  Future<void> saveToken(String token) async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await _prefs.setString(AppConstants.tokenKey, token);
  }

  // Dinh nghia ham getToken de xu ly nghiep vu tuong ung.
  String? getToken() {
    // Tra ve ket qua cho noi goi ham.
    return _prefs.getString(AppConstants.tokenKey);
  }

  // Khai bao bien removeToken de luu du lieu su dung trong xu ly.
  Future<void> removeToken() async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await _prefs.remove(AppConstants.tokenKey);
  }

  // User data management
  // Khai bao bien saveUserData de luu du lieu su dung trong xu ly.
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await _prefs.setString(AppConstants.userKey, jsonEncode(userData));
  }

  // Dinh nghia ham getUserData de xu ly nghiep vu tuong ung.
  Map<String, dynamic>? getUserData() {
    // Khai bao bien data de luu du lieu su dung trong xu ly.
    final data = _prefs.getString(AppConstants.userKey);
    // Kiem tra dieu kien de re nhanh xu ly.
    if (data != null) {
      // Tra ve ket qua cho noi goi ham.
      return jsonDecode(data) as Map<String, dynamic>;
    }
    // Tra ve ket qua cho noi goi ham.
    return null;
  }

  // Khai bao bien removeUserData de luu du lieu su dung trong xu ly.
  Future<void> removeUserData() async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await _prefs.remove(AppConstants.userKey);
  }

  // Theme management
  // Khai bao bien saveThemeMode de luu du lieu su dung trong xu ly.
  Future<void> saveThemeMode(String themeMode) async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await _prefs.setString(AppConstants.themeKey, themeMode);
  }

  // Dinh nghia ham getThemeMode de xu ly nghiep vu tuong ung.
  String? getThemeMode() {
    // Tra ve ket qua cho noi goi ham.
    return _prefs.getString(AppConstants.themeKey);
  }

  // Generic methods
  // Khai bao bien saveString de luu du lieu su dung trong xu ly.
  Future<void> saveString(String key, String value) async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await _prefs.setString(key, value);
  }

  // Dinh nghia ham getString de xu ly nghiep vu tuong ung.
  String? getString(String key) {
    // Tra ve ket qua cho noi goi ham.
    return _prefs.getString(key);
  }

  // Khai bao bien saveInt de luu du lieu su dung trong xu ly.
  Future<void> saveInt(String key, int value) async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await _prefs.setInt(key, value);
  }

  // Dinh nghia ham getInt de xu ly nghiep vu tuong ung.
  int? getInt(String key) {
    // Tra ve ket qua cho noi goi ham.
    return _prefs.getInt(key);
  }

  // Khai bao bien saveBool de luu du lieu su dung trong xu ly.
  Future<void> saveBool(String key, bool value) async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await _prefs.setBool(key, value);
  }

  // Dinh nghia ham getBool de xu ly nghiep vu tuong ung.
  bool? getBool(String key) {
    // Tra ve ket qua cho noi goi ham.
    return _prefs.getBool(key);
  }

  // Khai bao bien saveDouble de luu du lieu su dung trong xu ly.
  Future<void> saveDouble(String key, double value) async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await _prefs.setDouble(key, value);
  }

  // Dinh nghia ham getDouble de xu ly nghiep vu tuong ung.
  double? getDouble(String key) {
    // Tra ve ket qua cho noi goi ham.
    return _prefs.getDouble(key);
  }

  // Khai bao bien remove de luu du lieu su dung trong xu ly.
  Future<void> remove(String key) async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await _prefs.remove(key);
  }

  // Khai bao bien clearAll de luu du lieu su dung trong xu ly.
  Future<void> clearAll() async {
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await _prefs.clear();
  }

  // Khai bao bien containsKey de luu du lieu su dung trong xu ly.
  bool containsKey(String key) {
    // Tra ve ket qua cho noi goi ham.
    return _prefs.containsKey(key);
  }
}
