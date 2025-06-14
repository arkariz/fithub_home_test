import 'package:dio/dio.dart';
import 'package:fithub_home_test/core/exceptions/exception.dart';
import 'package:fithub_home_test/core/storage/storage.dart';
import 'package:fithub_home_test/data/api/repository/movie_repository.dart';
import 'package:fithub_home_test/data/implementation/local/entity/movie_detail_entity.dart';
import 'package:fithub_home_test/data/implementation/local/entity/movies_entity.dart';
import 'package:fithub_home_test/data/implementation/local/hive_database/favorite_movie_database.dart';
import 'package:fithub_home_test/data/implementation/local/hive_database/movie_detail_database.dart';
import 'package:fithub_home_test/data/implementation/local/hive_database/now_playing_movie_database.dart';
import 'package:fithub_home_test/data/implementation/remote/remote_api/movie_remote_api.dart';
import 'package:fithub_home_test/data/implementation/repository/movie_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce/hive.dart';

Future<void> registerDataModule() async {
  final getIt = GetIt.instance;
  final encryptionCipher = await getIt.getAsync<HiveAesCipher>();
  final movieDetailDatabase = await Database.init<MovieDetailEntity>(name: "movie_detail", openDatabase: openBox, encryptionCipher: encryptionCipher);
  final favoriteMovieDatabase = await Database.init<MoviesEntity>(name: "favorite_movie", openDatabase: openBox, encryptionCipher: encryptionCipher);
  final nowPlayingMovieDatabase = await Database.init<MoviesEntity>(name: "now_playing_movie", openDatabase: openBox, encryptionCipher: encryptionCipher);

  getIt
    ..registerLazySingleton<MovieRemoteApi>(() => MovieRemoteApi(getIt<Dio>()))
    ..registerLazySingleton<MovieDetailDatabase>(() => MovieDetailDatabase(movieDetailDatabase))
    ..registerLazySingleton<FavoriteMovieDatabase>(() => FavoriteMovieDatabase(favoriteMovieDatabase))
    ..registerLazySingleton<NowPlayingMovieDatabase>(() => NowPlayingMovieDatabase(nowPlayingMovieDatabase))
    ..registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(
        getIt<MovieRemoteApi>(),
        getIt<MovieDetailDatabase>(),
        getIt<FavoriteMovieDatabase>(),
        getIt<NowPlayingMovieDatabase>(),
      ));
}