import 'package:fithub_home_test/core/exceptions/exception.dart';
import 'package:fithub_home_test/core/repository/base_repository.dart';
import 'package:fithub_home_test/data/api/model/movie_detail.dart';
import 'package:fithub_home_test/data/api/model/movies.dart';
import 'package:fithub_home_test/data/api/query/favorite_query.dart';
import 'package:fithub_home_test/data/api/query/get_favorite_query.dart';
import 'package:fithub_home_test/data/api/query/movie_query.dart';
import 'package:fithub_home_test/data/api/repository/movie_repository.dart';
import 'package:fithub_home_test/data/implementation/local/entity/movie_detail_entity.dart';
import 'package:fithub_home_test/data/implementation/local/hive_database/movie_detail_database.dart';
import 'package:fithub_home_test/data/implementation/remote/remote_api/movie_remote_api.dart';
import 'package:fithub_home_test/data/implementation/request_mapper/favorite_mapper.dart';
import 'package:fithub_home_test/data/implementation/request_mapper/get_favorite_mapper.dart';
import 'package:fithub_home_test/data/implementation/request_mapper/movie_mapper.dart';

class MovieRepositoryImpl extends BaseRepository implements MovieRepository {
  MovieRepositoryImpl(this._api, this._database);
  final MovieRemoteApi _api;
  final MovieDetailDatabase _database;

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
    return executeProcess(
      apiProcess: () async {
        return processApiCall(
          module: "movie",
          function: "getMovieDetail",
          call: () async {
            final response = await _api.getMovieDetail(id);
            return response.toModel();
          }
        );
      },
      localProcess: () async {
        return processBox(
          module: "movie",
          function: "getMovieDetail",
          call: () async {
            final result = await _database.getMovieDetail(id);
            return result?.toModel();
          }
        );
      },
      saveToLocal: (data) async {
        await _database.addMovieDetail(id, MovieDetailEntity.fromModel(data));
      }
    );
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