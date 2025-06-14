
import 'package:dio/dio.dart';
import 'package:fithub_home_test/core/network/constant/auth_header.dart';
import 'package:fithub_home_test/core/network/flavor/network_flavor.dart';
import 'package:get_it/get_it.dart';

/// Interceptor that adds the required auth header to the request based on the network flavor.
class AuthHeaderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Get the network flavor from the GetIt container
    final flavor = GetIt.I.get<NetworkFlavor>();

    // Check if the required auth header is present
    final authType = options.headers[AuthHeader.requiredAuth];
    options.headers.remove(AuthHeader.requiredAuth);

    // Set the API key header based on the auth type
    if (authType == AuthHeader.apikey || authType == AuthHeader.authApikey) {
      options.headers[AuthHeader.apikey] = flavor.apikey;
    }

    // Set the access token header based on the auth type
    if (authType == AuthHeader.authorization || authType == AuthHeader.authApikey) {
      options.headers[AuthHeader.authorization] = flavor.accessToken;
    }

    // Continue with the request
    return handler.next(options);
  }
}
