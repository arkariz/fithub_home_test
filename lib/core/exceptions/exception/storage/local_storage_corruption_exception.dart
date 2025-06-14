import 'package:fithub_home_test/core/exceptions/exception/core/core_exception.dart';
import 'package:fithub_home_test/core/exceptions/model/exception_info.dart';
import 'package:fithub_home_test/core/exceptions/model/exception_rule.dart';
import 'package:hive_ce/hive.dart';

class LocalStorageCorruptionException extends CoreException {
  LocalStorageCorruptionException({
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
  String? get message => "Local Storage Corruption";

  @override
  Object? stackTrace;

  @override
  ExceptionInfo toInfo({String? title}) {
    return ExceptionInfo(
      title: title ?? "",
      description: "Local Storage Corruption at $function $code",
    );
  }

  /// The rule covered error message below:
  /// Checksum of the box does not match
  /// Unexpected end of file
  /// Box contains unknown type id
  /// Corrupted or used with wrong encryption key
  /// This should not happen
  /// Invalid frame
  /// Frame length too large
  /// Unknown frame
  static ExceptionRule rule({
    required String module,
    required String layer,
    required String function,
    Object? stackTrace,
  }) => ExceptionRule(
    predicate: (exception) {
      final corruptionPatterns = [
        r'checksum.*does not match',
        r'unexpected end of file',
        r'unknown type id',
        r'wrong encryption key',
        r'this should not happen',
        r'box corruption detected',
        r'invalid box header',
        r'unrecognized data format',
      ];

      return exception is HiveError &&
        corruptionPatterns.any(
          (pattern) => RegExp(
            pattern,
            caseSensitive: false,
          ).hasMatch(exception.message),
        );
    },
    transformer:
      (exception) => LocalStorageCorruptionException(
        module: module,
        layer: layer,
        function: function,
      ),
  );
}
