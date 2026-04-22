import 'package:flutter/material.dart';

import 'storage_service.dart';

class ThemeService extends ChangeNotifier with WidgetsBindingObserver {
  static const String _manualDarkModeKey = 'manual_dark_mode_enabled';

  final StorageService _storageService;

  ThemeMode _themeMode = ThemeMode.system;
  bool _manualDarkModeEnabled = true;

  ThemeService({required StorageService storageService})
    : _storageService = storageService {
    WidgetsBinding.instance.addObserver(this);
  }

  ThemeMode get themeMode => _themeMode;

  bool get followSystemTheme => _themeMode == ThemeMode.system;

  bool get darkModeEnabled {
    if (followSystemTheme) {
      return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  Future<void> loadSettings() async {
    _manualDarkModeEnabled =
        _storageService.getBool(_manualDarkModeKey) ?? true;

    final storedMode = _parseThemeMode(_storageService.getThemeMode());
    _themeMode = storedMode;

    if (storedMode == ThemeMode.dark) {
      _manualDarkModeEnabled = true;
    } else if (storedMode == ThemeMode.light) {
      _manualDarkModeEnabled = false;
    }

    await _storageService.saveBool(_manualDarkModeKey, _manualDarkModeEnabled);
    notifyListeners();
  }

  Future<void> setDarkModeEnabled(bool enabled) async {
    _manualDarkModeEnabled = enabled;
    await _storageService.saveBool(_manualDarkModeKey, enabled);

    _themeMode = enabled ? ThemeMode.dark : ThemeMode.light;
    await _storageService.saveThemeMode(_themeMode.name);

    notifyListeners();
  }

  Future<void> setFollowSystemTheme(bool enabled) async {
    if (enabled) {
      _themeMode = ThemeMode.system;
      await _storageService.saveThemeMode(ThemeMode.system.name);
      notifyListeners();
      return;
    }

    _themeMode = _manualDarkModeEnabled ? ThemeMode.dark : ThemeMode.light;
    await _storageService.saveThemeMode(_themeMode.name);
    notifyListeners();
  }

  @override
  void didChangePlatformBrightness() {
    if (followSystemTheme) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  ThemeMode _parseThemeMode(String? value) {
    switch (value) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }
}
