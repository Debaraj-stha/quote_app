import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:quote/resources/constraints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HandleLocale extends GetxController {
  static String key = Constraints.localeKey;
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
      case 'ne':
        return const Locale('ne');
      case 'hi':
        return const Locale('hi');

      default:
        return const Locale('en');
    }
  }

  changeLocale(String code, Locale locale) {
    savedLocale(code);
    if (kDebugMode) {
      print("code $code");
      print("locale $locale");
    }
    Get.updateLocale(locale);
    update();
  }
}
