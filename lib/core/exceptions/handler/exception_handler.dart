import 'package:fithub_home_test/core/exceptions/enum/exception_layer_code.dart';
import 'package:fithub_home_test/core/exceptions/exception/common/general_exception.dart';
import 'package:fithub_home_test/core/exceptions/model/exception_rule.dart';

typedef Call<T> = Future<T> Function();

Future<T> process<T>({
  required String module,
  required ExceptionLayerCode layer,
  required String function,
  required List<ExceptionRule> Function(Object?) rules,
  required Call<T> call,
}) async {
  try {
    return await call();
  } catch (e, stackTrace) {
    throw rules(stackTrace).firstWhere(
      (rule) => rule.predicate(e),
      orElse:
          () => GeneralException.rule(
            module: module,
            layer: layer.code,
            function: function,
            stackTrace: stackTrace,
          ),
    )
    .transformer(e);
  }
}
