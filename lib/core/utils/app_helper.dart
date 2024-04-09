import 'package:flutter/material.dart';

import '../../config/app_locale.dart';

String convertLocaleStateToString(Locale locale) {
  return locale == AppLocale.persian ? "English" : "فارسی";
}


