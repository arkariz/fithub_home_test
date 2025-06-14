import 'package:dio/dio.dart';
import 'package:fithub_home_test/data/implementation/remote/response/favorite_response.dart';
import 'package:fithub_home_test/data/implementation/remote/response/movies_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'movie_remote_api.g.dart';

@RestApi()
abstract class MovieRemoteApi {
  factory MovieRemoteApi(Dio dio, {String baseUrl, ParseErrorLogger errorLogger}) = _MovieRemoteApi;

  @POST('/3/account/{account}/favorite')
  Future<FavoriteResponse> updateFavorite(
    @Path() int account,
    @Body() Map<String, dynamic> body,
  );

  @GET('/3/account/{account}/favorite/movies')
  Future<MoviesResponse> getFavoriteMovies(
    @Path() int account,
    @Queries() Map<String, dynamic> query,
  );

  @GET('/3/movie/now_playing')
  Future<MoviesResponse> getNowPlayingMovies(
    @Queries() Map<String, dynamic> query,
  );
}