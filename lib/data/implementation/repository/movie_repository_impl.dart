import 'package:fithub_home_test/core/exceptions/exception.dart';
import 'package:fithub_home_test/core/repository/base_repository.dart';
import 'package:fithub_home_test/data/api/model/movie_detail.dart';
import 'package:fithub_home_test/data/api/model/movies.dart';
import 'package:fithub_home_test/data/api/query/favorite_query.dart';
import 'package:fithub_home_test/data/api/query/get_favorite_query.dart';
import 'package:fithub_home_test/data/api/query/movie_query.dart';
import 'package:fithub_home_test/data/api/repository/movie_repository.dart';
import 'package:fithub_home_test/data/implementation/local/entity/movie_detail_entity.dart';
import 'package:fithub_home_test/data/implementation/local/entity/movies_entity.dart';
import 'package:fithub_home_test/data/implementation/local/hive_database/favorite_movie_database.dart';
import 'package:fithub_home_test/data/implementation/local/hive_database/movie_detail_database.dart';
import 'package:fithub_home_test/data/implementation/local/hive_database/now_playing_movie_database.dart';
import 'package:fithub_home_test/data/implementation/remote/remote_api/movie_remote_api.dart';
import 'package:fithub_home_test/data/implementation/request_mapper/favorite_mapper.dart';
import 'package:fithub_home_test/data/implementation/request_mapper/get_favorite_mapper.dart';
import 'package:fithub_home_test/data/implementation/request_mapper/movie_mapper.dart';

class MovieRepositoryImpl extends BaseRepository implements MovieRepository {
  MovieRepositoryImpl(
    this._api,
    this._database,
    this._favoriteDatabase,
    this._nowPlayingDatabase,
    
  );
  final MovieRemoteApi _api;
  final MovieDetailDatabase _database;
  final FavoriteMovieDatabase _favoriteDatabase;
  final NowPlayingMovieDatabase _nowPlayingDatabase;

  @override
  Future<Movies> getFavoriteMovies(GetFavoriteQuery query) {
    return executeProcess(
      apiProcess: () async {
        return processApiCall(
          module: "movie",
          function: "api.getFavoriteMovies",
          call: () async {
            final response = await _api.getFavoriteMovies(query.page, query.toRequest().toJson());
            return response.toModel();
          }
        );
      },
      localProcess: () async {
        return processBox(
          module: "movie",
          function: "getFavoriteMovies",
          call: () async {
            final result = await _favoriteDatabase.getFavoriteMovies(query.page);
            return result?.toModel();
          }
        );
      },
      saveToLocal: (data) async {
        if (data.movies.isEmpty) return;
        processBox(
          module: "movie",
          function: "database.addFavoriteMovies",
          call: () async {
            await _favoriteDatabase.addFavoriteMovies(query.page, MoviesEntity.fromModel(data));
          }
        );
      }
    );
  }

  @override
  Future<MovieDetail> getMovieDetail(int id) {
    return executeProcess(
      apiProcess: () async {
        return processApiCall(
          module: "movie",
          function: "api.getMovieDetail",
          call: () async {
            final response = await _api.getMovieDetail(id);
            return response.toModel();
          }
        );
      },
      localProcess: () async {
        return processBox(
          module: "movie",
          function: "database.getMovieDetail",
          call: () async {
            final result = await _database.getMovieDetail(id);
            return result?.toModel();
          }
        );
      },
      saveToLocal: (data) async {
        processBox(
          module: "movie",
          function: "database.addMovieDetail",
          call: () async {
            await _database.addMovieDetail(id, MovieDetailEntity.fromModel(data));
          }
        );
      }
    );
  }

  @override
  Future<Movies> getMovies(MovieQuery query) {
    if (query.keyword?.isNotEmpty ?? false) {
      return processApiCall(
        module: "movie",
        function: "getMovies",
        call: () async {
          final response = await _api.searchMovie(query.toRequest().toJson());
          return response.toModel();
        }
      );
    }

    return executeProcess(
      apiProcess: () async {
        return processApiCall(
          module: "movie",
          function: "api.getMovies",
          call: () async {
            final response = await _api.getNowPlayingMovies(query.toRequest().toJson());
            return response.toModel();
          }
        );
      },
      localProcess: () async {
        return processBox(
          module: "movie",
          function: "database.getMovies",
          call: () async {
            final result = await _nowPlayingDatabase.getNowPlayingMovies(query.page);
            return result?.toModel();
          }
        );
      },
      saveToLocal: (data) async {
        if (data.movies.isEmpty) return;
        processBox(
          module: "movie",
          function: "database.addNowPlayingMovies",
          call: () async {
            await _nowPlayingDatabase.addNowPlayingMovies(query.page, MoviesEntity.fromModel(data));
          }
        );
      },
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