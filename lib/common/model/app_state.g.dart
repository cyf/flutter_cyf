// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return AppState(
    counter: json['counter'] as int,
    darkMode: _$enumDecodeNullable(_$FThemeModeEnumMap, json['darkMode']),
    bottomTabs: (json['bottomTabs'] as List)
        ?.map((e) => e as Map<String, dynamic>)
        ?.toList(),
    localeName: json['localeName'] as String,
    showAppIntro: json['showAppIntro'] as bool,
  );
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'counter': instance.counter,
      'darkMode': _$FThemeModeEnumMap[instance.darkMode],
      'bottomTabs': instance.bottomTabs,
      'localeName': instance.localeName,
      'showAppIntro': instance.showAppIntro,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$FThemeModeEnumMap = {
  FThemeMode.system: 'system',
  FThemeMode.light: 'light',
  FThemeMode.dark: 'dark',
};
