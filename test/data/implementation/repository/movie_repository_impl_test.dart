import 'package:dio/dio.dart';
import 'package:fithub_home_test/core/exceptions/exception.dart';
import 'package:fithub_home_test/data/api/query/favorite_query.dart';
import 'package:fithub_home_test/data/api/query/get_favorite_query.dart';
import 'package:fithub_home_test/data/api/query/movie_query.dart';
import 'package:fithub_home_test/data/implementation/local/hive_database/favorite_movie_database.dart';
import 'package:fithub_home_test/data/implementation/local/hive_database/movie_detail_database.dart';
import 'package:fithub_home_test/data/implementation/local/hive_database/now_playing_movie_database.dart';
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
class MockFavoriteDatabase extends Mock implements FavoriteMovieDatabase {}
class MockNowPlayingDatabase extends Mock implements NowPlayingMovieDatabase {}

void main() {
  late MovieRepositoryImpl movieRepositoryImpl;
  final mockMovieRemoteApi = MockMovieRemoteApi();
  final mockMovieDetailDatabase = MockMovieDetailDatabase();
  final mockFavoriteDatabase = MockFavoriteDatabase();
  final mockNowPlayingDatabase = MockNowPlayingDatabase();

  setUp(() {
    registerFallbackValue(movieDetailEntityDummy);
    registerFallbackValue(moviesEntityDummy);
    movieRepositoryImpl = MovieRepositoryImpl(
      mockMovieRemoteApi,
      mockMovieDetailDatabase,
      mockFavoriteDatabase,
      mockNowPlayingDatabase,
    );
  });

  tearDown(() {
    reset(mockMovieRemoteApi);
    reset(mockMovieDetailDatabase);
    reset(mockFavoriteDatabase);
    reset(mockNowPlayingDatabase);
  });

  group('getFavoriteMovies', () { 
    final query = GetFavoriteQuery(accountId: 1, page: 1);
    test('when success and no changes should return movies', () async {
      //arrange
      final dummy = moviesDummy();
      when(() => mockMovieRemoteApi.getFavoriteMovies(any(), any())).thenAnswer((_) async => dummy);
      when(() => mockFavoriteDatabase.getFavoriteMovies(any())).thenAnswer((_) async => moviesEntityDummy);
    
      //act
      final result = await movieRepositoryImpl.getFavoriteMovies(query);
    
      //assert
      expect(result, dummy.toModel());
      verify(() => mockMovieRemoteApi.getFavoriteMovies(any(), any())).called(1);
      verify(() => mockFavoriteDatabase.getFavoriteMovies(any())).called(1);
      verifyNever(() => mockFavoriteDatabase.addFavoriteMovies(any(), any()));
    });

    test('when success and changes is present should return movies and save to local', () async {
      //arrange
      final dummy = moviesDummy(page: 2);
      when(() => mockMovieRemoteApi.getFavoriteMovies(any(), any())).thenAnswer((_) async => dummy);
      when(() => mockFavoriteDatabase.addFavoriteMovies(any(), any())).thenAnswer((_) async {});
      when(() => mockFavoriteDatabase.getFavoriteMovies(any())).thenAnswer((_) async => moviesEntityDummy);
    
      //act
      final result = await movieRepositoryImpl.getFavoriteMovies(query);
    
      //assert
      expect(result, dummy.toModel());
      verify(() => mockMovieRemoteApi.getFavoriteMovies(any(), any())).called(1);
      verify(() => mockFavoriteDatabase.addFavoriteMovies(any(), any())).called(1);
      verify(() => mockFavoriteDatabase.getFavoriteMovies(any())).called(1);
    });

    test('when no data should return empty list', () async {
      //arrange
      when(() => mockMovieRemoteApi.getFavoriteMovies(any(), any())).thenAnswer((_) async => MoviesResponse());
      when(() => mockFavoriteDatabase.getFavoriteMovies(any())).thenAnswer((_) async => null);
    
      //act
      final result = await movieRepositoryImpl.getFavoriteMovies(query);
    
      //assert
      expect(result.movies, []);
    });

    test('when no internet connection and no local data should throw NoInternetConnectionException', () async {
      //arrange
      final connectionError = DioException.connectionError(requestOptions: RequestOptions(), reason: "no internet");
      final exception = NoInternetConnectionException(module: "movie", layer: "R", function: "api.getFavoriteMovies");
      when(() => mockMovieRemoteApi.getFavoriteMovies(any(), any())).thenThrow(connectionError);
      when(() => mockFavoriteDatabase.getFavoriteMovies(any())).thenAnswer((_) async => null);
    
      //act & assert
      try {
        await movieRepositoryImpl.getFavoriteMovies(query);
      } on NoInternetConnectionException catch (e) {
        expect(e.toInfo().description, exception.toInfo().description);
      }
      verify(() => mockMovieRemoteApi.getFavoriteMovies(any(), any())).called(1);
      verify(() => mockFavoriteDatabase.getFavoriteMovies(any())).called(1);
      verifyNever(() => mockFavoriteDatabase.addFavoriteMovies(any(), any()));
    });

    test('when no internet connection and local data is present should return local data', () async {
      //arrange
      final dummy = moviesDummy();
      final connectionError = DioException.connectionError(requestOptions: RequestOptions(), reason: "no internet");
      when(() => mockMovieRemoteApi.getFavoriteMovies(any(), any())).thenThrow(connectionError);
      when(() => mockFavoriteDatabase.getFavoriteMovies(any())).thenAnswer((_) async => moviesEntityDummy);
    
      //act
      final result = await movieRepositoryImpl.getFavoriteMovies(query);
    
      //assert
      expect(result, dummy.toModel());
      verify(() => mockFavoriteDatabase.getFavoriteMovies(any())).called(1);
      verifyNever(() => mockFavoriteDatabase.addFavoriteMovies(any(), any()));
    });

    test('when failed should throw CoreException', () async {
      //arrange
      when(() => mockMovieRemoteApi.getFavoriteMovies(any(), any())).thenThrow(Exception());
    
      //act & assert
      try {
        await movieRepositoryImpl.getFavoriteMovies(query);
      } on CoreException catch (e) {
        expect(e, isA<CoreException>());
      }
    });
  });

  group('getMovieDetail', () { 
    const id = 1;
    test('when success and no changes in data should return movie detail', () async {
      //arrange
      final dummy = movieDetailDummy();
      when(() => mockMovieRemoteApi.getMovieDetail(any())).thenAnswer((_) async => dummy);
      when(() => mockMovieDetailDatabase.getMovieDetail(id)).thenAnswer((_) async => movieDetailEntityDummy);
    
      //act
      final result = await movieRepositoryImpl.getMovieDetail(id);
    
      //assert
      expect(result, dummy.toModel());
      verify(() => mockMovieRemoteApi.getMovieDetail(id)).called(1);
      verifyNever(() => mockMovieDetailDatabase.addMovieDetail(id, any()));
    });

    test('when success and changes is present in data should return movie detail and save to local', () async {
      //arrange
      final dummy = movieDetailDummy(budget: 100);
      when(() => mockMovieRemoteApi.getMovieDetail(any())).thenAnswer((_) async => dummy);
      when(() => mockMovieDetailDatabase.addMovieDetail(id, any())).thenAnswer((_) async {});
      when(() => mockMovieDetailDatabase.getMovieDetail(id)).thenAnswer((_) async => movieDetailEntityDummy);
    
      //act
      final result = await movieRepositoryImpl.getMovieDetail(id);
    
      //assert
      expect(result, dummy.toModel());
      verify(() => mockMovieRemoteApi.getMovieDetail(id)).called(1);
      verify(() => mockMovieDetailDatabase.addMovieDetail(id, any()));
    });

    test('when no internet connection and no local data should throw NoInternetConnectionException', () async {
      //arrange
      final connectionError = DioException.connectionError(requestOptions: RequestOptions(), reason: "no internet");
      final exception = NoInternetConnectionException(module: "movie", layer: "R", function: "api.getMovieDetail");
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
      final dummy = movieDetailDummy();
      final connectionError = DioException.connectionError(requestOptions: RequestOptions(), reason: "no internet");
      when(() => mockMovieRemoteApi.getMovieDetail(any())).thenThrow(connectionError);
      when(() => mockMovieDetailDatabase.getMovieDetail(id)).thenAnswer((_) async => movieDetailEntityDummy);
    
      //act
      final result = await movieRepositoryImpl.getMovieDetail(id);

      //assert
      expect(result, dummy.toModel());
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
    test('when success and no changes should return movies', () async {
      //arrange
      final dummy = moviesDummy();
      when(() => mockMovieRemoteApi.getNowPlayingMovies(any())).thenAnswer((_) async => dummy);
      when(() => mockNowPlayingDatabase.getNowPlayingMovies(any())).thenAnswer((_) async => moviesEntityDummy);
    
      //act
      final result = await movieRepositoryImpl.getMovies(query);
    
      //assert
      expect(result, dummy.toModel());
      verify(() => mockMovieRemoteApi.getNowPlayingMovies(any())).called(1);
      verify(() => mockNowPlayingDatabase.getNowPlayingMovies(any())).called(1);
      verifyNever(() => mockNowPlayingDatabase.addNowPlayingMovies(any(), any()));
      verifyNever(() => mockMovieRemoteApi.searchMovie(any()));
    });

    test('when success and changes is present should return movies and save to local', () async {
      //arrange
      final dummy = moviesDummy(page: 100);
      when(() => mockMovieRemoteApi.getNowPlayingMovies(any())).thenAnswer((_) async => dummy);
      when(() => mockNowPlayingDatabase.addNowPlayingMovies(any(), any())).thenAnswer((_) async {});
      when(() => mockNowPlayingDatabase.getNowPlayingMovies(any())).thenAnswer((_) async => moviesEntityDummy);
    
      //act
      final result = await movieRepositoryImpl.getMovies(query);
    
      //assert
      expect(result, dummy.toModel());
      verify(() => mockMovieRemoteApi.getNowPlayingMovies(any())).called(1);
      verify(() => mockNowPlayingDatabase.addNowPlayingMovies(any(), any()));
      verifyNever(() => mockMovieRemoteApi.searchMovie(any()));
    });

    test('when no data should return empty list', () async {
      //arrange
      when(() => mockMovieRemoteApi.getNowPlayingMovies(any())).thenAnswer((_) async => MoviesResponse());
      when(() => mockNowPlayingDatabase.getNowPlayingMovies(any())).thenAnswer((_) async => null);
    
      //act
      final result = await movieRepositoryImpl.getMovies(query);
    
      //assert
      expect(result.movies, []);
      verify(() => mockNowPlayingDatabase.getNowPlayingMovies(any())).called(1);
      verify(() => mockMovieRemoteApi.getNowPlayingMovies(any())).called(1);
      verifyNever(() => mockNowPlayingDatabase.addNowPlayingMovies(any(), any()));
      verifyNever(() => mockMovieRemoteApi.searchMovie(any()));
    });

    test('when no internet connection and no local data should throw NoInternetConnectionException', () async {
      //arrange
      final connectionError = DioException.connectionError(requestOptions: RequestOptions(), reason: "no internet");
      final exception = NoInternetConnectionException(module: "movie", layer: "R", function: "api.getMovies");
      when(() => mockMovieRemoteApi.getNowPlayingMovies(any())).thenThrow(connectionError);
      when(() => mockNowPlayingDatabase.getNowPlayingMovies(any())).thenAnswer((_) async => null);
    
      //act & assert
      try {
        await movieRepositoryImpl.getMovies(query);
      } on NoInternetConnectionException catch (e) {
        expect(e.toInfo().description, exception.toInfo().description);
      }
      verifyNever(() => mockNowPlayingDatabase.addNowPlayingMovies(any(), any()));
      verifyNever(() => mockMovieRemoteApi.searchMovie(any()));
    });

    test('when no internet connection and local data is present should return local data', () async {
      //arrange
      final dummy = moviesDummy();
      final connectionError = DioException.connectionError(requestOptions: RequestOptions(), reason: "no internet");
      when(() => mockMovieRemoteApi.getNowPlayingMovies(any())).thenThrow(connectionError);
      when(() => mockNowPlayingDatabase.getNowPlayingMovies(any())).thenAnswer((_) async => moviesEntityDummy);
    
      //act
      final result = await movieRepositoryImpl.getMovies(query);
    
      //assert
      expect(result, dummy.toModel());
      verify(() => mockMovieRemoteApi.getNowPlayingMovies(any())).called(1);
      verify(() => mockNowPlayingDatabase.getNowPlayingMovies(any())).called(1);
      verifyNever(() => mockNowPlayingDatabase.addNowPlayingMovies(any(), any()));
      verifyNever(() => mockMovieRemoteApi.searchMovie(any()));
    });

    test('when failed should throw CoreException', () async {
      //arrange
      when(() => mockMovieRemoteApi.getNowPlayingMovies(any())).thenThrow(Exception());
    
      //act & assert
      try {
        await movieRepositoryImpl.getMovies(query);
      } on CoreException catch (e) {
        expect(e, isA<CoreException>());
      }

      verifyNever(() => mockMovieRemoteApi.searchMovie(any()));
    });
  });

  group('getMovies with search', () { 
    final query = MovieQuery(page: 1, keyword: "keyword");
    test('when success should return movies', () async {
      //arrange
      final dummy = moviesDummy();
      when(() => mockMovieRemoteApi.searchMovie(any())).thenAnswer((_) async => dummy);
    
      //act
      final result = await movieRepositoryImpl.getMovies(query);
    
      //assert
      expect(result, dummy.toModel());
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