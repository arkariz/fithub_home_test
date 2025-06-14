

import 'package:fithub_home_test/data/implementation/local/entity/movie_detail_entity.dart';
import 'package:fithub_home_test/data/implementation/remote/response/movie_detail_response.dart';

MovieDetailResponse movieDetailDummy({int budget = 100000}) => MovieDetailResponse(
  adult: false,
  budget: budget,
  genres: [GenreResponse(id: 1, name: 'name')],
  homepage: '',
  id: 1,
  imdbId: '',
  originalTitle: 'originalTitle',
  overview: 'overview',
  popularity: 0,
  posterPath: 'posterPath',
  productionCompanies: [ProductionCompanyResponse(id: 1, logoPath: 'logoPath', name: 'name', originCountry: 'originCountry')],
  releaseDate: DateTime(0),
  status: 'status',
  tagline: 'tagline',
  title: 'title',
  video: false,
  voteAverage: 0,
  voteCount: 0,
);

MovieDetailEntity movieDetailEntityDummy = MovieDetailEntity.fromModel(movieDetailDummy().toModel());
