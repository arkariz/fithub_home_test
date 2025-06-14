import 'package:dio/dio.dart';
import 'package:dio_request_inspector/dio_request_inspector.dart';
import 'package:fithub_home_test/core/network/constant/auth_header.dart';
import 'package:fithub_home_test/core/network/dio/dio_builder.dart';
import 'package:fithub_home_test/core/network/flavor/network_flavor.dart';
import 'package:fithub_home_test/core/network/interceptors/auth_header_interceptor.dart';
import 'package:fithub_home_test/core/network/interceptors/expired_token_interceptor.dart';
import 'package:get_it/get_it.dart';

class DioService {
  DioService();

  Dio createService(NetworkFlavor flavor) {
    return DioBuilder(flavor.baseUrl)
        .timeOut(
          connectTimeout: flavor.connectTimeout,
          receiveTimeout: flavor.receiveTimeout,
        )
        .addHeaders(AuthHeader.requiredAuthorization)
        .addInterceptor(ExpiredTokenInterceptor())
        .addInterceptor(AuthHeaderInterceptor())
        .addInterceptor(GetIt.I<DioRequestInspector>().getDioRequestInterceptor())
        .build();
  }
}

