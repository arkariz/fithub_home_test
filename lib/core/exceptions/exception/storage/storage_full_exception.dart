import 'dart:io';
import 'package:fithub_home_test/core/exceptions/exception/core/core_exception.dart';
import 'package:fithub_home_test/core/exceptions/model/exception_info.dart';
import 'package:fithub_home_test/core/exceptions/model/exception_rule.dart';

class StorageFullException extends CoreException {
  StorageFullException({
    required this.module,
    required this.layer,
    required this.function,
    this.stackTrace,
  });

  @override
  String module;

  @override
  String get code => generatedCode();

  @override
  String function;

  @override
  String layer;

  @override
  String? get message => "Storage Full";

  @override
  Object? stackTrace;

  @override
  ExceptionInfo toInfo({String? title}) {
    return ExceptionInfo(
      title: title ?? "",
      description: "Storage Full at $function $code",
    );
  }

  static ExceptionRule rule({
    required String module,
    required String layer,
    required String function,
    Object? stackTrace,
  }) => ExceptionRule(
    predicate:
        (exception) =>
            exception is FileSystemException &&
            exception.osError?.message.contains("No space left") == true,
    transformer:
        (exception) => StorageFullException(
          module: module,
          layer: layer,
          function: function,
        ),
  );
}
