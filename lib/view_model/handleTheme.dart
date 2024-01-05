import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quote/resources/constraints.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class HandleTheme extends GetxController {
  final String themeKey = Constraints.themeKey;
  final sharedPreferences = SharedPreferences.getInstance();
  Future<void> saveTheme(String theme) async {
    final sp = await sharedPreferences;
    sp.setString(themeKey, theme);
  }

  Future<String> getsaveTheme() async {
    final sp = await sharedPreferences;
    String? theme = sp.getString(themeKey);
    return theme ?? "";
  }

  Future<ThemeMode> getThemeMode() async {
    String theme = await getsaveTheme();
    switch (theme) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  changeTheme(String theme) async {
    saveTheme(theme);

    Get.changeThemeMode(await getThemeMode());
    update();
  }
}
