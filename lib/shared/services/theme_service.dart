// Nap thu vien hoac module can thiet.
import 'package:flutter/material.dart';

// Nap thu vien hoac module can thiet.
import 'storage_service.dart';

// Dinh nghia lop ThemeService de gom nhom logic lien quan.
class ThemeService extends ChangeNotifier with WidgetsBindingObserver {
  // Khai bao bien const de luu du lieu su dung trong xu ly.
  static const String _manualDarkModeKey = 'manual_dark_mode_enabled';

  // Khai bao bien StorageService de luu du lieu su dung trong xu ly.
  final StorageService _storageService;

  // Thuc thi cau lenh hien tai theo luong xu ly.
  ThemeMode _themeMode = ThemeMode.system;
  // Khai bao bien _manualDarkModeEnabled de luu du lieu su dung trong xu ly.
  bool _manualDarkModeEnabled = true;

  // Goi ham de thuc thi tac vu can thiet.
  ThemeService({required StorageService storageService})
    // Thuc thi cau lenh hien tai theo luong xu ly.
    : _storageService = storageService {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    WidgetsBinding.instance.addObserver(this);
  }

  // Thuc thi cau lenh hien tai theo luong xu ly.
  ThemeMode get themeMode => _themeMode;

  // Khai bao bien get de luu du lieu su dung trong xu ly.
  bool get followSystemTheme => _themeMode == ThemeMode.system;

  // Khai bao bien get de luu du lieu su dung trong xu ly.
  bool get darkModeEnabled {
    // Kiem tra dieu kien de re nhanh xu ly.
    if (followSystemTheme) {
      // Tra ve ket qua cho noi goi ham.
      return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          // Thuc thi cau lenh hien tai theo luong xu ly.
          Brightness.dark;
    }
    // Tra ve ket qua cho noi goi ham.
    return _themeMode == ThemeMode.dark;
  }

  // Khai bao bien loadSettings de luu du lieu su dung trong xu ly.
  Future<void> loadSettings() async {
    // Gan gia tri cho bien _manualDarkModeEnabled.
    _manualDarkModeEnabled =
        // Thuc thi cau lenh hien tai theo luong xu ly.
        _storageService.getBool(_manualDarkModeKey) ?? true;

    // Khai bao bien storedMode de luu du lieu su dung trong xu ly.
    final storedMode = _parseThemeMode(_storageService.getThemeMode());
    // Gan gia tri cho bien _themeMode.
    _themeMode = storedMode;

    // Kiem tra dieu kien de re nhanh xu ly.
    if (storedMode == ThemeMode.dark) {
      // Gan gia tri cho bien _manualDarkModeEnabled.
      _manualDarkModeEnabled = true;
    // Thuc thi cau lenh hien tai theo luong xu ly.
    } else if (storedMode == ThemeMode.light) {
      // Gan gia tri cho bien _manualDarkModeEnabled.
      _manualDarkModeEnabled = false;
    }

    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await _storageService.saveBool(_manualDarkModeKey, _manualDarkModeEnabled);
    // Khai bao constructor notifyListeners de khoi tao doi tuong.
    notifyListeners();
  }

  // Khai bao bien setDarkModeEnabled de luu du lieu su dung trong xu ly.
  Future<void> setDarkModeEnabled(bool enabled) async {
    // Gan gia tri cho bien _manualDarkModeEnabled.
    _manualDarkModeEnabled = enabled;
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await _storageService.saveBool(_manualDarkModeKey, enabled);

    // Gan gia tri cho bien _themeMode.
    _themeMode = enabled ? ThemeMode.dark : ThemeMode.light;
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await _storageService.saveThemeMode(_themeMode.name);

    // Khai bao constructor notifyListeners de khoi tao doi tuong.
    notifyListeners();
  }

  // Khai bao bien setFollowSystemTheme de luu du lieu su dung trong xu ly.
  Future<void> setFollowSystemTheme(bool enabled) async {
    // Kiem tra dieu kien de re nhanh xu ly.
    if (enabled) {
      // Gan gia tri cho bien _themeMode.
      _themeMode = ThemeMode.system;
      // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
      await _storageService.saveThemeMode(ThemeMode.system.name);
      // Khai bao constructor notifyListeners de khoi tao doi tuong.
      notifyListeners();
      // Tra ve ket qua cho noi goi ham.
      return;
    }

    // Gan gia tri cho bien _themeMode.
    _themeMode = _manualDarkModeEnabled ? ThemeMode.dark : ThemeMode.light;
    // Cho tac vu bat dong bo hoan tat truoc khi chay tiep.
    await _storageService.saveThemeMode(_themeMode.name);
    // Khai bao constructor notifyListeners de khoi tao doi tuong.
    notifyListeners();
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Dinh nghia ham didChangePlatformBrightness de xu ly nghiep vu tuong ung.
  void didChangePlatformBrightness() {
    // Kiem tra dieu kien de re nhanh xu ly.
    if (followSystemTheme) {
      // Khai bao constructor notifyListeners de khoi tao doi tuong.
      notifyListeners();
    }
  }

  // Khai bao annotation cho phan tu ben duoi.
  @override
  // Dinh nghia ham dispose de xu ly nghiep vu tuong ung.
  void dispose() {
    // Thuc thi cau lenh hien tai theo luong xu ly.
    WidgetsBinding.instance.removeObserver(this);
    // Thuc thi cau lenh hien tai theo luong xu ly.
    super.dispose();
  }

  // Dinh nghia ham _parseThemeMode de xu ly nghiep vu tuong ung.
  ThemeMode _parseThemeMode(String? value) {
    // Bat dau re nhanh theo nhieu truong hop gia tri.
    switch (value) {
      // Xu ly mot truong hop cu the trong switch.
      case 'dark':
        // Tra ve ket qua cho noi goi ham.
        return ThemeMode.dark;
      // Xu ly mot truong hop cu the trong switch.
      case 'light':
        // Tra ve ket qua cho noi goi ham.
        return ThemeMode.light;
      // Xu ly mot truong hop cu the trong switch.
      case 'system':
      // Xu ly mac dinh khi khong khop case nao.
      default:
        // Tra ve ket qua cho noi goi ham.
        return ThemeMode.system;
    }
  }
}
