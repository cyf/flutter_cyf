import 'package:json_annotation/json_annotation.dart';

import 'package:flutter_cyf/common/mock/bottom_tabs.dart';
import 'package:flutter_cyf/common/enum/theme_mode.dart';

part 'app_state.g.dart';

@JsonSerializable()
class AppState {
  final int counter;
  final FThemeMode darkMode;
  final List<Map<String, dynamic>> bottomTabs;
  final String localeName;
  final bool showAppIntro;

  AppState({
    this.counter = 0,
    this.darkMode = FThemeMode.system,
    this.bottomTabs = tabs,
    this.localeName = '',
    this.showAppIntro = true
  });

  AppState copyWith({
    int counter,
    bool darkMode,
    List<Map<String, dynamic>> bottomTabs,
    String localeName,
    bool showAppIntro,
  }) =>
      AppState(
        counter: counter ?? this.counter,
        darkMode: darkMode ?? this.darkMode,
        bottomTabs: bottomTabs ?? this.bottomTabs,
        localeName: localeName ?? this.localeName,
        showAppIntro: showAppIntro ?? this.showAppIntro,
      );

  static AppState fromJson(dynamic json) => json == null
      ? AppState()
      : _$AppStateFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$AppStateToJson(this);

  @override
  String toString() {
    return this.toJson().toString();
  }
}

var initialState = AppState();
