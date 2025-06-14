import 'package:dio/dio.dart';
import 'package:fithub_home_test/core/exceptions/exception.dart';
import 'package:fithub_home_test/core/storage/storage.dart';
import 'package:fithub_home_test/data/api/repository/movie_repository.dart';
import 'package:fithub_home_test/data/implementation/local/entity/movie_detail_entity.dart';
import 'package:fithub_home_test/data/implementation/local/hive_database/movie_detail_database.dart';
import 'package:fithub_home_test/data/implementation/remote/remote_api/movie_remote_api.dart';
import 'package:fithub_home_test/data/implementation/repository/movie_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce/hive.dart';

Future<void> registerDataModule() async {
  final getIt = GetIt.instance;
  final encryptionCipher = await getIt.getAsync<HiveAesCipher>();
  final movieDetailDatabase = await Database.init<MovieDetailEntity>(name: "movie_detail", openDatabase: openBox, encryptionCipher: encryptionCipher);

  GetIt.I
    ..registerLazySingleton<MovieRemoteApi>(() => MovieRemoteApi(GetIt.I<Dio>()))
    ..registerLazySingleton<MovieDetailDatabase>(() => MovieDetailDatabase(movieDetailDatabase))
    ..registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(GetIt.I<MovieRemoteApi>(), GetIt.I<MovieDetailDatabase>()));
}