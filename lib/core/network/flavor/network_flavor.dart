abstract class NetworkFlavor {
  String get baseUrl;
  String get imageBaseUrl;
  int get accountId;
  String get apikey;
  String? get accessToken;
  Duration get connectTimeout;
  Duration get receiveTimeout;

  Future<void> setAccessToken(String token);
  Future<void> onTokenExpired();
}