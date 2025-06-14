import 'package:dio/dio.dart';
import 'package:fithub_home_test/core/exceptions/exception.dart';
import 'package:fithub_home_test/data/api/query/favorite_query.dart';
import 'package:fithub_home_test/data/api/query/get_favorite_query.dart';
import 'package:fithub_home_test/data/api/query/movie_query.dart';
import 'package:fithub_home_test/data/implementation/local/hive_database/movie_detail_database.dart';
import 'package:fithub_home_test/data/implementation/remote/remote_api/movie_remote_api.dart';
import 'package:fithub_home_test/data/implementation/remote/response/movies_response.dart';
import 'package:fithub_home_test/data/implementation/repository/movie_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'dummy/favorite_dummy.dart';
import 'dummy/movie_detail_dummy.dart';
import 'dummy/movies_dummy.dart';

class MockMovieRemoteApi extends Mock implements MovieRemoteApi {}
class MockMovieDetailDatabase extends Mock implements MovieDetailDatabase {}

void main() {
  late MovieRepositoryImpl movieRepositoryImpl;
  final mockMovieRemoteApi = MockMovieRemoteApi();
  final mockMovieDetailDatabase = MockMovieDetailDatabase();

  setUp(() {
    registerFallbackValue(movieDetailEntityDummy);
    movieRepositoryImpl = MovieRepositoryImpl(mockMovieRemoteApi, mockMovieDetailDatabase);
  });

  tearDown(() {
    reset(mockMovieRemoteApi);
    reset(mockMovieDetailDatabase);
  });

  group('getFavoriteMovies', () { 
    final query = GetFavoriteQuery(accountId: 1, page: 1);
    test('when success should return movies', () async {
      //arrange
      when(() => mockMovieRemoteApi.getFavoriteMovies(any(), any())).thenAnswer((_) async => moviesDummy);
    
      //act
      final result = await movieRepositoryImpl.getFavoriteMovies(query);
    
      //assert
      expect(result, moviesDummy.toModel());
    });

    test('when no data should return empty list', () async {
      //arrange
      when(() => mockMovieRemoteApi.getFavoriteMovies(any(), any())).thenAnswer((_) async => MoviesResponse());
    
      //act
      final result = await movieRepositoryImpl.getFavoriteMovies(query);
    
      //assert
      expect(result.movies, []);
    });

    test('when failed should throw CoreException', () async {
      //arrange
      final connectionError = DioException.connectionError(requestOptions: RequestOptions(), reason: "no internet");
      final exception = NoInternetConnectionException(module: "movie", layer: "R", function: "getFavoriteMovies");
      when(() => mockMovieRemoteApi.getFavoriteMovies(any(), any())).thenThrow(connectionError);
    
      //act & assert
      try {
        await movieRepositoryImpl.getFavoriteMovies(query);
      } on CoreException catch (e) {
        expect(e.toInfo().description, exception.toInfo().description);
      }
    });
  });

  group('getMovieDetail', () { 
    const id = 1;
    test('when success should return movie detail and save to local', () async {
      //arrange
      when(() => mockMovieRemoteApi.getMovieDetail(any())).thenAnswer((_) async => movieDetailDummy);
      when(() => mockMovieDetailDatabase.addMovieDetail(movieDetailDummy.id!, any())).thenAnswer((_) async {});
    
      //act
      final result = await movieRepositoryImpl.getMovieDetail(id);
    
      //assert
      expect(result, movieDetailDummy.toModel());
      verify(() => mockMovieRemoteApi.getMovieDetail(id)).called(1);
      verify(() => mockMovieDetailDatabase.addMovieDetail(id, any()));
    });

    test('when no internet connection and no local data should throw NoInternetConnectionException', () async {
      //arrange
      final connectionError = DioException.connectionError(requestOptions: RequestOptions(), reason: "no internet");
      final exception = NoInternetConnectionException(module: "movie", layer: "R", function: "getMovieDetail");
      when(() => mockMovieRemoteApi.getMovieDetail(any())).thenThrow(connectionError);
      when(() => mockMovieDetailDatabase.getMovieDetail(id)).thenAnswer((_) async => null);
    
      //act & assert
      try {
        await movieRepositoryImpl.getMovieDetail(id);
      } on NoInternetConnectionException catch (e) {
        expect(e.toInfo().description, exception.toInfo().description);
      }
      verifyNever(() => mockMovieDetailDatabase.addMovieDetail(id, any()));
    });

    test('when no internet connection and local data is present should return local data', () async {
      //arrange
      final connectionError = DioException.connectionError(requestOptions: RequestOptions(), reason: "no internet");
      when(() => mockMovieRemoteApi.getMovieDetail(any())).thenThrow(connectionError);
      when(() => mockMovieDetailDatabase.getMovieDetail(id)).thenAnswer((_) async => movieDetailEntityDummy);
    
      //act
      final result = await movieRepositoryImpl.getMovieDetail(id);

      //assert
      expect(result, movieDetailDummy.toModel());
      verify(() => mockMovieRemoteApi.getMovieDetail(id)).called(1);
      verify(() => mockMovieDetailDatabase.getMovieDetail(id)).called(1);
      verifyNever(() => mockMovieDetailDatabase.addMovieDetail(id, any()));
    });

    test('When failed should throw CoreException', () async {
      //arrange

      when(() => mockMovieRemoteApi.getMovieDetail(any())).thenThrow(Exception());
      when(() => mockMovieDetailDatabase.getMovieDetail(id)).thenAnswer((_) async => movieDetailEntityDummy);
    
      //act & assert
      try {
        await movieRepositoryImpl.getMovieDetail(id);
      } on CoreException catch (e) {
        expect(e, isA<CoreException>());
      }
      verifyNever(() => mockMovieDetailDatabase.addMovieDetail(id, any()));
    });
  });

  group('getMovies', () { 
    final query = MovieQuery(page: 1);
    test('when success should return movies', () async {
      //arrange
      when(() => mockMovieRemoteApi.getNowPlayingMovies(any())).thenAnswer((_) async => moviesDummy);
    
      //act
      final result = await movieRepositoryImpl.getMovies(query);
    
      //assert
      expect(result, moviesDummy.toModel());
      verifyNever(() => mockMovieRemoteApi.searchMovie(any()));
    });

    test('when no data should return empty list', () async {
      //arrange
      when(() => mockMovieRemoteApi.getNowPlayingMovies(any())).thenAnswer((_) async => MoviesResponse());
    
      //act
      final result = await movieRepositoryImpl.getMovies(query);
    
      //assert
      expect(result.movies, []);
      verifyNever(() => mockMovieRemoteApi.searchMovie(any()));
    });

    test('when failed should throw CoreException', () async {
      //arrange
      final connectionError = DioException.connectionError(requestOptions: RequestOptions(), reason: "no internet");
      final exception = NoInternetConnectionException(module: "movie", layer: "R", function: "getMovies");
      when(() => mockMovieRemoteApi.getNowPlayingMovies(any())).thenThrow(connectionError);
    
      //act & assert
      try {
        await movieRepositoryImpl.getMovies(query);
      } on CoreException catch (e) {
        expect(e.toInfo().description, exception.toInfo().description);
      }

      verifyNever(() => mockMovieRemoteApi.searchMovie(any()));
    });
  });

  group('getMovies with search', () { 
    final query = MovieQuery(page: 1, keyword: "keyword");
    test('when success should return movies', () async {
      //arrange
      when(() => mockMovieRemoteApi.searchMovie(any())).thenAnswer((_) async => moviesDummy);
    
      //act
      final result = await movieRepositoryImpl.getMovies(query);
    
      //assert
      expect(result, moviesDummy.toModel());
      verifyNever(() => mockMovieRemoteApi.getNowPlayingMovies(any()));
    });

    test('when no data should return empty list', () async {
      //arrange
      when(() => mockMovieRemoteApi.searchMovie(any())).thenAnswer((_) async => MoviesResponse());
    
      //act
      final result = await movieRepositoryImpl.getMovies(query);
    
      //assert
      expect(result.movies, []);
      verifyNever(() => mockMovieRemoteApi.getNowPlayingMovies(any()));
    });

    test('when failed should throw CoreException', () async {
      //arrange
      final connectionError = DioException.connectionError(requestOptions: RequestOptions(), reason: "no internet");
      final exception = NoInternetConnectionException(module: "movie", layer: "R", function: "getMovies");
      when(() => mockMovieRemoteApi.searchMovie(any())).thenThrow(connectionError);
    
      //act & assert
      try {
        await movieRepositoryImpl.getMovies(query);
      } on CoreException catch (e) {
        expect(e.toInfo().description, exception.toInfo().description);
      }

      verifyNever(() => mockMovieRemoteApi.getNowPlayingMovies(any()));
    });
  });

  group('updateFavorite', () { 
    final query = FavoriteQuery(accountId: 1, mediaId: 1, isFavorite: true);
    test('when success should return true', () async {
      //arrange
      when(() => mockMovieRemoteApi.updateFavorite(any(), any())).thenAnswer((_) async => favoriteDummy(true));
    
      //act
      final result = await movieRepositoryImpl.updateFavorite(query);
    
      //assert
      expect(result, true);
    });

    test('when failed should return false', () async {
      //arrange
      when(() => mockMovieRemoteApi.updateFavorite(any(), any())).thenAnswer((_) async => favoriteDummy(false));
    
      //act
      final result = await movieRepositoryImpl.updateFavorite(query);
    
      //assert
      expect(result, false);
    });

    test('when error should throw CoreException', () async {
      //arrange
      final connectionError = DioException.connectionError(requestOptions: RequestOptions(), reason: "no internet");
      final exception = NoInternetConnectionException(module: "movie", layer: "R", function: "updateFavorite");
      when(() => mockMovieRemoteApi.updateFavorite(any(), any())).thenThrow(connectionError);
    
      //act & assert
      try {
        await movieRepositoryImpl.updateFavorite(query);
      } on CoreException catch (e) {
        expect(e.toInfo().description, exception.toInfo().description);
      }
    });
  });
}