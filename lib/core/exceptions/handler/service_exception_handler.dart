import 'package:fithub_home_test/core/exceptions/enum/exception_layer_code.dart';
import 'package:fithub_home_test/core/exceptions/exception/api/api_error_exception.dart';
import 'package:fithub_home_test/core/exceptions/exception/api/undefined_error_response_exception.dart';
import 'package:fithub_home_test/core/exceptions/exception/common/decode_failed_exception.dart';
import 'package:fithub_home_test/core/exceptions/exception/common/general_exception.dart';
import 'package:fithub_home_test/core/exceptions/exception/network/no_internet_connection_exception.dart';
import 'package:fithub_home_test/core/exceptions/handler/exception_handler.dart';
import 'package:fithub_home_test/core/exceptions/model/exception_rule.dart';

Future<T> processApiCall<T>({
  required String module,
  required String function,
  required Call<T> call,
}) {
  const layer = ExceptionLayerCode.repository;

  return process(
    module: module,
    layer: layer,
    function: function,
    rules: _rules(module: module, function: function, layer: layer),
    call: call,
  );
}

List<ExceptionRule> _rules({
  required String module,
  required String function,
  required ExceptionLayerCode layer,
}) => [
  NoInternetConnectionException.rule(
    module: module,
    layer: layer.code,
    function: function,
  ),
  DecodeFailedException.rule(
    module: module,
    layer: layer.code,
    function: function,
  ),
  ApiErrorException.rule(
    module: module,
    layer: layer.code,
    function: function,
  ),
  UndefinedErrorResponseException.rule(
    module: module,
    layer: layer.code,
    function: function,
  ),
  GeneralException.rule(module: module, layer: layer.code, function: function),
];
