import 'package:flutter_cyf/common/enum/theme_mode.dart';
import 'package:flutter_cyf/common/mock/bottom_tabs.dart';

class IncreaseAction {
  final int count;

  IncreaseAction({this.count = 1});

  @override
  String toString() {
    return 'IncreaseAction{count: $count}';
  }
}

class DecreaseAction {
  final int count;

  DecreaseAction({this.count = 1});

  @override
  String toString() {
    return 'DecreaseAction{count: $count}';
  }
}

class DarkModeAction {
  final FThemeMode darkMode;

  DarkModeAction({this.darkMode = FThemeMode.system});

  @override
  String toString() {
    return 'DarkModeAction{darkMode: $darkMode}';
  }
}

class BottomTabAction {
  final List<Map<String, dynamic>> bottomTabs;

  BottomTabAction({this.bottomTabs = tabs});

  @override
  String toString() {
    return 'BottomTabAction{bottomTabs: $bottomTabs}';
  }
}

class L10nAction {
  final String localeName;

  L10nAction({this.localeName = ''});

  @override
  String toString() {
    return 'L10nAction{localeName: $localeName}';
  }
}

class AppIntroAction {
  final bool showAppIntro;

  AppIntroAction({this.showAppIntro = false});

  @override
  String toString() {
    return 'AppIntroAction{showAppIntro: $showAppIntro}';
  }
}
