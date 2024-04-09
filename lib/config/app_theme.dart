import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        primarySwatch: AppColor.main,
        useMaterial3: false,
        fontFamily: 'Vazir',
        brightness: Brightness.light,
      );

  static ThemeData get dark => ThemeData(
        primarySwatch: AppColor.main,
    useMaterial3: false,
        fontFamily: 'Vazir',
        brightness: Brightness.dark,
      );
}
