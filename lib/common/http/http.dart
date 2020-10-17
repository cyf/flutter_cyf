import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:flutter_cyf/common/app_manager.dart';
import 'package:flutter_cyf/common/http/interceptors/mi_interceptor.dart';
import 'package:flutter_cyf/common/constants/app_constants.dart';
import 'package:flutter_cyf/common/http/interceptors/base_interceptor.dart';

// 必须是顶层函数
_parseAndDecode(String response) {
  return jsonDecode(response);
}

_parseJson(String text) {
  return compute(_parseAndDecode, text);
}

class Http extends DioForNative {
  Http({bool isMiHttp = false}) {
    /// 初始化 加入app通用处理
    (transformer as DefaultTransformer).jsonDecodeCallback = _parseJson;
    interceptors
      ..addAll([
        !isMiHttp ? BaseInterceptor() : MiInterceptor(),
        DioCacheManager(CacheConfig(
                baseUrl: !isMiHttp
                    ? AppConstants.API_PREFIX
                    : AppConstants.MI_API_PREFIX,
                databaseName: 'AppCache',
                defaultMaxStale: Duration(days: 10)))
            .interceptor,
      ]);
    if(!AppManager().isProd) {
      interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
      ));
    }
  }
}

Map addParam(Map<String, String> data) {
  data['client_id'] = "180100031051";
  data['channel_id'] = "";
  data['webp'] = "1";
  return data;
}

/*
   * error统一处理
   */
void formatError(DioError e) {
  if (e.type == DioErrorType.CONNECT_TIMEOUT) {
    // It occurs when url is opened timeout.
    print("连接超时");
  } else if (e.type == DioErrorType.SEND_TIMEOUT) {
    // It occurs when url is sent timeout.
    print("请求超时");
  } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
    //It occurs when receiving timeout
    print("响应超时");
  } else if (e.type == DioErrorType.RESPONSE) {
    // When the server response, but with a incorrect status, such as 404, 503...
    print("出现异常");
  } else if (e.type == DioErrorType.CANCEL) {
    // When the request is cancelled, dio will throw a error with this type.
    print("请求取消");
  } else {
    //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
    print("未知错误");
  }
}
