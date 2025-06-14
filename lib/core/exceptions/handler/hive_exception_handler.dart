import 'package:fithub_home_test/core/exceptions/enum/exception_layer_code.dart';
import 'package:fithub_home_test/core/exceptions/exception/common/decode_failed_exception.dart';
import 'package:fithub_home_test/core/exceptions/exception/common/general_exception.dart';
import 'package:fithub_home_test/core/exceptions/exception/storage/local_storage_already_opened_exception.dart';
import 'package:fithub_home_test/core/exceptions/exception/storage/local_storage_closed_exception.dart';
import 'package:fithub_home_test/core/exceptions/exception/storage/local_storage_corruption_exception.dart';
import 'package:fithub_home_test/core/exceptions/exception/storage/storage_full_exception.dart';
import 'package:fithub_home_test/core/exceptions/handler/exception_handler.dart';
import 'package:fithub_home_test/core/exceptions/model/exception_rule.dart';

Future<T> openBox<T>({
  required String module,
  required String function,
  required Call<T> call,
}) {
  const layer = ExceptionLayerCode.repository;

  return process(
    module: module,
    layer: layer,
    function: function,
    rules: _openRules(module: module, function: function, layer: layer),
    call: call,
  );
}

Future<T> processBox<T>({
  required String module,
  required String function,
  required Call<T> call,
}) {
  const layer = ExceptionLayerCode.repository;

  return process(
    module: module,
    layer: layer,
    function: function,
    rules: _operationRules(module: module, function: function, layer: layer),
    call: call,
  );
}

List<ExceptionRule> _openRules({
  required String module,
  required String function,
  required ExceptionLayerCode layer,
}) => [
  LocalStorageAlreadyOpenedException.rule(
    module: module,
    layer: layer.code,
    function: function,
  ),
];

List<ExceptionRule> _operationRules({
  required String module,
  required String function,
  required ExceptionLayerCode layer,
}) => [
  LocalStorageCorruptionException.rule(
    module: module,
    layer: layer.code,
    function: function,
  ),
  LocalStorageClosedException.rule(
    module: module,
    layer: layer.code,
    function: function,
  ),
  StorageFullException.rule(
    module: module,
    layer: layer.code,
    function: function,
  ),
  DecodeFailedException.rule(
    module: module,
    layer: layer.code,
    function: function,
  ),
  GeneralException.rule(module: module, layer: layer.code, function: function),
];
