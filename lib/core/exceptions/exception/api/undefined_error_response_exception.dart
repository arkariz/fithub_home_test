import 'package:dio/dio.dart';
import 'package:fithub_home_test/core/exceptions/exception/common/general_exception.dart';
import 'package:fithub_home_test/core/exceptions/exception/core/core_exception.dart';
import 'package:fithub_home_test/core/exceptions/model/exception_info.dart';
import 'package:fithub_home_test/core/exceptions/model/exception_rule.dart';

class UndefinedErrorResponseException extends CoreException {
  UndefinedErrorResponseException({
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
  String get message => "Undefined Error Response Exception";

  Response<dynamic>? response;

  @override
  Object? stackTrace;

  @override
  ExceptionInfo toInfo({String? title}) {
    return ExceptionInfo(
      title: title ?? "",
      description: "${response?.statusCode} Undefined Error Response at $function $code",
    );
  }

  static ExceptionRule rule({
    required String module,
    required String layer,
    required String function,
    Object? stackTrace,
  }) => ExceptionRule(
    predicate: (exception) {
      return exception is DioException && exception.response?.data is! Map<String, dynamic>;
    },
    transformer: (exception) {
      if (exception is DioException) {
        return UndefinedErrorResponseException(
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
