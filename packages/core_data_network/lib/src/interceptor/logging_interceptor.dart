import 'package:dio/dio.dart';

class LogginInterceptor extends Interceptor {
  final bool _logEnabled;

  LogginInterceptor(this._logEnabled);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_logEnabled)
      print(
          "[Dio] HTTP Request - ${options.method} ${options.baseUrl}${options.path}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (_logEnabled)
      print("[Dio] HTTP Response - ${response.statusCode} ${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) {
    if (_logEnabled) print("[Dio] HTTP Error - [${error.type}] ${error.error}");
    super.onError(error, handler);
  }
}
