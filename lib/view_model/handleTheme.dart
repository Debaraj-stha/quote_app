import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController {
  final _storage = GetStorage();
  final key = "isDarkTheme";
  bool isSavedThemeMode() {
    return _storage.read(key) ?? false;
  }

  ThemeMode getThemeMode() {
    return isSavedThemeMode() ? ThemeMode.dark : ThemeMode.light;
  }

  void saveThemeMode(bool isDarkMode) {
    _storage.write(key, isDarkMode);
  }

  void changeThemeMode() {
    print(_storage.read(key));
    Get.changeThemeMode(isSavedThemeMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeMode(!isSavedThemeMode());
  }
}
