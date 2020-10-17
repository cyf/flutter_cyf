
import 'package:flutter_cyf/common/enum/response_type.dart';
import 'package:flutter_cyf/common/model/result_model.dart';

class ResultModelUtils<T> {
  static ResultModel success(List items) {
    return new ResultModel(code: ResponseType.success, message: null, data: items);
  }

  static ResultModel failure(String msg) {
    return new ResultModel(code: ResponseType.failure, message: msg);
  }

  static ResultModel error(String msg) {
    return new ResultModel(code: ResponseType.error, message: msg);
  }
}
