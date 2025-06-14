import 'package:fithub_home_test/core/exceptions/exception.dart';
import 'package:fithub_home_test/data/api/model/movie_detail.dart';
import 'package:fithub_home_test/data/api/model/movies.dart';
import 'package:fithub_home_test/data/api/query/favorite_query.dart';
import 'package:fithub_home_test/data/api/query/get_favorite_query.dart';
import 'package:fithub_home_test/data/api/query/movie_query.dart';
import 'package:fithub_home_test/data/api/repository/movie_repository.dart';
import 'package:fithub_home_test/data/implementation/remote/remote_api/movie_remote_api.dart';
import 'package:fithub_home_test/data/implementation/request_mapper/favorite_mapper.dart';
import 'package:fithub_home_test/data/implementation/request_mapper/get_favorite_mapper.dart';
import 'package:fithub_home_test/data/implementation/request_mapper/movie_mapper.dart';

class MovieRepositoryImpl implements MovieRepository {
  MovieRepositoryImpl(this._api);
  final MovieRemoteApi _api;

  @override
  Future<Movies> getFavoriteMovies(GetFavoriteQuery query) {
    return processApiCall(
      module: "movie",
      function: "getFavoriteMovies",
      call: () async {
        final response = await _api.getFavoriteMovies(query.accountId, query.toRequest().toJson());
        return response.toModel();
      }
    );
  }

  @override
  Future<MovieDetail> getMovieDetail(int id) {
    // TODO: implement getMovieDetail
    throw UnimplementedError();
  }

  @override
  Future<Movies> getMovies(MovieQuery query) {
    return processApiCall(
      module: "movie",
      function: "getMovies",
      call: () async {
        if (query.keyword?.isNotEmpty ?? false) {
          final response = await _api.searchMovie(query.toRequest().toJson());
          return response.toModel();
        } else {
          final response = await _api.getNowPlayingMovies(query.toRequest().toJson());
          return response.toModel();
        }
      }
    );
  }

  @override
  Future<bool> updateFavorite(FavoriteQuery query) {
    return processApiCall(
      module: "movie",
      function: "updateFavorite",
      call: () async {
        final response = await _api.updateFavorite(query.accountId, query.toRequest().toJson());
        return response.success ?? false;
      }
    );
  }

  
}