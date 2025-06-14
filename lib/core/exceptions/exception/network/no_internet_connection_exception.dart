import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fithub_home_test/core/exceptions/exception/core/core_exception.dart';
import 'package:fithub_home_test/core/exceptions/model/exception_info.dart';
import 'package:fithub_home_test/core/exceptions/model/exception_rule.dart';

class NoInternetConnectionException extends CoreException {
  NoInternetConnectionException({
    required this.module,
    required this.layer,
    required this.function,
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
  String get message => "No Internet Connection";

  @override
  Object? stackTrace;

  @override
  ExceptionInfo toInfo({String? title}) {
    return ExceptionInfo(
      title: title ?? "",
      description: "No Internet Connection at $function $code",
    );
  }

  static ExceptionRule rule({
    required String module,
    required String layer,
    required String function,
    Object? stackTrace,
  }) => ExceptionRule(
    predicate: (exception) => exception is DioException 
      && exception.type == DioExceptionType.connectionError 
      || exception is SocketException,
    transformer:
      (exception) => NoInternetConnectionException(
        module: module,
        layer: layer,
        function: function,
        stackTrace: stackTrace,
      ),
  );
}
