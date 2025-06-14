import 'package:dio/dio.dart';
import 'package:fithub_home_test/data/api/repository/movie_repository.dart';
import 'package:fithub_home_test/data/implementation/remote/remote_api/movie_remote_api.dart';
import 'package:fithub_home_test/data/implementation/repository/movie_repository_impl.dart';
import 'package:get_it/get_it.dart';

void registerDataModule() {
  GetIt.I
    ..registerLazySingleton<MovieRemoteApi>(() => MovieRemoteApi(GetIt.I<Dio>()))
    ..registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(GetIt.I<MovieRemoteApi>()));
}