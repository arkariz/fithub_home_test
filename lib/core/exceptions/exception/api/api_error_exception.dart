import 'package:dio/dio.dart';
import 'package:fithub_home_test/core/exceptions/exception/common/general_exception.dart';
import 'package:fithub_home_test/core/exceptions/exception/core/core_exception.dart';
import 'package:fithub_home_test/core/exceptions/model/exception_info.dart';
import 'package:fithub_home_test/core/exceptions/model/exception_rule.dart';
import 'package:fithub_home_test/core/exceptions/response/exception_response.dart';

class ApiErrorException extends CoreException {
  ApiErrorException({
    required this.module,
    required this.layer,
    required this.function,
    required this.response,
    this.stackTrace,
  });

  @override
  String module;

  @override
  String layer;

  @override
  String function;

  @override
  String get code => generatedCode();

  @override
  String get message => "API Error Exception";

  @override
  Object? stackTrace;

  Response<dynamic>? response;

  ExceptionResponse serialized() => ExceptionResponse.fromJson(response?.data ?? {});

  @override
  ExceptionInfo toInfo({String? title}) {
    final data = serialized();

    return ExceptionInfo(
      title: title ?? "",
      description: "${response?.statusCode} ${data.message} at $function $code",
    );
  }

  static ExceptionRule rule({
    required String module,
    required String layer,
    required String function,
    Object? stackTrace,
  }) => ExceptionRule(
    predicate: (exception) {
      return exception is DioException && exception.response?.data is Map<String, dynamic>;
    },
    transformer: (exception) {
      if (exception is DioException) {
        return ApiErrorException(
          module: module,
          layer: layer,
          function: function,
          response: exception.response,
          stackTrace: stackTrace,
        );
      }

      return GeneralException(module: module, layer: layer, function: function);
    },
  );
}
