// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultModel<T> _$ResultModelFromJson<T>(Map<String, dynamic> json) {
  return ResultModel<T>(
    code: _$enumDecodeNullable(_$ResponseTypeEnumMap, json['code']),
    message: json['message'] as String,
    data: (json['data'] as List)?.map(_Converter<T>().fromJson)?.toList(),
  );
}

Map<String, dynamic> _$ResultModelToJson<T>(ResultModel<T> instance) =>
    <String, dynamic>{
      'code': _$ResponseTypeEnumMap[instance.code],
      'message': instance.message,
      'data': instance.data?.map(_Converter<T>().toJson)?.toList(),
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

const _$ResponseTypeEnumMap = {
  ResponseType.success: 'success',
  ResponseType.failure: 'failure',
  ResponseType.error: 'error',
};
