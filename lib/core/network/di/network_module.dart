import 'package:dio/dio.dart';
import 'package:fithub_home_test/core/network/dio/dio_service.dart';
import 'package:fithub_home_test/core/network/flavor/network_flavor.dart';
import 'package:get_it/get_it.dart';

void registerDioService(NetworkFlavor flavor) {
  GetIt.I.registerLazySingleton<Dio>(() => DioService().createService(flavor));
}