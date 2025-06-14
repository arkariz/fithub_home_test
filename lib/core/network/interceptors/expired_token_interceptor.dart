import 'package:dio/dio.dart';
import 'package:fithub_home_test/core/network/flavor/network_flavor.dart';
import 'package:get_it/get_it.dart';

// Interceptor that handles expired tokens and calls the onTokenExpired method of the network flavor.
class ExpiredTokenInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: adjust conditional expression based on actual API response & code
    if (err.response?.statusCode == 401) {
      //  Get the network flavor from the GetIt container
      GetIt.I.get<NetworkFlavor>().onTokenExpired();
    }

    // Continue with the request
    super.onError(err, handler);
  }
}
