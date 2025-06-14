import 'package:dio/dio.dart';
import 'package:fithub_home_test/core/network/constant/auth_header.dart';
import 'package:fithub_home_test/core/network/dio/dio_builder.dart';
import 'package:fithub_home_test/core/network/flavor/network_flavor.dart';
import 'package:fithub_home_test/core/network/interceptors/auth_header_interceptor.dart';
import 'package:fithub_home_test/core/network/interceptors/expired_token_interceptor.dart';
import 'package:fithub_home_test/core/network/interceptors/logging_inteceptor.dart';

class DioService {
  DioService();

  Dio createService(NetworkFlavor flavor) {
    return DioBuilder(flavor.baseUrl)
        .timeOut(
          connectTimeout: flavor.connectTimeout,
          receiveTimeout: flavor.receiveTimeout,
        )
        .addHeaders(AuthHeader.requiredApikey)
        .addInterceptor(ExpiredTokenInterceptor())
        .addInterceptor(AuthHeaderInterceptor())
        .addInterceptor(LoggingInterceptor())
        .build();
  }
}

