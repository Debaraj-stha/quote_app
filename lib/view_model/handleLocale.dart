import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HandleLocale extends GetxController {
  static String key = "locale";
  final sharedPreferences = SharedPreferences.getInstance();
  Future<void> savedLocale(String locale) async {
    final sp = await sharedPreferences;
    sp.setString(key, locale);
  }

  Future<String> getSavedLocale() async {
    final sp = await sharedPreferences;
    String? locale = sp.getString(key);
    return locale ?? "";
  }

  Future<Locale> getLocale() async {
    String localeValue = await getSavedLocale();
    switch (localeValue) {
      case 'nepali':
        return const Locale('np', 'NPL');
      case 'english':
        return const Locale('hi', 'IN');

      default:
        return const Locale('en', 'US');
    }
  }

  changeLocale(String code, Locale locale) {
    savedLocale(code);
    print(code);
    print(locale.toString());
    Get.updateLocale(locale);
    update();
  }
}
