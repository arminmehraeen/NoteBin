import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/app_locale.dart';
import '../utils/constants.dart';

class StorageService {
  final SharedPreferences prefs;

  StorageService({required this.prefs});

  Future<void> saveThemeMode({required ThemeMode themeMode}) async {
    bool store = themeMode == ThemeMode.dark ? true : false;
    await prefs.setBool(Keys.themeMode, store);
  }

  ThemeMode loadThemeMode() {
    bool isDarkMode = prefs.getBool(Keys.themeMode) ?? false;
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> saveLocale({required Locale locale}) async {
    bool store = locale == AppLocale.persian ? true : false;
    await prefs.setBool(Keys.locale, store);
  }

  Locale loadLocale() {
    bool isPersian = prefs.getBool(Keys.locale) ?? false;
    return isPersian ? AppLocale.persian : AppLocale.english;
  }

  Future<void> saveToken({required String token}) async {
    await prefs.setString(Keys.token, token) ;
  }

  String? loadToken() {
    String? token = prefs.getString(Keys.token);
    return token ;
  }

  Future<void> saveUser({required String user}) async {
    await prefs.setString(Keys.user, user) ;
  }

  String? loadUser() => prefs.getString(Keys.user);

  removeToken() async {
    await prefs.remove(Keys.token);
    await prefs.remove(Keys.user);
  }

}
