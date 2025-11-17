import 'dart:convert';

import 'package:basic_project/base/logger.dart';
import 'package:dio/dio.dart';

class NetworkLogInterceptor extends Interceptor {
  final Logger _logger = Logger.withTag('Network');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.d('${options.method} ${options.uri}');
    if (options.headers.isNotEmpty) {
      _logger.d('Headers: ${options.headers}');
    }
    if (options.data != null) {
      _logger.d('Request Body: ${options.data}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.i(
      '${response.requestOptions.method} ${response.requestOptions.uri} - ${response.statusCode}',
    );
    if (response.data != null) {
      final dataStr =
          response.data is String ? response.data : jsonEncode(response.data);
      _logger.d('Response: $dataStr');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e(
      '${err.requestOptions.method} ${err.requestOptions.uri} - ${err.response?.statusCode ?? 'Error'}',
      error: err.error,
      stackTrace: err.stackTrace,
    );
    if (err.response?.data != null) {
      _logger.e('Error Response: ${err.response?.data}');
    }
    super.onError(err, handler);
  }
}
