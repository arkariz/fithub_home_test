import 'package:fithub_home_test/core/exceptions/exception/core/core_exception.dart';
import 'package:fithub_home_test/core/exceptions/model/exception_info.dart';
import 'package:fithub_home_test/core/exceptions/model/exception_rule.dart';

class GeneralException extends CoreException {
  GeneralException({
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
  String get message => "General Exception";

  @override
  Object? stackTrace;

  @override
  ExceptionInfo toInfo({String? title}) {
    return ExceptionInfo(
      title: title ?? "",
      description: "Something went wrong at $function $code",
    );
  }

  static ExceptionRule rule({
    required String module,
    required String layer,
    required String function,
    Object? stackTrace,
  }) => ExceptionRule(
    predicate: (exception) => true,
    transformer:
      (exception) => GeneralException(
        module: module,
        layer: layer,
        function: function,
        stackTrace: stackTrace,
      ),
  );
}
