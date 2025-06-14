import 'package:fithub_home_test/data/implementation/local/entity/movies_entity.dart';
import 'package:fithub_home_test/data/implementation/remote/response/movies_response.dart';

MoviesResponse moviesDummy({int page = 1}) => MoviesResponse(
  page: page,
  totalResults: 0,
  totalPages: 0,
  movies: [
    MovieResponse(
      adult: false,
      backdropPath: 'backdropPath',
      genreIds: [1],
      id: 1,
      originalLanguage: 'originalLanguage',
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 0,
      posterPath: 'posterPath',
      releaseDate: DateTime(0),
      title: 'title',
      video: false,
      voteAverage: 0,
      voteCount: 0,
    ),
    MovieResponse(
      adult: false,
      backdropPath: 'backdropPath2',
      genreIds: [1],
      id: 2,
      originalLanguage: 'originalLanguage2',
      originalTitle: 'originalTitle2',
      overview: 'overview2',
      popularity: 0,
      posterPath: 'posterPath2',
      releaseDate: DateTime(0),
      title: 'title2',
      video: false,
      voteAverage: 10,
      voteCount: 10,
    ),
  ],
);

MoviesEntity moviesEntityDummy = MoviesEntity.fromModel(moviesDummy().toModel());
