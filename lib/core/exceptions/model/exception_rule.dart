import 'package:fithub_home_test/core/exceptions/exception/core/core_exception.dart';

typedef ExceptionPredicate = bool Function(Object error);
typedef ExceptionTransformer = CoreException Function(Object error);

class ExceptionRule {
  final ExceptionPredicate predicate;
  final ExceptionTransformer transformer;

  ExceptionRule({required this.predicate, required this.transformer});
}