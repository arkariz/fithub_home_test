import 'package:fithub_home_test/core/exceptions/exception/core/core_exception.dart';
import 'package:fithub_home_test/core/exceptions/model/exception_info.dart';
import 'package:fithub_home_test/core/exceptions/model/exception_rule.dart';

class DecodeFailedException extends CoreException {
  DecodeFailedException({
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
  String get message => "Failed encode/decode - Mismatched Type";

  @override
  Object? stackTrace;

  @override
  ExceptionInfo toInfo({String? title}) {
    return ExceptionInfo(
      title: title ?? "",
      description: "Failed encode/decode - Mismatched Type at $function $code",
    );
  }

  static ExceptionRule rule({
    required String module,
    required String layer,
    required String function,
    Object? stackTrace,
  }) => ExceptionRule(
    predicate: (exception) => _acceptableException.any((type) => exception.runtimeType == type),
    transformer:
      (exception) => DecodeFailedException(
        module: module,
        layer: layer,
        function: function,
        stackTrace: stackTrace,
      ),
  );

  static final _acceptableException = [FormatException, TypeError, RangeError];
}
