import 'package:fithub_home_test/core/exceptions/exception/core/core_exception.dart';
import 'package:fithub_home_test/core/exceptions/model/exception_info.dart';
import 'package:fithub_home_test/core/exceptions/model/exception_rule.dart';
import 'package:hive_ce/hive.dart';

class LocalStorageAlreadyOpenedException extends CoreException {
  LocalStorageAlreadyOpenedException({
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
  String? get message => "Local Storage Already Opened";

  @override
  Object? stackTrace;

  @override
  ExceptionInfo toInfo({String? title}) {
    return ExceptionInfo(
      title: title ?? "",
      description: "Local Storage Already Opened at $function $code",
    );
  }

  /// The rule covered error message below:
  /// Box "myBox" is already open
  /// Cannot open box "myBox". It is already open.
  /// HiveError: Box has already been opened.
  /// HiveError: Duplicate box name. The box is already open or has been initialized.
  /// HiveError: You cannot open the same box multiple times.
  static ExceptionRule rule({
    required String module,
    required String layer,
    required String function,
    Object? stackTrace,
  }) => ExceptionRule(
    predicate: (exception) {
      final regex = RegExp(
        r'\b(already open(ed)?|duplicate box name|cannot open the same box)\b',
        caseSensitive: false,
      );

      return exception is HiveError && regex.hasMatch(exception.message);
    },
    transformer:
      (exception) => LocalStorageAlreadyOpenedException(
        module: module,
        layer: layer,
        function: function,
      ),
  );
}
