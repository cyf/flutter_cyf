import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_cyf/common/enum/response_type.dart';

part 'result_model.g.dart';

@JsonSerializable()
class ResultModel<T> {
  final ResponseType code;
  @JsonKey(nullable: true)
  final String message;
  @_Converter()
  final List<T> data;

  ResultModel({this.code = ResponseType.success, this.message, this.data = const []});

  factory ResultModel.fromJson(Map<String, dynamic> json) => _$ResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResultModelToJson(this);
}

class _Converter<T> implements JsonConverter<T, Object> {
  const _Converter();

  @override
  T fromJson(Object json) {
    if(json == null) return null;
    // This will only work if `json` is a native JSON type:
    //   num, String, bool, null, etc
    // *and* is assignable to `T`.
    return json as T;
  }

  @override
  Object toJson(T object) {
    // This will only work if `object` is a native JSON type:
    //   num, String, bool, null, etc
    // Or if it has a `toJson()` function`.
    return object;
  }
}
