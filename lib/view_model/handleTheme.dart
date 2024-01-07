import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quote/resources/constraints.dart';
import 'package:shared_preferences/shared_preferences.dart';



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
    print("$theme");
    update();
  }
}
