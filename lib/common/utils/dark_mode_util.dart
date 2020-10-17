import 'package:flutter/cupertino.dart';

import 'package:flutter_cyf/common/enum/theme_mode.dart';

class DarkModeUtil {
  static bool isDarkMode(BuildContext context, FThemeMode darkMode) {
    bool isDarkMode =
        MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    return darkMode == FThemeMode.dark ||
        (darkMode == FThemeMode.system && isDarkMode);
  }
}