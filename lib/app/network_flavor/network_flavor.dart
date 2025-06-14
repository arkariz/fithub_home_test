import 'package:get_it/get_it.dart';
import 'package:fithub_home_test/core/network/flavor/network_flavor.dart';

class MovieNetworkFlavor extends NetworkFlavor {
  @override
  String get baseUrl => 'https://api.themoviedb.org';

  @override
  String get apikey => 'api_key';

  @override
  String get accessToken => 'access_token';
  
  @override
  Duration get connectTimeout => const Duration(seconds: 10);
  
  @override
  Duration get receiveTimeout => const Duration(seconds: 10);

  @override
  Future<void> onTokenExpired() {
    throw UnimplementedError();
  }
  
  @override
  Future<void> setAccessToken(String token) {
    throw UnimplementedError();
  }
}

void registerNetworkFlavor() {
  GetIt.I.registerLazySingleton<NetworkFlavor>(() => MovieNetworkFlavor());
}